-- Esta vista sirve para ver todos los historiales de productos que se han realizado hasta ahora.
-- ELiminación de vista por si existe ya
DROP VIEW IF EXISTS todotech.view_historial_precios_productos;
-- Creación de la vista
CREATE VIEW todotech.view_historial_precios_productos AS
SELECT 
    p.nombre_producto AS Producto,
    c.nombre_categoria AS Categoria,
    sc.nombre_subcategoria AS Subcategoria,
    hp.precio AS Precio,
    hp.fecha_cambio AS Fecha_de_Cambio
FROM historial_precio hp
JOIN producto p 
ON hp.id_producto = p.id_producto
JOIN subcategoria_producto sc
ON p.id_subcategoria = sc.id_subcategoria
JOIN categoria_producto c 
ON sc.id_categoria = c.id_categoria
ORDER BY hp.fecha_cambio DESC;

/*
-- Pruebas de funcionamiento de la vista
select * from view_historial_precios_productos;
*/

-- Esta vista sirve para ver todos los productos que tienen 1 o más en stock de forma ascendente.
-- ELiminación de vista por si existe ya
DROP VIEW IF EXISTS todotech.view_productos_disponibles;
-- Creación de la vista
CREATE VIEW todotech.view_productos_disponibles AS
SELECT 
    p.id_producto,
    p.nombre_producto,
    p.descripcion,
    p.sku,
    p.stock,
    p.estado,
    p.precio,
    m.nombre_marca,
    s.nombre_subcategoria
FROM producto p
JOIN marca_producto m 
ON p.id_marca = m.id_marca
JOIN subcategoria_producto s 
ON p.id_subcategoria = s.id_subcategoria
WHERE p.estado = 'En stock'
ORDER BY p.stock ASC;

/*
-- Pruebas de funcionamiento de la vista
select * from view_productos_disponibles;
*/

-- Esta vista sirve para ver los invenarios actuales por sucursales que llegase a tener la tienda.
-- ELiminación de vista por si existe ya
DROP VIEW IF EXISTS todotech.view_inventario_sucursal;
-- Creación de la vista
CREATE VIEW todotech.view_inventario_sucursal AS
SELECT 
    i.id_inventario,
    s.nombre_sucursal,
    p.nombre_producto,
    sc.nombre_subcategoria AS subcategoria,
    i.cantidad
FROM inventario_producto i
JOIN sucursal s 
ON i.id_sucursal = s.id_sucursal
JOIN producto p 
ON i.id_producto = p.id_producto
JOIN subcategoria_producto sc 
ON p.id_subcategoria = sc.id_subcategoria
ORDER BY s.nombre_sucursal, p.nombre_producto;

/*
-- Pruebas de funcionamiento de la vista
select * from view_inventario_sucursal;
*/

-- Esta vista sirve para mostrar solo los descuentos vigentes que estan asociados a un cliente.
-- ELiminación de vista por si existe ya
DROP VIEW IF EXISTS todotech.view_clientes_descuentos_activos;
-- Creación de la vista
CREATE VIEW todotech.view_clientes_descuentos_activos AS
SELECT 
    c.nombres AS Nombre,
    c.apellidos AS Apellido,
    c.email AS Correo,
    dc.nombre_descuento AS Descuento,
    dc.porcentaje AS Porcentaje,
    dc.fecha_inicio AS Fecha_Inicio,
    dc.fecha_termino AS Fecha_Termino
FROM cliente c
JOIN descuento_cliente dc
ON c.id_cliente = dc.id_cliente
WHERE dc.estado = 'Vigente'
ORDER BY dc.fecha_termino ASC;

/*
-- Pruebas de funcionamiento de la vista
Select * from view_clientes_descuentos_activos;
select * from descuento_cliente;
*/

-- Esta vista sirve para mostrar todos los pedidos pendientes en general.
-- ELiminación de vista por si existe ya
DROP VIEW IF EXISTS todotech.view_envios_pendientes;
-- Creación de la vista
CREATE VIEW todotech.view_envios_pendientes AS
SELECT 
    e.id_envio,
    e.estado_envio AS Estado,
    p.nombres AS Cliente,
    p.apellidos AS Apellido,
    e.fecha_empaquetado AS Fecha_Empaquetado,
    e.fecha_enviado AS Fecha_Enviado
FROM envio e
JOIN pedido ped
ON e.id_envio = ped.id_envio
JOIN cliente p
ON ped.id_cliente = p.id_cliente
WHERE e.estado_envio NOT IN ('Entregado', 'Cancelado')
ORDER BY e.estado_envio ASC, e.fecha_empaquetado DESC;

/*
-- Pruebas de funcionamiento de la vista
select * from view_envios_pendientes;
*/