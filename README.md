# todotech.cl-Alvaro-Araya-Sanchez
Una nueva pyme llamada todotech actualmente cuenta con una sucursal, pero aspira a tener más y realizar ventas web, por lo cual requiere de una pagina web ya que no cuenta con ninguna, la problemática principal es que tienen el front-end terminado, pero les falta todo el back-end, lo cual incluye la BBDD, la misma la solicitaron en el motor de MySQL, junto a su DER y el script de creación junto a sus relaciones.

# Documentación de la Base de Datos

Este documento describe las tablas y relaciones del sistema de base de datos diseñado para gestionar clientes, direcciones, descuentos, pedidos y boletas/facturas.

## 1. Tabla `cliente`
**Atributos:**
- `id_cliente` INT (PK): Identificador único del cliente.
- `rut_cliente` VARCHAR(12): RUT del cliente.
- `nombres` VARCHAR(25): Nombres del cliente.
- `apellidos` VARCHAR(40): Apellidos del cliente.
- `estado` ENUM(...): Estado del cliente.
- `fecha_nacimiento` DATE: Fecha de nacimiento del cliente.
- `email` VARCHAR(70): Correo electrónico del cliente.
- `telefono` VARCHAR(15): Teléfono del cliente.
- `fecha_registro` DATETIME: Fecha de registro del cliente en el sistema.

**Relaciones:**
- `cliente 1 - * pedido`: Un cliente puede tener múltiples pedidos.

---

## 2. Tabla `direccion`
**Atributos:**
- `id_direccion` INT (PK): Identificador único de la dirección.
- `id_cliente` INT (FK): Identificador del cliente asociado.
- `calle` VARCHAR(30): Calle de la dirección.
- `numero` VARCHAR(10): Número de la dirección.
- `comuna` VARCHAR(30): Comuna de la dirección.
- `region` VARCHAR(30): Región de la dirección.
- `código_postal` VARCHAR(10): Código postal de la dirección.

**Relaciones:**
- `direccion 1 - * cliente`: Una dirección puede estar asignada a uno o varios clientes.

---

## 3. Tabla `descuento_cliente`
**Atributos:**
- `id_descuento` INT (PK): Identificador único del descuento.
- `id_cliente` INT (FK): Identificador del cliente al que se asigna el descuento.
- `nombre_descuento` VARCHAR(100): Nombre del descuento.
- `descripcion` TEXT: Descripción del descuento.
- `porcentaje` DECIMAL(5, 2): Porcentaje de descuento.
- `estado` ENUM(...): Estado del descuento.
- `fecha_inicio` DATETIME: Fecha de inicio del descuento.
- `fecha_termino` DATETIME: Fecha de término del descuento.

**Relaciones:**
- `cliente 1 - * descuento_cliente`: Un cliente puede tener múltiples descuentos asignados.

---

## 4. Tabla `pedido`
**Atributos:**
- `id_pedido` INT (PK): Identificador único del pedido.
- `id_cliente` INT (FK): Identificador del cliente que realiza el pedido.
- `id_envio` INT (FK): Identificador del envío asociado.
- `id_metodo_pago` INT (FK): Identificador del método de pago utilizado.
- `id_boleta_factura` INT (FK): Identificador de la boleta o factura asociada al pedido.
- `fecha_pedido` DATETIME: Fecha en que se realizó el pedido.
- `monto_total` DECIMAL(10, 2): Monto total del pedido.

**Relaciones:**
- `cliente 1 - * pedido`: Un cliente puede realizar múltiples pedidos.
- `pedido 1 - 1 boleta_factura`: Cada pedido tiene una boleta o factura única.

---

## 5. Tabla `boleta_factura`
**Atributos:**
- `id_boleta_factura` INT (PK): Identificador único de la boleta o factura.
- `id_pedido` INT (FK): Identificador del pedido asociado.
- `fecha_emision` DATETIME: Fecha de emisión de la boleta o factura.

**Relaciones:**
- `pedido 1 - 1 boleta_factura`: Cada boleta o factura corresponde a un único pedido.

---

