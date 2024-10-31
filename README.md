# todotech.cl-Alvaro-Araya-Sanchez
Una nueva pyme llamada todotech actualmente cuenta con una sucursal, pero aspira a tener más y realizar ventas web, por lo cual requiere de una pagina web ya que no cuenta con ninguna, la problemática principal es que tienen el front-end terminado, pero les falta todo el back-end, lo cual incluye la BBDD, la misma la solicitaron en el motor de MySQL, junto a su DER y el script de creación junto a sus relaciones.

# Documentación de la Base de Datos

## 1. Dirección
- **Propósito**: Almacena las direcciones de los clientes.
- **Campos**:
  - `id_direccion` (PK)
  - `id_usuario` (FK)
  - `calle`
  - `numero`
  - `comuna`
  - `region`
  - `codigo_postal`
- **Relaciones**:
  - Relación 1-* con **Cliente**: Un cliente puede tener múltiples direcciones, pero esas direcciones solo le pertenecen a un usuario.

---

## 2. Cliente
- **Propósito**: Almacena los datos de los clientes.
- **Campos**:
  - `id_cliente` (PK)
  - `rut`
  - `nombres`
  - `apellidos`
  - `estado`
  - `fecha_nacimiento`
  - `email` (único)
  - `telefono`
  - `contrasena`
  - `fecha_registro`
- **Relaciones**:
  - Relación 1-* con **Pedido**: Un cliente puede realizar múltiples pedidos, y cada pedido está relacionado a un solo cliente.
  - Relación 1-* con **Carrito_Compras**: Un cliente puede tener múltiples productos en su carrito de compras.
  - Relación 1-* con **Descuento_Cliente**: Un cliente puede tener múltiples descuentos asignados, pero los descuentos son únicos para cada cliente.

---

## 3. Boleta_Factura
- **Propósito**: Almacena el tipo de emisión y la fecha de la misma.
- **Campos**:
  - `id_boleta_factura` (PK)
  - `tipo` (indica si es boleta o factura)
  - `fecha_emision`
- **Relaciones**:
  - Relación 1-1 con **Pedido**: Cada pedido genera una única boleta o factura.

---

## 4. Envío
- **Propósito**: Contiene los detalles de envío de cada pedido.
- **Campos**:
  - `id_envio` (PK)
  - `estado_envio`
  - `fecha_empaquetado`
  - `fecha_enviado`
  - `fecha_entregado`
- **Relaciones**:
  - Relación 1-1 con **Pedido**: Cada pedido tiene un solo envío asociado.

---

## 5. Método_Pago
- **Propósito**: Almacena los métodos de pago que se pueden utilizar para cancelar los pedidos.
- **Campos**:
  - `id_metodo_pago` (PK)
  - `nombre_metodo`
- **Relaciones**:
  - Relación 1-1 con **Pedido**: Un pedido solo puede utilizar un único método de pago.

---

## 6. Pedido
- **Propósito**: Almacena la información de los pedidos realizados por los clientes.
- **Campos**:
  - `id_pedido` (PK)
  - `id_cliente` (FK)
  - `id_envio` (FK)
  - `id_metodo_pago` (FK)
  - `id_boleta_factura` (FK)
  - `fecha_pedido`
  - `monto_total`
- **Relaciones**:
  - Relación *-1 con **Cliente**: Un pedido pertenece a un cliente.
  - Relación 1-* con **Detalle_Pedido**: Un pedido puede incluir múltiples detalles de productos.
  - Relación 1-1 con **Envío**: Cada pedido tiene un solo envío asociado.
  - Relación 1-1 con **Método_Pago**: Cada pedido tiene un único método de pago.
  - Relación 1-1 con **Boleta_Factura**: Cada pedido genera una boleta o factura.

---

## 7. Carrito_Compras
- **Propósito**: Almacena los productos que los clientes agregan a su carrito.
- **Campos**:
  - `id_carrito` (PK)
  - `id_cliente` (FK)
  - `id_producto` (FK)
  - `cantidad`
- **Relaciones**:
  - Relación *-1 con **Cliente**: Un carrito pertenece a un cliente.
  - Relación *-1 con **Producto**: Cada elemento en el carrito se refiere a un producto específico.

---

## 8. Producto
- **Propósito**: Almacena la información de los productos que se venden en la tienda.
- **Campos**:
  - `id_producto` (PK)
  - `id_categoria` (FK)
  - `id_marca` (FK)
  - `nombre_producto`
  - `descripcion`
  - `sku`
  - `stock`
  - `estado`
  - `precio`
