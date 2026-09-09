USE tienda_maquillaje_db;

-- 1. Listar todos los productos de cosméticos de un tipo específico (por ejemplo, "labial")
CALL sp_cosmeticos_por_tipo('labial');

-- 2. Obtener todos los productos en una categoría cuyo stock sea inferior a un valor dado
CALL sp_productos_bajo_stock_categoria('Cosméticos', 10);

-- 3. Mostrar todas las ventas realizadas por un cliente específico en un rango de fechas
CALL sp_ventas_cliente_por_fechas(1, '2026-07-01 00:00:00', '2026-08-31 23:59:59');

-- 4. Calcular el total de ventas realizadas por un empleado en un mes dado
SELECT fn_total_ventas_empleado_mes(1, 2026, 8) AS total_vendido_mes;

-- 5. Listar los productos más vendidos en un período determinado (Top 5)
CALL sp_productos_mas_vendidos('2026-07-01 00:00:00', '2026-08-31 23:59:59', 5);

-- 6. Consultar el stock disponible de un producto por su nombre o identificador
CALL sp_consultar_stock_producto(1, NULL);
CALL sp_consultar_stock_producto(NULL, 'Labial Matte Ruby');

-- 7. Mostrar las órdenes de compra realizadas a un proveedor específico en el último año
CALL sp_ordenes_proveedor_ultimo_anio(1);

-- 8. Listar los empleados que han trabajado más de un año en la tienda
CALL sp_empleados_mas_de_un_anio();

-- 9. Obtener la cantidad total de productos vendidos en un día específico
SELECT fn_total_productos_vendidos_dia('2026-08-15') AS total_unidades_vendidas_dia;

-- 10. Consultar las ventas de un producto específico (por nombre o ID) y cuántas unidades se vendieron
CALL sp_ventas_por_producto(1, NULL);
CALL sp_ventas_por_producto(NULL, 'Labial Matte Ruby');
