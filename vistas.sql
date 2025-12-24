
CREATE OR REPLACE VIEW VW_PEDIDOS_PENDIENTES AS
SELECT
    P.id_pedido,
    C.nombre AS nombre_cliente,
    P.fecha,
    P.estado,
    DP.cantidad,
    M.nombre AS plato,
    DP.subtotal
FROM
    Pedidos P
JOIN
    Clientes C ON P.id_cliente = C.id_cliente
JOIN
    Detalle_Pedido DP ON P.id_pedido = DP.id_pedido
JOIN
    Menu M ON DP.id_plato = M.id_plato
WHERE
    P.estado = 'En Proceso';


CREATE OR REPLACE VIEW VW_FACTURACION_DETALLADA AS
SELECT
    F.id_factura,
    P.id_pedido,
    C.nombre AS nombre_cliente,
    F.fecha_emision,
    F.monto_total,
    F.metodo_pago
FROM
    Facturas F
JOIN
    Pedidos P ON F.id_pedido = P.id_pedido
JOIN
    Clientes C ON P.id_cliente = C.id_cliente;


CREATE OR REPLACE VIEW VW_INVENTARIO_BAJO_ALERTA AS
SELECT
    PR.nombre AS producto,
    PR.stock,
    PR.precio_compra,
    PV.nombre AS proveedor,
    PV.telefono AS tel_proveedor
FROM
    Productos PR
JOIN
    Proveedores PV ON PR.id_proveedor = PV.id_proveedor
WHERE
    PR.stock < 10;


CREATE OR REPLACE VIEW VW_EMPLEADOS_BASICOS AS
SELECT
    id_empleado,
    nombre,
    puesto,
    fecha_contratacion
FROM
    Empleados;


CREATE OR REPLACE VIEW VW_RELACION_PROVEEDORES AS
SELECT
    PV.nombre AS nombre_proveedor,
    PV.telefono,
    COUNT(PR.id_producto) AS total_productos_suministrados
FROM
    Proveedores PV
LEFT JOIN
    Productos PR ON PV.id_proveedor = PR.id_proveedor
GROUP BY
    PV.nombre, PV.telefono;


CREATE OR REPLACE VIEW VW_PLATOS_MAS_VENDIDOS AS
SELECT
    M.nombre AS plato,
    SUM(DP.cantidad) AS cantidad_total_vendida
FROM
    Detalle_Pedido DP
JOIN
    Menu M ON DP.id_plato = M.id_plato
GROUP BY
    M.nombre
ORDER BY
    cantidad_total_vendida DESC;


CREATE OR REPLACE VIEW VW_VENTAS_POR_CLIENTE AS
SELECT
    C.nombre AS nombre_cliente,
    C.correo,
    COUNT(P.id_pedido) AS total_pedidos,
    SUM(P.total) AS gasto_total
FROM
    Clientes C
JOIN
    Pedidos P ON C.id_cliente = P.id_cliente
GROUP BY
    C.nombre, C.correo
ORDER BY
    gasto_total DESC;


CREATE OR REPLACE VIEW VW_COMPOSICION_MENU AS
SELECT
    M.nombre AS plato,
    M.precio_venta,
    (SELECT AVG(precio_compra) FROM Productos) AS costo_promedio_insumos 
FROM
    Menu M;


CREATE OR REPLACE VIEW VW_HISTORIAL_COMPRAS_PRODUCTOS AS
SELECT
    PR.nombre AS producto,
    PR.precio_compra AS precio_ultima_compra,
    PR.categoria,
    PV.nombre AS proveedor
FROM
    Productos PR
JOIN
    Proveedores PV ON PR.id_proveedor = PV.id_proveedor
ORDER BY
    PR.nombre;


CREATE OR REPLACE VIEW VW_VENTAS_DIARIAS AS
SELECT
    DATE(fecha_emision) AS dia,
    COUNT(id_factura) AS numero_facturas,
    SUM(monto_total) AS ingresos_netos_dia
FROM
    Facturas
GROUP BY
    DATE(fecha_emision)
ORDER BY
    dia DESC;
