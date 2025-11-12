/* ===========================================================
   CURSORES EXPLÍCITOS - PROYECTO "DELICIAS DE ALTURA"
   Autores: Enzo Morales y Andrey Rodríguez
   Descripción: Consultas iterativas para informes y procesos
   =========================================================== */

/*============================================================
  CURSOR: Listar todos los clientes
============================================================*/
DECLARE
    CURSOR cur_clientes IS
        SELECT id_cliente, nombre, correo, telefono FROM Clientes;
    v_cliente Clientes%ROWTYPE;
BEGIN
    FOR v_cliente IN cur_clientes LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_cliente.nombre || ' - ' || v_cliente.correo);
    END LOOP;
END;
/

/*============================================================
  CURSOR: Listar empleados con su salario
============================================================*/
DECLARE
    CURSOR cur_empleados IS
        SELECT nombre, puesto, salario FROM Empleados;
    v_empleado cur_empleados%ROWTYPE;
BEGIN
    FOR v_empleado IN cur_empleados LOOP
        DBMS_OUTPUT.PUT_LINE(v_empleado.nombre || ' (' || v_empleado.puesto || ') - $' || v_empleado.salario);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Productos con stock bajo
============================================================*/
DECLARE
    CURSOR cur_stock_bajo IS
        SELECT nombre, stock FROM Productos WHERE stock < 10;
BEGIN
    FOR r IN cur_stock_bajo LOOP
        DBMS_OUTPUT.PUT_LINE('ALERTA: ' || r.nombre || ' tiene solo ' || r.stock || ' unidades.');
    END LOOP;
END;
/


/*============================================================
  CURSOR: Platos del menú con su precio
============================================================*/
DECLARE
    CURSOR cur_menu IS
        SELECT nombre, precio_venta FROM Menu;
BEGIN
    FOR r IN cur_menu LOOP
        DBMS_OUTPUT.PUT_LINE('Plato: ' || r.nombre || ' - Precio: $' || r.precio_venta);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Pedidos pendientes de cierre
============================================================*/
DECLARE
    CURSOR cur_pedidos IS
        SELECT id_pedido, fecha, estado FROM Pedidos WHERE estado <> 'Cerrado';
BEGIN
    FOR r IN cur_pedidos LOOP
        DBMS_OUTPUT.PUT_LINE('Pedido ' || r.id_pedido || ' (' || r.estado || ') - ' || r.fecha);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Detalle de pedido por ID específico
============================================================*/
DECLARE
    v_id_pedido NUMBER := 1;
    CURSOR cur_detalle IS
        SELECT id_plato, cantidad, subtotal FROM Detalle_Pedido WHERE id_pedido = v_id_pedido;
BEGIN
    FOR r IN cur_detalle LOOP
        DBMS_OUTPUT.PUT_LINE('Plato: ' || r.id_plato || ' | Cantidad: ' || r.cantidad || ' | Subtotal: $' || r.subtotal);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Facturas emitidas hoy
============================================================*/
DECLARE
    CURSOR cur_facturas IS
        SELECT id_factura, monto_total, metodo_pago FROM Facturas WHERE TRUNC(fecha_emision) = TRUNC(SYSDATE);
BEGIN
    FOR r IN cur_facturas LOOP
        DBMS_OUTPUT.PUT_LINE('Factura ' || r.id_factura || ' - Total: $' || r.monto_total || ' - Pago: ' || r.metodo_pago);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Total de ventas por cliente
============================================================*/
DECLARE
    CURSOR cur_ventas_cliente IS
        SELECT C.nombre, SUM(F.monto_total) total_ventas
        FROM Facturas F
        JOIN Pedidos P ON F.id_pedido = P.id_pedido
        JOIN Clientes C ON P.id_cliente = C.id_cliente
        GROUP BY C.nombre;
BEGIN
    FOR r IN cur_ventas_cliente LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || r.nombre || ' - Total Vendido: $' || r.total_ventas);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Productos por proveedor
============================================================*/
DECLARE
    CURSOR cur_productos_prov IS
        SELECT P.nombre AS producto, R.nombre AS proveedor
        FROM Productos P
        JOIN Proveedores R ON P.id_proveedor = R.id_proveedor;
BEGIN
    FOR r IN cur_productos_prov LOOP
        DBMS_OUTPUT.PUT_LINE(r.producto || ' - Proveedor: ' || r.proveedor);
    END LOOP;
END;
/


/*============================================================
CURSOR: Empleados contratados este año
============================================================*/
DECLARE
    CURSOR cur_empleados_nuevos IS
        SELECT nombre, fecha_contratacion FROM Empleados
        WHERE EXTRACT(YEAR FROM fecha_contratacion) = EXTRACT(YEAR FROM SYSDATE);
BEGIN
    FOR r IN cur_empleados_nuevos LOOP
        DBMS_OUTPUT.PUT_LINE('Empleado: ' || r.nombre || ' - Contratado: ' || r.fecha_contratacion);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Pedidos con total superior a $100
============================================================*/
DECLARE
    CURSOR cur_pedidos_grandes IS
        SELECT id_pedido, total FROM Pedidos WHERE total > 100;
BEGIN
    FOR r IN cur_pedidos_grandes LOOP
        DBMS_OUTPUT.PUT_LINE('Pedido ' || r.id_pedido || ' supera $100 con total: ' || r.total);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Reporte de inventario completo
============================================================*/
DECLARE
    CURSOR cur_inventario IS
        SELECT nombre, categoria, stock, precio_compra FROM Productos;
BEGIN
    FOR r IN cur_inventario LOOP
        DBMS_OUTPUT.PUT_LINE(r.nombre || ' | ' || r.categoria || ' | Stock: ' || r.stock || ' | Precio: $' || r.precio_compra);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Facturas y pedidos asociados
============================================================*/
DECLARE
    CURSOR cur_factura_pedido IS
        SELECT F.id_factura, P.id_pedido, F.monto_total
        FROM Facturas F JOIN Pedidos P ON F.id_pedido = P.id_pedido;
BEGIN
    FOR r IN cur_factura_pedido LOOP
        DBMS_OUTPUT.PUT_LINE('Factura ' || r.id_factura || ' -> Pedido ' || r.id_pedido || ' | Total: ' || r.monto_total);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Clientes sin pedidos registrados
============================================================*/
DECLARE
    CURSOR cur_clientes_sin_pedidos IS
        SELECT C.id_cliente, C.nombre FROM Clientes C
        WHERE NOT EXISTS (SELECT 1 FROM Pedidos P WHERE P.id_cliente = C.id_cliente);
BEGIN
    FOR r IN cur_clientes_sin_pedidos LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente sin pedidos: ' || r.nombre);
    END LOOP;
END;
/


/*============================================================
  CURSOR: Log de movimientos de stock
============================================================*/
DECLARE
    CURSOR cur_log_stock IS
        SELECT id_producto, stock_anterior, stock_nuevo, fecha_cambio, usuario FROM LOG_STOCK;
BEGIN
    FOR r IN cur_log_stock LOOP
        DBMS_OUTPUT.PUT_LINE('Prod: ' || r.id_producto || ' | Stock: ' || r.stock_anterior || ' → ' || r.stock_nuevo || ' | Fecha: ' || r.fecha_cambio);
    END LOOP;
END;
/
