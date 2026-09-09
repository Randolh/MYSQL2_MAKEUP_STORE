DROP DATABASE IF EXISTS tienda_maquillaje_db;
CREATE DATABASE tienda_maquillaje_db;
USE tienda_maquillaje_db;

-- Áreas de la tienda
CREATE TABLE areas (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Empleados
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    puesto VARCHAR(60) NOT NULL,
    fecha_contratacion DATE NOT NULL
);

-- Asignación de empleados a áreas
CREATE TABLE empleado_areas (
    id_empleado INT NOT NULL,
    id_area INT NOT NULL,
    PRIMARY KEY (id_empleado, id_area),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_area) REFERENCES areas(id_area)
);

-- Categorías de productos
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

-- Catálogo general de productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Características específicas de cosméticos
CREATE TABLE detalles_cosmeticos (
    id_producto INT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL, -- ej: labial, base, sombra
    tono_color VARCHAR(50),
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Características específicas de cuidado de la piel
CREATE TABLE detalles_cuidado_piel (
    id_producto INT PRIMARY KEY,
    tipo_piel ENUM('seca', 'grasa', 'mixta', 'todo tipo', 'sensible') NOT NULL,
    componentes_principales TEXT,
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Características específicas de perfumes
CREATE TABLE detalles_perfumes (
    id_producto INT PRIMARY KEY,
    tipo_aroma VARCHAR(80) NOT NULL,
    volumen_ml INT NOT NULL CHECK (volumen_ml > 0),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Características específicas de accesorios
CREATE TABLE detalles_accesorios (
    id_producto INT PRIMARY KEY,
    material VARCHAR(80) NOT NULL,
    tamano VARCHAR(40),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(200)
);

-- Registro de ventas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Detalle de productos por cada venta
CREATE TABLE detalle_ventas (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Proveedores
CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(120) NOT NULL,
    nombre_contacto VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL
);

-- Órdenes de compra a proveedores
CREATE TABLE ordenes_compra (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    fecha_orden DATE NOT NULL,
    id_proveedor INT NOT NULL,
    estado ENUM('pendiente', 'recibida', 'cancelada') DEFAULT 'pendiente',
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

-- Detalle de productos por cada orden de compra
CREATE TABLE detalle_ordenes_compra (
    id_detalle_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_solicitada INT NOT NULL CHECK (cantidad_solicitada > 0),
    cantidad_recibida INT NOT NULL DEFAULT 0 CHECK (cantidad_recibida >= 0),
    precio_unitario_compra DECIMAL(10,2) NOT NULL CHECK (precio_unitario_compra >= 0),
    FOREIGN KEY (id_orden) REFERENCES ordenes_compra(id_orden),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
