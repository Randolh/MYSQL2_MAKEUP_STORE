USE tienda_maquillaje_db;

-- Áreas
INSERT INTO areas (nombre) VALUES 
('Venta'),
('Bodega'),
('Administración');

-- Empleados
INSERT INTO empleados (nombre_completo, puesto, fecha_contratacion) VALUES 
('Laura Gómez Pérez', 'Asesora de Belleza', '2023-03-15'),
('Carlos Andrés Ruiz', 'Encargado de Bodega', '2022-08-01'),
('Mariana Ortiz Rios', 'Cajera / Vendedora', '2024-01-10'),
('Sofía Morales Lara', 'Gerente de Tienda', '2021-05-20'),
('Mateo Fernández Vega', 'Auxiliar de Ventas', '2026-03-01');

-- Asignación de empleados a áreas
INSERT INTO empleado_areas (id_empleado, id_area) VALUES 
(1, 1), -- Laura en Venta
(2, 2), -- Carlos en Bodega
(3, 1), -- Mariana en Venta
(3, 3), -- Mariana en Administración
(4, 3), -- Sofía en Administración
(4, 1), -- Sofía en Venta
(5, 1); -- Mateo en Venta

-- Categorías
INSERT INTO categorias (nombre, descripcion) VALUES 
('Cosméticos', 'Productos para embellecimiento facial y corporal'),
('Cuidado de la Piel', 'Productos para hidratación, limpieza y tratamiento cutáneo'),
('Perfumes', 'Fragancias y colonias de diversas concentraciones'),
('Accesorios', 'Herramientas y complementos para aplicación de maquillaje');

-- Productos
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES 
('Labial Matte Ruby', 'Labial larga duración acabado mate', 15.50, 25, 1),
('Labial Nude Glow', 'Labial hidratante tono natural', 14.00, 4, 1),
('Base Líquida Flawless', 'Base de alta cobertura acabado satinado', 28.00, 18, 1),
('Paleta de Sombras Sunset', 'Paleta de 12 tonos cálidos y satinados', 35.00, 6, 1),
('Máscara de Pestañas Lash Lift', 'Efecto alargador y volumen a prueba de agua', 16.50, 30, 1),
('Sérum Ácido Hialurónico', 'Hidratación profunda para rostro y cuello', 24.00, 15, 2),
('Gel Limpiador Purificante', 'Limpiador facial diario con extracto de té verde', 18.50, 5, 2),
('Crema Hidratante Ceravital', 'Restauración de barrera cutánea 24h', 22.00, 12, 2),
('Tónico Facial Iluminador', 'Tónico con vitamina C y niacinamida', 19.00, 3, 2),
('Eau de Parfum Flor de Luna', 'Fragancia floral con toques de jazmín y vainilla', 65.00, 10, 3),
('Brisa Marina Cologne', 'Aroma fresco cítrico y marino unisex', 45.00, 8, 3),
('Amor Secreto Parfum', 'Notas amaderadas y especiadas de larga fijación', 72.00, 2, 3),
('Set de Brochas Profesionales', 'Kit de 10 brochas de cerdas sintéticas suaves', 32.00, 14, 4),
('Esponja Beauty Blender', 'Esponja ergonómica para difuminar base y corrector', 8.50, 40, 4),
('Rizador de Pestañas Pro', 'Rizador de acero inoxidable con almohadilla de silicona', 11.00, 7, 4);

-- Detalles cosméticos
INSERT INTO detalles_cosmeticos (id_producto, tipo, tono_color, fecha_expiracion) VALUES 
(1, 'labial', 'Rojo Ruby', '2027-06-30'),
(2, 'labial', 'Nude Rosa', '2027-12-31'),
(3, 'base', 'Beige Medio', '2027-03-15'),
(4, 'sombra', 'Cálidos / Sunset', '2028-01-01'),
(5, 'mascara', 'Negro Intenso', '2027-10-20');

-- Detalles cuidado de la piel
INSERT INTO detalles_cuidado_piel (id_producto, tipo_piel, componentes_principales, fecha_expiracion) VALUES 
(6, 'todo tipo', 'Ácido hialurónico 2%, Vitamina B5', '2027-09-01'),
(7, 'grasa', 'Té verde, Ácido salicílico 1%', '2027-11-30'),
(8, 'seca', 'Ceramidas, Manteca de karité', '2028-04-15'),
(9, 'mixta', 'Vitamina C 10%, Niacinamida 5%', '2027-08-20');

