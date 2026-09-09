USE tienda_maquillaje_db;

DELIMITER //

-- 1. Cosméticos por tipo específico
DROP PROCEDURE IF EXISTS sp_cosmeticos_por_tipo //
CREATE PROCEDURE sp_cosmeticos_por_tipo(
    IN p_tipo VARCHAR(50)
)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        p.descripcion,
        p.precio,
        p.stock,
        dc.tipo,
        dc.tono_color,
        dc.fecha_expiracion
    FROM productos p
    INNER JOIN detalles_cosmeticos dc ON p.id_producto = dc.id_producto
    WHERE LOWER(dc.tipo) = LOWER(p_tipo);
END //

-- 2. Productos de una categoría con stock inferior a un valor
DROP PROCEDURE IF EXISTS sp_productos_bajo_stock_categoria //
CREATE PROCEDURE sp_productos_bajo_stock_categoria(
    IN p_categoria VARCHAR(50),
    IN p_stock_limite INT
)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        c.nombre AS categoria,
        p.precio,
        p.stock
    FROM productos p
    INNER JOIN categorias c ON p.id_categoria = c.id_categoria
    WHERE LOWER(c.nombre) = LOWER(p_categoria)
      AND p.stock < p_stock_limite;
END //

-- 3. Ventas de un cliente en un rango de fechas
DROP PROCEDURE IF EXISTS sp_ventas_cliente_por_fechas //
CREATE PROCEDURE sp_ventas_cliente_por_fechas(
    IN p_id_cliente INT,
    IN p_fecha_inicio DATETIME,
    IN p_fecha_fin DATETIME
)
BEGIN
    SELECT 
        v.id_venta,
        v.fecha_venta,
        c.nombre_completo AS cliente,
        e.nombre_completo AS empleado,
        SUM(dv.cantidad * dv.precio_unitario) AS total_venta
    FROM ventas v
    INNER JOIN clientes c ON v.id_cliente = c.id_cliente
    INNER JOIN empleados e ON v.id_empleado = e.id_empleado
    INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
    WHERE v.id_cliente = p_id_cliente
      AND v.fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY v.id_venta, v.fecha_venta, c.nombre_completo, e.nombre_completo
    ORDER BY v.fecha_venta ASC;
END //

-- 4. Total en ventas de un empleado en un mes
DROP FUNCTION IF EXISTS fn_total_ventas_empleado_mes //
CREATE FUNCTION fn_total_ventas_empleado_mes(
    p_id_empleado INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;

    SELECT COALESCE(SUM(dv.cantidad * dv.precio_unitario), 0.00)
    INTO v_total
    FROM ventas v
    INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
    WHERE v.id_empleado = p_id_empleado
      AND YEAR(v.fecha_venta) = p_anio
      AND MONTH(v.fecha_venta) = p_mes;

    RETURN v_total;
END //

-- 5. Productos más vendidos en un período
DROP PROCEDURE IF EXISTS sp_productos_mas_vendidos //
CREATE PROCEDURE sp_productos_mas_vendidos(
    IN p_fecha_inicio DATETIME,
    IN p_fecha_fin DATETIME,
    IN p_limite INT
)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        c.nombre AS categoria,
        SUM(dv.cantidad) AS unidades_vendidas,
        SUM(dv.cantidad * dv.precio_unitario) AS total_recaudado
    FROM detalle_ventas dv
    INNER JOIN ventas v ON dv.id_venta = v.id_venta
    INNER JOIN productos p ON dv.id_producto = p.id_producto
    INNER JOIN categorias c ON p.id_categoria = c.id_categoria
    WHERE v.fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY p.id_producto, p.nombre, c.nombre
    ORDER BY unidades_vendidas DESC
    LIMIT p_limite;
END //

-- 6. Stock de un producto por ID o nombre
DROP PROCEDURE IF EXISTS sp_consultar_stock_producto //
CREATE PROCEDURE sp_consultar_stock_producto(
    IN p_id INT,
    IN p_nombre VARCHAR(120)
)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        c.nombre AS categoria,
        p.precio,
        p.stock
    FROM productos p
    INNER JOIN categorias c ON p.id_categoria = c.id_categoria
    WHERE (p_id IS NOT NULL AND p.id_producto = p_id)
       OR (p_nombre IS NOT NULL AND LOWER(p.nombre) LIKE CONCAT('%', LOWER(p_nombre), '%'));
END //

-- 7. Órdenes de compra a un proveedor en el último año
DROP PROCEDURE IF EXISTS sp_ordenes_proveedor_ultimo_anio //
CREATE PROCEDURE sp_ordenes_proveedor_ultimo_anio(
    IN p_id_proveedor INT
)
BEGIN
    SELECT 
        oc.id_orden,
        oc.fecha_orden,
        p.nombre_empresa AS proveedor,
        oc.estado,
        SUM(doc.cantidad_solicitada) AS total_unidades_solicitadas,
        SUM(doc.cantidad_recibida) AS total_unidades_recibidas,
        SUM(doc.cantidad_solicitada * doc.precio_unitario_compra) AS total_orden
    FROM ordenes_compra oc
    INNER JOIN proveedores p ON oc.id_proveedor = p.id_proveedor
    INNER JOIN detalle_ordenes_compra doc ON oc.id_orden = doc.id_orden
    WHERE oc.id_proveedor = p_id_proveedor
      AND oc.fecha_orden >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    GROUP BY oc.id_orden, oc.fecha_orden, p.nombre_empresa, oc.estado
    ORDER BY oc.fecha_orden DESC;
END //

-- 8. Empleados con más de un año de antigüedad
DROP PROCEDURE IF EXISTS sp_empleados_mas_de_un_anio //
CREATE PROCEDURE sp_empleados_mas_de_un_anio()
BEGIN
    SELECT 
        id_empleado,
        nombre_completo,
        puesto,
        fecha_contratacion,
        TIMESTAMPDIFF(YEAR, fecha_contratacion, CURDATE()) AS anios_trabajados
    FROM empleados
    WHERE fecha_contratacion <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    ORDER BY fecha_contratacion ASC;
END //

-- 9. Total de productos vendidos en un día
DROP FUNCTION IF EXISTS fn_total_productos_vendidos_dia //
CREATE FUNCTION fn_total_productos_vendidos_dia(
    p_fecha DATE
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total INT DEFAULT 0;

    SELECT COALESCE(SUM(dv.cantidad), 0)
    INTO v_total
    FROM ventas v
    INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
    WHERE DATE(v.fecha_venta) = p_fecha;

    RETURN v_total;
END //

-- 10. Ventas de un producto por ID o nombre
DROP PROCEDURE IF EXISTS sp_ventas_por_producto //
CREATE PROCEDURE sp_ventas_por_producto(
    IN p_id INT,
    IN p_nombre VARCHAR(120)
)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre,
        v.id_venta,
        v.fecha_venta,
        dv.cantidad AS unidades_vendidas,
        dv.precio_unitario,
        (dv.cantidad * dv.precio_unitario) AS subtotal
    FROM detalle_ventas dv
    INNER JOIN ventas v ON dv.id_venta = v.id_venta
    INNER JOIN productos p ON dv.id_producto = p.id_producto
    WHERE (p_id IS NOT NULL AND p.id_producto = p_id)
       OR (p_nombre IS NOT NULL AND LOWER(p.nombre) LIKE CONCAT('%', LOWER(p_nombre), '%'))
    ORDER BY v.fecha_venta DESC;
END //

DELIMITER ;
