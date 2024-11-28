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