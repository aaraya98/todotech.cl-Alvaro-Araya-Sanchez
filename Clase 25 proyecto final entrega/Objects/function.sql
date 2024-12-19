-- Función para validar un descuento vigente para un cliente
-- ELiminación de la función por si existe ya
DROP FUNCTION IF EXISTS todotech.fx_validar_descuento_cliente;
-- Creación de la función
DELIMITER //

CREATE FUNCTION fx_validar_descuento_cliente(id_cliente_param INT, codigo_descuento_param VARCHAR(35))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE es_valido BOOLEAN;

    SELECT CASE
        WHEN COUNT(*) > 0 THEN TRUE
        ELSE FALSE
    END
    INTO es_valido
    FROM descuento_cliente dc
    WHERE dc.id_cliente = id_cliente_param
      AND dc.codigo_descuento = codigo_descuento_param
      AND dc.estado = 'Vigente'
      AND NOW() BETWEEN dc.fecha_inicio AND dc.fecha_termino;

    RETURN es_valido;
END//

DELIMITER ;

/*
-- Pruebas de funcionamiento del function
select * from cliente where id_cliente = 1;
select * from descuento_cliente where id_cliente = 1;
select fx_validar_descuento_cliente(1, "DESC10-OCT23");
*/


-- Función para calcular la edad de un cliente
-- ELiminación de la función por si existe ya
DROP FUNCTION IF EXISTS todotech.fx_calcular_edad_cliente;
-- Creación de la función
DELIMITER //

CREATE FUNCTION todotech.fx_calcular_edad_cliente(id_cliente_param INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE edad INT;

    SELECT TIMESTAMPDIFF(YEAR, c.fecha_nacimiento, CURDATE())
    INTO edad
    FROM cliente c
    WHERE c.id_cliente = id_cliente_param;

    RETURN edad;
END//

DELIMITER ;

/*
-- Pruebas de funcionamiento del function
select * from cliente where id_cliente = 1;
select fx_calcular_edad_cliente(1);
*/