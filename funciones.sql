-- Funciones sobre facturación y ventas

CREATE OR REPLACE FUNCTION FN_TOTAL_PEDIDO(p_id_pedido NUMBER) RETURN NUMBER IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(subtotal), 0)
    INTO v_total
    FROM Detalle_Pedido
    WHERE id_pedido = p_id_pedido;

    RETURN v_total;
END;
/

CREATE OR REPLACE FUNCTION FN_TOTAL_VENTAS_FECHA(p_fecha DATE) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(monto_total), 0)
    INTO v_total
    FROM Facturas
    WHERE TRUNC(fecha_emision) = TRUNC(p_fecha);

    RETURN v_total;
END;
/

CREATE OR REPLACE FUNCTION FN_TOTAL_VENTAS_CLIENTE(p_id_cliente NUMBER) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(F.monto_total), 0)
    INTO v_total
    FROM Facturas F
    JOIN Pedidos P ON F.id_pedido = P.id_pedido
    WHERE P.id_cliente = p_id_cliente;

    RETURN v_total;
END;
/

-- Funciones sobre inventario y menú

CREATE OR REPLACE FUNCTION FN_STOCK_PRODUCTO(p_id_producto NUMBER) RETURN NUMBER IS
    v_stock NUMBER;
BEGIN
    SELECT stock INTO v_stock FROM Productos WHERE id_producto = p_id_producto;
    RETURN v_stock;
END;
/

CREATE OR REPLACE FUNCTION FN_PRODUCTOS_BAJOS_STOCK RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Productos WHERE stock < 10;
    RETURN v_count;
END;
/

CREATE OR REPLACE FUNCTION FN_PRECIO_PLATO(p_id_plato NUMBER) RETURN NUMBER IS
    v_precio NUMBER;
BEGIN
    SELECT precio_venta INTO v_precio FROM Menu WHERE id_plato = p_id_plato;
    RETURN v_precio;
END;
/

-- Funciones sobre empleados

CREATE OR REPLACE FUNCTION FN_SALARIO_PROMEDIO RETURN NUMBER IS
    v_prom NUMBER;
BEGIN
    SELECT AVG(salario) INTO v_prom FROM Empleados;
    RETURN v_prom;
END;
/

CREATE OR REPLACE FUNCTION FN_EMPLEADOS_CON_PUESTO(p_puesto VARCHAR2) RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Empleados WHERE UPPER(puesto) = UPPER(p_puesto);
    RETURN v_count;
END;
/

CREATE OR REPLACE FUNCTION FN_TIEMPO_SERVICIO(p_id_empleado NUMBER) RETURN NUMBER IS
    v_anios NUMBER;
BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contratacion) / 12)
    INTO v_anios
    FROM Empleados
    WHERE id_empleado = p_id_empleado;

    RETURN v_anios;
END;
/

-- Funciones generales y de utilidad

CREATE OR REPLACE FUNCTION FN_EXISTE_CLIENTE(p_id_cliente NUMBER) RETURN BOOLEAN IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Clientes WHERE id_cliente = p_id_cliente;
    RETURN v_count > 0;
END;
/

CREATE OR REPLACE FUNCTION FN_EXISTE_PROVEEDOR(p_id_proveedor NUMBER) RETURN BOOLEAN IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Proveedores WHERE id_proveedor = p_id_proveedor;
    RETURN v_count > 0;
END;
/

CREATE OR REPLACE FUNCTION FN_CALCULAR_SUBTOTAL(p_id_plato NUMBER, p_cantidad NUMBER) RETURN NUMBER IS
    v_precio NUMBER;
BEGIN
    SELECT precio_venta INTO v_precio FROM Menu WHERE id_plato = p_id_plato;
    RETURN v_precio * p_cantidad;
END;
/

CREATE OR REPLACE FUNCTION FN_NUM_PEDIDOS_CLIENTE(p_id_cliente NUMBER) RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Pedidos WHERE id_cliente = p_id_cliente;
    RETURN v_count;
END;
/

CREATE OR REPLACE FUNCTION FN_ESTADO_PEDIDO(p_id_pedido NUMBER) RETURN VARCHAR2 IS
    v_estado VARCHAR2(50);
BEGIN
    SELECT estado INTO v_estado FROM Pedidos WHERE id_pedido = p_id_pedido;
    RETURN v_estado;
END;
/
