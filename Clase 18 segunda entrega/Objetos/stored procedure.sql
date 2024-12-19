-- Función para validar un descuento vigente para un cliente
-- ELiminación del procedimiento almacenado por si existe ya
DROP PROCEDURE IF EXISTS todotech.ProcesarPedidoCompleto;

DELIMITER //
-- Creación del procedimiento almacenado
CREATE PROCEDURE todotech.ProcesarPedidoCompleto(
    IN p_cliente_id INT,
    IN p_metodo_pago_id INT,
    IN p_tipo_documento ENUM('Boleta', 'Factura'),
    IN p_detalles JSON -- Formato: [{"id_producto": 1, "cantidad": 2}, ...]
)
BEGIN
    DECLARE pedido_id INT;
    DECLARE envio_id INT;
    DECLARE boleta_factura_id INT;
    DECLARE total DECIMAL(10, 2) DEFAULT 0.0;
    DECLARE producto_id INT;
    DECLARE cantidad INT;
    DECLARE precio_unitario DECIMAL(10, 2);
    DECLARE stock_actual INT;

    -- Manejador de errores para hacer rollback si algo falla
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK; -- Revertir la transacción en caso de error
        SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Transacción fallida por error SQL.';
    END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Paso 1: Calcular el total y validar el stock de los productos
    SELECT 
        SUM(p.precio * d.cantidad),
        MIN(p.stock >= d.cantidad)
    INTO total, stock_actual
    FROM JSON_TABLE(p_detalles, "$[*]" 
        COLUMNS(
            producto_id INT PATH "$.id_producto",
            cantidad INT PATH "$.cantidad"
        )) AS d
    JOIN producto p 
    ON p.id_producto = d.producto_id;

    IF stock_actual = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Uno o más productos tienen stock insuficiente.';
    END IF;

	-- Paso 2: Insertar una boleta o factura
    INSERT INTO boleta_factura (tipo)
    VALUES (p_tipo_documento);
    SET boleta_factura_id = LAST_INSERT_ID();

    -- Paso 3: Registrar el envío
    INSERT INTO envio (estado_envio, fecha_empaquetado, fecha_enviado, fecha_entregado)
    VALUES ('Pedido Recibido', NULL, NULL, NULL);
    SET envio_id = LAST_INSERT_ID();

    -- Paso 4: Crear el pedido
    INSERT INTO pedido (id_cliente, id_metodo_pago, id_boleta_factura, id_envio, monto_total)
    VALUES (p_cliente_id, p_metodo_pago_id, boleta_factura_id, envio_id, total);
    SET pedido_id = LAST_INSERT_ID();

    -- Paso 5: Insertar los detalles del pedido y descontar el stock
    INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario)
    SELECT 
        pedido_id, 
        d.producto_id, 
        d.cantidad, 
        p.precio
    FROM JSON_TABLE(p_detalles, "$[*]" 
        COLUMNS(
            producto_id INT PATH "$.id_producto",
            cantidad INT PATH "$.cantidad"
        )) AS d
    JOIN producto p ON p.id_producto = d.producto_id;

    -- Descontar stock de los productos
    UPDATE producto p
    JOIN JSON_TABLE(p_detalles, "$[*]" 
        COLUMNS(
            producto_id INT PATH "$.id_producto",
            cantidad INT PATH "$.cantidad"
        )) AS d
    ON p.id_producto = d.producto_id
    SET p.stock = p.stock - d.cantidad;

    -- Confirmar la transacción
    COMMIT;
END//

DELIMITER ;


-- Pruebas de funcionamiento del procedimiento almacenado
SELECT * FROM todotech.envio;
SELECT * FROM todotech.boleta_factura;
SELECT * FROM todotech.pedido;
SELECT * FROM todotech.detalle_pedido;
SELECT * FROM todotech.cliente WHERE id_cliente = 1;
SELECT * FROM todotech.metodo_pago WHERE id_metodo_pago = 2;
SELECT * FROM todotech.producto WHERE id_producto IN (2, 6);

CALL todotech.ProcesarPedidoCompleto(
    1,
    2,
    'Boleta',
    '[{"id_producto": 2, "cantidad": 4}, {"id_producto": 6, "cantidad": 1}]'
);