## 6. Tabla `envio`
**Atributos:**
- `id_envio` INT (PK): Identificador único del envío.
- `id_pedido` INT (FK): Identificador del pedido asociado al envío.
- `estado_envio` ENUM(...): Estado del envío.
- `fecha_entrega_estimada` DATETIME: Fecha estimada de entrega.
- `fecha_entrega_real` DATETIME: Fecha real de entrega.

**Relaciones:**
- `pedido 1 - 1 envio`: Cada pedido tiene un único envío asociado.

---

## 7. Tabla `metodo_pago`
**Atributos:**
- `id_metodo_pago` INT (PK): Identificador único del método de pago.
- `nombre_metodo` VARCHAR(50): Nombre del método de pago.

**Relaciones:**
- `metodo_pago 1 - * pedido`: Un método de pago puede estar asociado con múltiples pedidos.

---

## 8. Tabla `empleado`
**Atributos:**
- `id_empleado` INT (PK): Identificador único del empleado.
- `id_sucursal` INT (FK): Identificador de la sucursal asociada.
- `rut` VARCHAR(12): RUT del empleado.
- `nombres` VARCHAR(25): Nombres del empleado.
- `apellidos` VARCHAR(40): Apellidos del empleado.
- `estado` ENUM(...): Estado del empleado.
- `fecha_nacimiento` DATE: Fecha de nacimiento del empleado.
- `telefono` VARCHAR(15): Teléfono del empleado.
- `email` VARCHAR(70): Correo electrónico del empleado.
- `calle` VARCHAR(30): Calle de la dirección del empleado.
- `numero` VARCHAR(10): Número de la dirección.
- `comuna` VARCHAR(30): Comuna de la dirección.
- `region` VARCHAR(30): Región de la dirección.
- `estado_civil` ENUM(...): Estado civil del empleado.
- `contrasena` VARCHAR(25): Contraseña del empleado.
- `cargo` VARCHAR(80): Cargo del empleado.
- `fecha_ingreso` DATE: Fecha de ingreso del empleado.
- `sueldo` DECIMAL(10, 2): Sueldo del empleado.

**Relaciones:**
- `sucursal 1 - * empleado`: Una sucursal puede tener múltiples empleados.

---

## 9. Tabla `rol_empleado`
**Atributos:**
- `id_rol` INT (PK): Identificador único del rol.
- `nombre_rol` VARCHAR(100): Nombre del rol.

**Relaciones:**
- `rol_empleado 1 - * empleado_rol`: Un rol puede asignarse a múltiples empleados.

---

## 10. Tabla `empleado_rol`
**Atributos:**
- `id_empleado_rol` INT (PK): Identificador único de la asignación del rol al empleado.
- `id_empleado` INT (FK): Identificador del empleado.
- `id_rol` INT (FK): Identificador del rol asignado.
- `fecha_asignacion` DATETIME: Fecha de asignación del rol al empleado.

**Relaciones:**
- `empleado 1 - * empleado_rol`: Un empleado puede tener múltiples roles asignados.

---

## 11. Tabla `rol_permiso`
**Atributos:**
- `id_rol_permiso` INT (PK): Identificador único de la asignación de permiso al rol.
- `id_rol` INT (FK): Identificador del rol.
- `id_permiso` INT (FK): Identificador del permiso.
- `fecha_asignacion` DATETIME: Fecha de asignación del permiso al rol.

**Relaciones:**
- `rol_empleado 1 - * rol_permiso`: Un rol puede tener múltiples permisos asignados.
- `permiso_empleado 1 - * rol_permiso`: Un permiso puede estar asociado a múltiples roles.

---

## 12. Tabla `permiso_empleado`
**Atributos:**
- `id_permiso_empleado` INT (PK): Identificador único del permiso.
- `nombre_permiso` VARCHAR(100): Nombre del permiso.

**Relaciones:**
- `permiso_empleado 1 - * rol_permiso`: Un permiso puede estar asignado a múltiples roles.

---

## 13. Tabla `pedido_empleado`
**Atributos:**
- `id_pedido_empleado` INT (PK): Identificador único de la asignación del pedido al empleado.
- `id_pedido` INT (FK): Identificador del pedido.
- `id_empleado` INT (FK): Identificador del empleado.
- `fecha_movimiento` DATETIME: Fecha en que el empleado gestionó el pedido.