- **Relaciones**:
  - Relación 1-* con **Detalle_Pedido**: Un producto puede estar en varios pedidos.
  - Relación 1-* con **Historial_Precio**: Un producto puede tener múltiples precios en distintos momentos.
  - Relación 1-* con **Descuento_Producto**: Un producto puede tener múltiples descuentos.
  - Relación 1-* con **Inventario_Producto**: Cada producto está en el inventario de distintas sucursales.
  - Relación 1-* con **Imagen_Producto** y **Img_Desc_Producto**: Un producto puede tener múltiples imágenes.

---

## 9. Detalle_Pedido
- **Propósito**: Contiene el detalle de los productos incluidos en cada pedido.
- **Campos**:
  - `id_detalle_pedido` (PK)
  - `id_pedido` (FK)
  - `id_producto` (FK)
  - `cantidad`
  - `precio_unitario`
- **Relaciones**:
  - Relación *-1 con **Pedido**: Cada detalle pertenece a un pedido.
  - Relación *-1 con **Producto**: Cada detalle hace referencia a un producto específico.

---

## 10. Empleado
- **Propósito**: Almacena los datos de los empleados.
- **Campos**:
  - `id_empleado` (PK)
  - `id_sucursal` (FK)
  - `rut`
  - `nombres`
  - `apellidos`
  - `estado`
  - `fecha_nacimiento`
  - `email` (único)
  - `telefono`
  - `calle`
  - `numero`
  - `comuna`
  - `region`
  - `estado_civil` (Soltero/Casado)
  - `contrasena`
  - `cargo`
  - `fecha_ingreso`
  - `sueldo`
- **Relaciones**:
  - Relación 1-* con **Sucursal**: Cada empleado está asignado a una sucursal.
  - Relación 1-* con **Rol_Empleado**: Cada empleado puede tener múltiples roles.
  - Relación 1-* con **Imagen_Empleado**: Cada empleado puede tener múltiples imágenes.

---

## 11. Sucursal
- **Propósito**: Almacena la información de las diferentes sucursales de la tienda.
- **Campos**:
  - `id_sucursal` (PK)
  - `nombre_sucursal`
  - `encargado_sucursal`
  - `calle`
  - `numero`
  - `comuna`
  - `region`
  - `telefono`
- **Relaciones**:
  - Relación 1-* con **Empleado**: Cada sucursal tiene varios empleados asignados.
  - Relación 1-* con **Inventario_Producto**: Cada sucursal maneja su propio inventario de productos.

---

## 12. Inventario_Producto
- **Propósito**: Almacena el inventario disponible para cada producto en cada sucursal.
- **Campos**:
  - `id_inventario` (PK)
  - `id_producto` (FK)
  - `id_sucursal` (FK)
  - `id_proveedor` (FK)
  - `cantidad`
- **Relaciones**:
  - Relación *-1 con **Producto**: Un producto puede estar en el inventario de varias sucursales.
  - Relación *-1 con Sucursal: Una sucursal puede tener varios productos de distintos proveedores
  - Relación *-1 con **Proveedor**: Un producto puede ser suministrado por varios proveedores.

---

## 13. Descuento_Cliente
- **Propósito**: Almacena los descuentos asignados a cada cliente.
- **Campos**:
  - `id_descuento_cliente` (PK)
  - `id_cliente` (FK)
  - `nombre_descuento`
  - `descripcion`
  - `porcentaje`
  - `estado`
  - `fecha_inicio`
  - `fecha_termino`
- **Relaciones**:
  - Relación *-1 con **Cliente**: Un cliente puede tener múltiples descuentos asignados.

---

## 14. Imagen_Producto
- **Propósito**: Almacena las imágenes asociadas a cada producto.
- **Campos**:
  - `id_img_producto` (PK)
  - `id_producto` (FK)
  - `ruta_imagen`
- **Relaciones**:
  - Relación 1-* con **Producto**: Un producto puede tener múltiples imágenes.

---

## 15. Img_Desc_Producto
- **Propósito**: Almacena imágenes descriptivas adicionales para cada producto.
- **Campos**:
  - `id_img_desc_producto` (PK)
  - `id_producto` (FK)
  - `ruta_imagen`
- **Relaciones**:
  - Relación 1-* con **Producto**: Un producto puede tener múltiples imágenes descriptivas adicionales.

---

## 16. Marca_Producto
- **Propósito**: Almacena las marcas de los productos.
- **Campos**:
  - `id_marca` (PK)
  - `nombre_marca`
- **Relaciones**:
  - Relación 1-* con **Producto**: Una marca puede tener varios productos asociados.

---

