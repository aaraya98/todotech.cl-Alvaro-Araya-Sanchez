-- Trigger para validar el stock actual vs el que esta comprando, si el stock es mayor dara error y alerta, si es menor pasara y si es igual al stock lo dejara en 0 y cambiara estado agotado.
-- ELiminación del trigger por si existe ya
DROP TRIGGER IF EXISTS todotech.tg_verificarstock_reducirstock_cambiarestado;
-- Creación del trigger
DELIMITER //

CREATE TRIGGER todotech.tg_verificarstock_reducirstock_cambiarestado
BEFORE INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;

    -- Obtener el stock actual del producto
    SELECT stock INTO stock_actual
    FROM producto
    WHERE id_producto = NEW.id_producto;

    -- Verificar si el stock es suficiente
    IF NEW.cantidad > stock_actual THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: La cantidad pedida excede el stock disponible.';
    ELSE
        -- Actualizar el stock descontando la cantidad solicitada
        UPDATE producto
        SET stock = stock_actual - NEW.cantidad
        WHERE id_producto = NEW.id_producto;

        -- Verificar si el stock restante es igual a 0
        IF (stock_actual - NEW.cantidad) = 0 THEN
            UPDATE producto
            SET estado = 'Agotado'
            WHERE id_producto = NEW.id_producto;
        END IF;
    END IF;
END//

DELIMITER ;

-- Pruebas de funcionamiento

-- insert into todotech.detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) values (1, 4, 11, 1499900.00);
-- insert into todotech.detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) values (1, 4, 8, 1499900.00);
-- insert into todotech.detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) values (1, 4, 2, 1499900.00);

-- select * from producto where id_producto = 4;






-- Trigger para registrar el ultimo precio de los productos despues de realizar alguna actualización en sus precios, solo se dispara si actualiza precio, no otro campo.
-- ELiminación del trigger por si existe ya
DROP TRIGGER IF EXISTS todotech.tg_historial_precio_productos;
-- Creación del trigger
DELIMITER //

CREATE TRIGGER todotech.tg_historial_precio_productos
AFTER UPDATE ON producto
FOR EACH ROW
BEGIN
    -- Solo registra el cambio si el precio ha sido modificado
    IF OLD.precio != NEW.precio THEN
        INSERT INTO historial_precio (id_producto, precio)
        VALUES (OLD.id_producto, OLD.precio);
    END IF;
END//

DELIMITER ;

-- Pruebas de funcionamiento

-- select * from producto where id_producto = 6;
-- select * from historial_precio where id_producto = 6;

-- UPDATE producto SET precio = 1299900.00 WHERE id_producto = 6;
-- UPDATE producto SET nombre_producto = 'PC Torre Corsair Vengeance ULTRA' WHERE id_producto = 6;

-- select * from producto where id_producto = 6;
-- select * from historial_precio where id_producto = 6;