**Relaciones:**
- `pedido 1 - * pedido_empleado`: Un pedido puede ser gestionado por múltiples empleados.
- `empleado 1 - * pedido_empleado`: Un empleado puede gestionar múltiples pedidos.

---

## 14. Tabla `producto`
**Atributos:**
- `id_producto` INT (PK): Identificador único del producto.
- `id_categoria` INT (FK): Identificador de la categoría asociada.
- `id_marca` INT (FK): Identificador de la marca asociada.
- `nombre_producto` VARCHAR(120): Nombre del producto.
- `descripcion` TEXT: Descripción del producto.
- `sku` VARCHAR(20): Código SKU del producto.
- `stock` INT: Cantidad de unidades en stock.
- `estado` ENUM(...): Estado del producto.
- `precio` DECIMAL(10, 2): Precio del producto.

**Relaciones:**
- `categoria_producto 1 - * producto`: Una categoría puede contener múltiples productos.
- `marca_producto 1 - * producto`: Una marca puede tener múltiples productos.

---

## 15. Tabla `categoria_producto`
**Atributos:**
- `id_categoria` INT (PK): Identificador único de la categoría.
- `nombre_categoria` VARCHAR(50): Nombre de la categoría.
- `descripcion` TEXT: Descripción de la categoría.

**Relaciones:**
- `categoria_producto 1 - * producto`: Una categoría puede tener múltiples productos.

---

## 16. Tabla `marca_producto`
**Atributos:**
- `id_marca` INT (PK): Identificador único de la marca.
- `nombre_marca` VARCHAR(100): Nombre de la marca.

**Relaciones:**
- `marca_producto 1 - * producto`: Una marca puede tener múltiples productos.

---

## 17. Tabla `descuento_producto`
**Atributos:**
- `id_descuento_producto` INT (PK): Identificador único del descuento para el producto.
- `id_producto` INT (FK): Identificador del producto asociado.
- `nombre_descuento` VARCHAR(100): Nombre del descuento.
- `descripcion` TEXT: Descripción del descuento.
- `porcentaje` DECIMAL(3, 1): Porcentaje de descuento.
- `estado` ENUM(...): Estado del descuento.
- `fecha_inicio` DATETIME: Fecha de inicio del descuento.
- `fecha_termino` DATETIME: Fecha de término del descuento.

**Relaciones:**
- `producto 1 - * descuento_producto`: Un producto puede tener múltiples descuentos.

---

## 18. Tabla `historial_precio`
**Atributos:**
- `id_historial` INT (PK): Identificador único del historial de precios.
- `id_producto` INT (FK): Identificador del producto.
- `precio` DECIMAL(10, 2): Precio del producto.
- `fecha_cambio` DATETIME: Fecha del cambio de precio.

**Relaciones:**
- `producto 1 - * historial_precio`: Un producto puede tener múltiples registros de cambio de precio.

---

## 19. Tabla `inventario_producto`
**Atributos:**
- `id_inventario` INT (PK): Identificador único del inventario.
- `id_producto` INT (FK): Identificador del producto.
- `id_sucursal` INT (FK): Identificador de la sucursal.
- `id_proveedor` INT (FK): Identificador del proveedor.
- `cantidad` INT: Cantidad de productos en inventario.

**Relaciones:**
- `producto 1 - * inventario_producto`: Un producto puede estar en inventario en múltiples sucursales.
- `sucursal 1 - * inventario_producto`: Una sucursal puede tener inventario de múltiples productos.

---

## 20. Tabla `sucursal`
**Atributos:**
- `id_sucursal` INT (PK): Identificador único de la sucursal.
- `nombre_sucursal` VARCHAR(100): Nombre de la sucursal.
- `encargado_sucursal` VARCHAR(100): Encargado de la sucursal.
- `calle` VARCHAR(30): Calle de la sucursal.
- `numero` VARCHAR(10): Número de la dirección.
- `comuna` VARCHAR(30): Comuna de la dirección.
- `region` VARCHAR(30): Región de la dirección.
- `telefono` VARCHAR(15): Teléfono de la sucursal.