## 17. Historial_Precio
- **Propósito**: Almacena el historial de precios de cada producto, permitiendo rastrear los cambios en el precio a lo largo del tiempo.
- **Campos**:
  - `id_historial` (PK)
  - `id_producto` (FK)
  - `precio`
  - `fecha_cambio`
- **Relaciones**:
  - Relación *-1 con **Producto**: Cada cambio de precio se asocia a un producto específico.

---

## 18. Descuento_Producto
- **Propósito**: Almacena los descuentos aplicados a cada producto.
- **Campos**:
  - `id_descuento_producto` (PK)
  - `id_producto` (FK)
  - `nombre_descuento`
  - `descripcion`
  - `porcentaje`
  - `estado`
  - `fecha_inicio`
  - `fecha_termino`
- **Relaciones**:
  - Relación *-1 con **Producto**: Un producto puede tener múltiples descuentos aplicados en distintos momentos.

---

## 19. Categoria_Producto
- **Propósito**: Clasifica los productos en diferentes categorías.
- **Campos**:
  - `id_categoria` (PK)
  - `nombre_categoria`
  - `descripcion`
- **Relaciones**:
  - Relación 1-* con **Producto**: Una categoría puede agrupar múltiples productos.

---

## 20. Proveedor
- **Propósito**: Almacena la información de los proveedores de productos.
- **Campos**:
  - `id_proveedor` (PK)
  - `rut`
  - `nombre`
  - `email`
  - `telefono`
  - `calle`
  - `numero`
  - `comuna`
  - `region`
- **Relaciones**:
  - Relación 1-* con **Inventario_Producto**: Un proveedor puede suministrar varios productos que se almacenan en el inventario.

---

## 21. Empleado_Rol
- **Propósito**: Define los roles asignados a cada empleado.
- **Campos**:
  - `id_empleado_rol` (PK)
  - `id_empleado` (FK)
  - `id_rol` (FK)
  - `fecha_asignacion`
- **Relaciones**:
  - Relación *-1 con **Empleado**: Un empleado puede tener múltiples roles.
  - Relación *-1 con **Rol_Empleado**: Un rol puede ser asignado a varios empleados.

---

## 22. Rol_Empleado
- **Propósito**: Almacena los diferentes roles que pueden tener los empleados.
- **Campos**:
  - `id_rol` (PK)
  - `nombre_rol`
- **Relaciones**:
  - Relación *-* con **Empleado_Rol**: Un rol puede asignarse a múltiples empleados.

---

## 23. Rol_Permiso
- **Propósito**: Define los permisos específicos asignados a cada rol de empleado.
- **Campos**:
  - `id_rol_permiso` (PK)
  - `id_rol` (FK)
  - `id_permiso` (FK)
  - `fecha_asignacion`
- **Relaciones**:
  - Relación *-1 con **Rol_Empleado**: Un rol puede tener múltiples permisos asignados.
  - Relación *-1 con **Permiso_Empleado**: Un permiso puede estar en varios roles.

---

## 24. Permiso_Empleado
- **Propósito**: Define los diferentes permisos que pueden tener los empleados.
- **Campos**:
  - `id_permiso` (PK)
  - `nombre_permiso`
- **Relaciones**:
  - Relación *-* con **Rol_Empleado**: Un permiso puede asignarse a múltiples empleados a través del rol.

---

## 25. Pedido_Empleado
- **Propósito**: Registra el empleado que toma acción con los pedidos (por ejemplo, empaquetar o enviar).
- **Campos**:
  - `id_pedido_empleado` (PK)
  - `id_pedido` (FK)
  - `id_empleado` (FK)
  - `fecha_movimiento`
- **Relaciones**:
  - Relación *-1 con **Pedido**: Un pedido puede tener múltiples empleados que lo atiendan.
  - Relación *-1 con **Empleado**: Un empleado puede asignarse a múltiples pedidos.

---

## 26. Imagen_Empleado
- **Propósito**: Almacena imágenes asociadas a cada empleado.
- **Campos**:
  - `id_img_empleado` (PK)
  - `id_empleado` (FK)
  - `ruta_imagen`
- **Relaciones**:
  - Relación 1-* con **Empleado**: Un empleado puede tener múltiples imágenes asociadas.

---

## DER pre-codigo
![DER pre-codigo TODOTECH-AlvaroArayaSanchez](https://github.com/user-attachments/assets/31bf6018-c18f-4e19-bf71-de78197c4c0f)

## DER post-codigo
![DER post-codigo TODOTECH-AlvaroArayaSanchez](https://github.com/user-attachments/assets/691916db-7b72-43f8-9f4e-4e72f7359226)