-- Detalles perfumes
INSERT INTO detalles_perfumes (id_producto, tipo_aroma, volumen_ml) VALUES 
(10, 'Floral Dulce', 100),
(11, 'Cítrico Marino', 80),
(12, 'Amaderado Especiado', 100);

-- Detalles accesorios
INSERT INTO detalles_accesorios (id_producto, material, tamano) VALUES 
(13, 'Cerdas sintéticas y madera', 'Set 10 piezas'),
(14, 'Poliuretano sin látex', 'Mediano'),
(15, 'Acero inoxidable y silicona', 'Estándar');

-- Clientes
INSERT INTO clientes (nombre_completo, correo, telefono, direccion) VALUES 
('Valeria Navarro Castro', 'valeria.navarro@gmail.com', '555-1001', 'Av. Las Palmas 123, Apt 4B'),
('Daniela Morales Soto', 'daniela.m@outlook.com', '555-1002', 'Calle Los Jazmines 45'),
('Camila Sánchez Rivas', 'camila.sanchez@gmail.com', '555-1003', 'Carrera 7 # 85-12'),
('Andrea Castillo Luna', 'andrea.castillo@yahoo.com', '555-1004', 'Diagonal 45 # 22-80'),
('Lucía Torres Méndez', 'lucia.torres@gmail.com', '555-1005', 'Transversal 15 # 100-30');

-- Ventas
INSERT INTO ventas (id_cliente, id_empleado, fecha_venta) VALUES 
(1, 1, '2026-07-10 10:30:00'),
(2, 1, '2026-07-15 11:15:00'),
(1, 3, '2026-07-20 15:45:00'),
(3, 5, '2026-08-02 16:00:00'),
(4, 1, '2026-08-15 09:30:00'),
(2, 3, '2026-08-15 14:20:00'),
(5, 1, '2026-08-20 17:10:00'),
(1, 1, '2026-08-28 18:00:00');

-- Detalle de ventas
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES 
(1, 1, 2, 15.50),
(1, 14, 1, 8.50),
(2, 3, 1, 28.00),
(2, 6, 1, 24.00),
(3, 1, 1, 15.50),
(3, 2, 2, 14.00),
(4, 10, 1, 65.00),
(4, 13, 1, 32.00),
(5, 1, 3, 15.50),
(5, 5, 2, 16.50),
(5, 14, 2, 8.50),
(6, 6, 2, 24.00),
(6, 7, 1, 18.50),
(7, 4, 1, 35.00),
(7, 1, 1, 15.50),
(8, 2, 1, 14.00),
(8, 8, 1, 22.00);

-- Proveedores
INSERT INTO proveedores (nombre_empresa, nombre_contacto, telefono, direccion) VALUES 
('Cosmetics International S.A.', 'Jorge Mario Henao', '555-8001', 'Parque Industrial Norte Bodega 12'),
('DermoSkin Laboratories', 'Beatriz Elena Restrepo', '555-8002', 'Zona Franca Edificio B Oficina 304'),
('Fragrance World Corp.', 'Felipe Estrada Vega', '555-8003', 'Av. Central 500 Torre Empresarial');

-- Órdenes de compra
INSERT INTO ordenes_compra (fecha_orden, id_proveedor, estado) VALUES 
('2025-03-10', 1, 'recibida'),
('2025-11-20', 2, 'recibida'),
('2026-01-15', 1, 'recibida'),
('2026-04-10', 3, 'recibida'),
('2026-08-05', 1, 'pendiente');

-- Detalle de órdenes de compra
INSERT INTO detalle_ordenes_compra (id_orden, id_producto, cantidad_solicitada, cantidad_recibida, precio_unitario_compra) VALUES 
(1, 1, 50, 50, 8.00),
(1, 2, 30, 30, 7.50),
(2, 6, 40, 40, 12.00),
(2, 7, 25, 25, 9.00),
(3, 1, 60, 60, 8.20),
(3, 3, 30, 30, 14.00),
(3, 5, 40, 40, 8.50),
(4, 10, 20, 20, 32.00),
(4, 11, 15, 15, 22.00),
(5, 1, 50, 0, 8.20),
(5, 4, 25, 0, 18.00);