**Relaciones:**
- `sucursal 1 - * empleado`: Una sucursal puede tener múltiples empleados.
- `sucursal 1 - * inventario_producto`: Una sucursal puede tener inventario de múltiples productos.

---

## 21. Tabla `proveedor`
**Atributos:**
- `id_proveedor` INT (PK): Identificador único del proveedor.
- `rut` VARCHAR(12): RUT del proveedor.
- `nombre` VARCHAR(100): Nombre del proveedor.
- `email` VARCHAR(80): Correo electrónico del proveedor.
- `telefono` VARCHAR(15): Teléfono del proveedor.
- `calle` VARCHAR(30): Calle de la dirección del proveedor.
- `numero` VARCHAR(10): Número de la dirección.
- `comuna` VARCHAR(30): Comuna de la dirección.
- `region` VARCHAR(30): Región de la dirección.

**Relaciones:**
- `proveedor 1 - * inventario_producto`: Un proveedor puede estar en inventario en múltiples sucursales.

---

## 22. Tabla `detalle_pedido`
**Atributos:**
- `id_detalle_pedido` INT (PK): Identificador único del detalle del pedido.
- `id_pedido` INT (FK): Identificador del pedido.
- `id_producto` INT (FK): Identificador del producto.
- `cantidad` SMALLINT: Cantidad de productos en el detalle.
- `precio_unitario` DECIMAL(10, 2): Precio unitario del producto.

**Relaciones:**
- `pedido 1 - * detalle_pedido`: Un pedido puede tener múltiples detalles de productos comprados.
- `producto 1 - * detalle_pedido`: Un producto puede aparecer en múltiples detalles de diferentes pedidos.

---

## 23. Tabla `imagen_producto`
**Atributos:**
- `id_img_producto` INT (PK): Identificador único de la imagen del producto.
- `id_producto` INT (FK): Identificador del producto asociado.
- `ruta_imagen` VARCHAR(255): Ruta de la imagen del producto.

**Relaciones:**
- `producto 1 - * imagen_producto`: Un producto puede tener múltiples imágenes.

---

## 24. Tabla `img_desc_producto`
**Atributos:**
- `id_img_desc_producto` INT (PK): Identificador único de la imagen descriptiva del producto.
- `id_producto` INT (FK): Identificador del producto.
- `ruta_imagen` VARCHAR(255): Ruta de la imagen descriptiva del producto.

**Relaciones:**
- `producto 1 - * img_desc_producto`: Un producto puede tener múltiples imágenes descriptivas.

---

## 25. Tabla `carrito_compras`
**Atributos:**
- `id_carrito` INT (PK): Identificador único del carrito.
- `id_cliente` INT (FK): Identificador del cliente propietario del carrito.
- `id_producto` INT (FK): Identificador del producto en el carrito.
- `cantidad` INT: Cantidad del producto en el carrito.

**Relaciones:**
- `carrito_compras * - 1 cliente`: Un cliente puede tener muchos productos en su carrito, pero el carrito solo le pertenece a un cliente.
- `carrito_compras * - 1 producto`: Un producto puede aparecer en muchos carritos.

---

## 26. Tabla `imagen_empleado`
**Atributos:**
- `id_img_empleado` INT (PK): Identificador único de la imagen del empleado.
- `id_empleado` INT (FK): Identificador del empleado asociado.
- `ruta_imagen` VARCHAR(255): Ruta de la imagen del empleado.

**Relaciones:**
- `empleado 1 - * imagen_empleado`: Un empleado puede tener múltiples imágenes.


---

## DER pre-codigo
![DER pre-codigo TODOTECH-AlvaroArayaSanchez](https://github.com/user-attachments/assets/edb2f6c7-a773-4a0c-887b-c7337a78bebf)


## DER post-codigo
![DER post-codigo TODOTECH-AlvaroArayaSanchez](https://github.com/user-attachments/assets/e9aa9cb5-321a-43cc-9710-407f8c56c6af)

