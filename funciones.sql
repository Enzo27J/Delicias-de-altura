-- Funciones sobre facturación y ventas

DELIMITER //

CREATE FUNCTION FN_TOTAL_PEDIDO(p_id_pedido INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0;
    SELECT IFNULL(SUM(subtotal), 0)
    INTO v_total
    FROM Detalle_Pedido
    WHERE id_pedido = p_id_pedido;
    RETURN v_total;
END //

CREATE FUNCTION FN_TOTAL_VENTAS_FECHA(p_fecha DATE) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT IFNULL(SUM(monto_total), 0)
    INTO v_total
    FROM Facturas
    WHERE DATE(fecha_emision) = DATE(p_fecha);
    RETURN v_total;
END //

CREATE FUNCTION FN_TOTAL_VENTAS_CLIENTE(p_id_cliente INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT IFNULL(SUM(F.monto_total), 0)
    INTO v_total
    FROM Facturas F
    JOIN Pedidos P ON F.id_pedido = P.id_pedido
    WHERE P.id_cliente = p_id_cliente;
    RETURN v_total;
END //

-- Funciones sobre inventario y menú

CREATE FUNCTION FN_STOCK_PRODUCTO(p_id_producto INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_stock INT;
    SELECT stock INTO v_stock FROM Productos WHERE id_producto = p_id_producto;
    RETURN v_stock;
END //

CREATE FUNCTION FN_PRODUCTOS_BAJOS_STOCK() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Productos WHERE stock < 10;
    RETURN v_count;
END //

CREATE FUNCTION FN_PRECIO_PLATO(p_id_plato INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_precio DECIMAL(10,2);
    SELECT precio_venta INTO v_precio FROM Menu WHERE id_plato = p_id_plato;
    RETURN v_precio;
END //

-- Funciones sobre empleados

CREATE FUNCTION FN_SALARIO_PROMEDIO() RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_prom DECIMAL(10,2);
    SELECT AVG(salario) INTO v_prom FROM Empleados;
    RETURN v_prom;
END //

CREATE FUNCTION FN_EMPLEADOS_CON_PUESTO(p_puesto VARCHAR(100)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Empleados WHERE UPPER(puesto) = UPPER(p_puesto);
    RETURN v_count;
END //

CREATE FUNCTION FN_TIEMPO_SERVICIO(p_id_empleado INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_anios INT;
    SELECT FLOOR(TIMESTAMPDIFF(MONTH, fecha_contratacion, CURDATE()) / 12)
    INTO v_anios
    FROM Empleados
    WHERE id_empleado = p_id_empleado;
    RETURN v_anios;
END //

-- Funciones generales y de utilidad

CREATE FUNCTION FN_EXISTE_CLIENTE(p_id_cliente INT) RETURNS TINYINT(1)
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Clientes WHERE id_cliente = p_id_cliente;
    RETURN v_count > 0;
END //

CREATE FUNCTION FN_EXISTE_PROVEEDOR(p_id_proveedor INT) RETURNS TINYINT(1)
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Proveedores WHERE id_proveedor = p_id_proveedor;
    RETURN v_count > 0;
END //

CREATE FUNCTION FN_CALCULAR_SUBTOTAL(p_id_plato INT, p_cantidad INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_precio DECIMAL(10,2);
    SELECT precio_venta INTO v_precio FROM Menu WHERE id_plato = p_id_plato;
    RETURN v_precio * p_cantidad;
END //

CREATE FUNCTION FN_NUM_PEDIDOS_CLIENTE(p_id_cliente INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Pedidos WHERE id_cliente = p_id_cliente;
    RETURN v_count;
END //

CREATE FUNCTION FN_ESTADO_PEDIDO(p_id_pedido INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_estado VARCHAR(50);
    SELECT estado INTO v_estado FROM Pedidos WHERE id_pedido = p_id_pedido;
    RETURN v_estado;
END //

DELIMITER ;
