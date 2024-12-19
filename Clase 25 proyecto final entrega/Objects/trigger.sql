-- Trigger para otorgar un descuento de bienvenida a nuevos clientes
-- ELiminación del trigger por si existe ya
DROP TRIGGER IF EXISTS todotech.tg_descuento_bienvenida;
-- Creación del trigger
DELIMITER //

CREATE TRIGGER todotech.tg_descuento_bienvenida
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO descuento_cliente (id_cliente, codigo_descuento, nombre_descuento, descripcion, porcentaje, estado, fecha_inicio, fecha_termino)
    VALUES (NEW.id_cliente, CONCAT('BIENVENIDA-', NEW.id_cliente), 'Descuento de Bienvenida', '10% de descuento en la primera compra', 10.0, 'Vigente', NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY));
END//

DELIMITER ;

/*
select * from cliente;
select * from descuento_cliente;
insert into cliente (rut, nombres, apellidos, estado, fecha_nacimiento, email, telefono, contrasena) values ('19123987-2', 'Alvaro Ernesto', 'Araya Sanchez', 'Habilitado', '1998-02-22', 'alvaroaraya726@gmail.com', '+56912345678', '1234567contrasenasegura');
*/




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


