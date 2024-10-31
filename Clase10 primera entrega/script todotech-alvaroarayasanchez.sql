DROP DATABASE IF EXISTS todotech;
CREATE DATABASE todotech;
USE todotech;

-- CREACION DE LAS TABLAS DE BBDD TODOTECH.CL

CREATE TABLE direccion (
    id_direccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    calle VARCHAR(30) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    comuna VARCHAR(30) NOT NULL,
    region VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(10)
);

CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rut VARCHAR(12) NOT NULL,
    nombres VARCHAR(25) NOT NULL,
    apellidos VARCHAR(40) NOT NULL,
    estado ENUM('Habilitado', 'Desabilitado') NOT NULL DEFAULT 'Habilitado',
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL,
    contrasena VARCHAR(25) NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE boleta_factura (
    id_boleta_factura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Boleta', 'Factura') NOT NULL DEFAULT 'Boleta',
    fecha_emision DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE envio (
    id_envio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    estado_envio ENUM('Pedido Recibido', 'En Preparación', 'Enviado', 'En Tránsito', 'Entregado', 'Intento de Entrega', 'Devolución', 'Cancelado', 'Retrasado') NOT NULL DEFAULT 'Pedido Recibido',
    fecha_empaquetado DATETIME,
    fecha_enviado DATETIME,
    fecha_entregado DATETIME
);

CREATE TABLE metodo_pago (
    id_metodo_pago INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_metodo VARCHAR(50) NOT NULL
);

CREATE TABLE pedido (
    id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_envio INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    id_boleta_factura INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    monto_total DECIMAL(10, 2) NOT NULL
);

CREATE TABLE carrito_compras (
    id_carrito INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL
);

CREATE TABLE producto (
    id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_marca INT NOT NULL,
    nombre_producto VARCHAR(120) NOT NULL,
    descripcion TEXT NOT NULL,
    sku VARCHAR(20) NOT NULL,
    stock INT NOT NULL,
    estado ENUM('En stock', 'Agotado') NOT NULL DEFAULT 'En stock',
    precio DECIMAL(10, 2) NOT NULL
);

CREATE TABLE detalle_pedido (
    id_detalle_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad SMALLINT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE empleado (
    id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT NOT NULL,
    rut VARCHAR(12) NOT NULL,
    nombres VARCHAR(25),
    apellidos VARCHAR(40),
    estado ENUM('Habilitado', 'Desabilitado') NOT NULL DEFAULT 'Habilitado',
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    comuna VARCHAR(30) NOT NULL,
    region VARCHAR(30) NOT NULL,
    estado_civil ENUM('Soltero', 'Casado', 'Divorciado', 'Viudo') NOT NULL DEFAULT 'Soltero',
    contrasena VARCHAR(25) NOT NULL,
    cargo VARCHAR(80) NOT NULL,
    fecha_ingreso DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sueldo DECIMAL(10, 2) NOT NULL
);

CREATE TABLE sucursal (
    id_sucursal INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    encargado_sucursal VARCHAR(100) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    comuna VARCHAR(30) NOT NULL,
    region VARCHAR(30) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

CREATE TABLE inventario_producto (
    id_inventario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_proveedor INT NOT NULL,
    cantidad INT NOT NULL
);

CREATE TABLE descuento_cliente (
    id_descuento_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    nombre_descuento VARCHAR(100) NOT NULL,
    descripcion text,
    porcentaje DECIMAL(3, 1) NOT NULL,
    estado ENUM('Vigente', 'Expirado') NOT NULL DEFAULT 'Expirado',
    fecha_inicio DATETIME NOT NULL,
    fecha_termino DATETIME NOT NULL
);

CREATE TABLE imagen_producto (
    id_img_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    ruta_imagen VARCHAR(255) NOT NULL
);

CREATE TABLE img_desc_producto (
    id_img_desc_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    ruta_imagen VARCHAR(255) NOT NULL
);

CREATE TABLE marca_producto (
    id_marca INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_marca VARCHAR(100) NOT NULL
);

CREATE TABLE historial_precio (
    id_historial INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE descuento_producto (
    id_descuento_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    nombre_descuento VARCHAR(100) NOT NULL,
    descripcion TEXT,
    porcentaje DECIMAL(3, 1) NOT NULL,
    estado ENUM('Vigente', 'Expirado') NOT NULL DEFAULT 'Expirado',
    fecha_inicio DATETIME NOT NULL,
    fecha_termino DATETIME NOT NULL
);

CREATE TABLE categoria_producto (
    id_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL ,
    descripcion TEXT NOT NULL
);

CREATE TABLE proveedor (
    id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    rut VARCHAR(12) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(80) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    comuna VARCHAR(30) NOT NULL,
    region VARCHAR(30) NOT NULL
);

CREATE TABLE empleado_rol (
    id_empleado_rol INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    id_rol INT NOT NULL,
    fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE rol_empleado (
    id_rol INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(100) NOT NULL
);

CREATE TABLE rol_permiso (
    id_rol_permiso INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    id_permiso INT NOT NULL,
    fecha_asignacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE permiso_empleado (
    id_permiso INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_permiso VARCHAR(100) NOT NULL
);

CREATE TABLE pedido_empleado (
    id_pedido_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_movimiento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE imagen_empleado (
    id_img_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    ruta_imagen VARCHAR(255) NOT NULL
);


-- ALTER TABLE PARA RELACIONES DE TABLAS PARA BBDD TODOTECH.CL

-- Relación Dirección con Cliente
ALTER TABLE direccion
ADD CONSTRAINT fk_direccion_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

-- Relación Descuento_Cliente con Cliente
ALTER TABLE descuento_cliente
ADD CONSTRAINT fk_descuento_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

-- Relación Pedido con Cliente
ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

-- Relación Pedido con Boleta_Factura
ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_boleta_factura
FOREIGN KEY (id_boleta_factura) REFERENCES boleta_factura(id_boleta_factura);

-- Relación Pedido con Envio
ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_envio
FOREIGN KEY (id_envio) REFERENCES envio(id_envio);

-- Relación Pedido con Metodo_Pago
ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_metodo_pago
FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago);

-- Relación Pedido_Empleado con Pedido
ALTER TABLE pedido_empleado
ADD CONSTRAINT fk_pedido_empleado_pedido
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

-- Relación Pedido_Empleado con Empleado
ALTER TABLE pedido_empleado
ADD CONSTRAINT fk_pedido_empleado_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

-- Relación Imagen_Empleado con Empleado
ALTER TABLE imagen_empleado
ADD CONSTRAINT fk_imagen_empleado_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

-- Relación Empleado con Sucursal
ALTER TABLE empleado
ADD CONSTRAINT fk_empleado_sucursal
FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);

-- Relación Empleado_Rol con Empleado
ALTER TABLE empleado_rol
ADD CONSTRAINT fk_empleado_rol_empleado
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);

-- Relación Empleado_Rol con Rol_Empleado
ALTER TABLE empleado_rol
ADD CONSTRAINT fk_empleado_rol_rol_empleado
FOREIGN KEY (id_rol) REFERENCES rol_empleado(id_rol);

-- Relación Rol_Permiso con Rol_Empleado
ALTER TABLE rol_permiso
ADD CONSTRAINT fk_rol_permiso_rol_empleado
FOREIGN KEY (id_rol) REFERENCES rol_empleado(id_rol);

-- Relación Rol_Permiso con Permiso_Empleado
ALTER TABLE rol_permiso
ADD CONSTRAINT fk_rol_permiso_permiso_empleado
FOREIGN KEY (id_permiso) REFERENCES permiso_empleado(id_permiso);

-- Relación Carrito_Compras con Cliente
ALTER TABLE carrito_compras
ADD CONSTRAINT fk_carrito_compras_cliente
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

-- Relación Detalle_Pedido con Pedido
ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_pedido
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

-- Relación Carrito_Compras con Producto
ALTER TABLE carrito_compras
ADD CONSTRAINT fk_carrito_compras_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- Relación Detalle_Pedido con Producto
ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- Relación Imagen_Producto con Producto
ALTER TABLE imagen_producto
ADD CONSTRAINT fk_imagen_producto_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- Relación Img_Desc_Producto con Producto
ALTER TABLE img_desc_producto
ADD CONSTRAINT fk_img_desc_producto_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- Relación Producto con Marca_Producto
ALTER TABLE producto
ADD CONSTRAINT fk_producto_marca_producto
FOREIGN KEY (id_marca) REFERENCES marca_producto(id_marca);

-- Relación Historial_Precio con Producto
ALTER TABLE historial_precio
ADD CONSTRAINT fk_historial_precio_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- Relación Inventario_Producto con Producto
ALTER TABLE inventario_producto
ADD CONSTRAINT fk_inventario_producto_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- Relación Inventario_Producto con Proveedor
ALTER TABLE inventario_producto
ADD CONSTRAINT fk_inventario_producto_proveedor
FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor);

-- Relación Inventario_Producto con Sucursal
ALTER TABLE inventario_producto
ADD CONSTRAINT fk_inventario_producto_sucursal
FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);

-- Relación Producto con Categoria_Producto
ALTER TABLE producto
ADD CONSTRAINT fk_producto_categoria_producto
FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id_categoria);

-- Relación Descuento_Producto con Producto
ALTER TABLE descuento_producto
ADD CONSTRAINT fk_descuento_producto_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);
