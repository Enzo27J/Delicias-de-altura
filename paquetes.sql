/* ===========================================================
   PAQUETES PL/SQL - PROYECTO: "DELICIAS DE ALTURA"
   Autores: Enzo Morales y Andrey Rodríguez
   Descripción: Encapsulación de procedimientos CRUD por entidad
=========================================================== */

/* ===========================================================
   PAQUETE: PROVEEDORES
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_PROVEEDORES AS
    PROCEDURE PA_CREAR_PROVEEDOR(p_nombre IN VARCHAR2, p_telefono IN VARCHAR2, p_direccion IN VARCHAR2);
    PROCEDURE PA_LEER_PROVEEDOR_ID(p_id_proveedor IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_PROVEEDOR(p_id_proveedor IN NUMBER, p_nombre IN VARCHAR2, p_telefono IN VARCHAR2, p_direccion IN VARCHAR2);
    PROCEDURE PA_ELIMINAR_PROVEEDOR(p_id_proveedor IN NUMBER);
END PKG_PROVEEDORES;
/
CREATE OR REPLACE PACKAGE BODY PKG_PROVEEDORES AS
    PROCEDURE PA_CREAR_PROVEEDOR(p_nombre IN VARCHAR2, p_telefono IN VARCHAR2, p_direccion IN VARCHAR2) IS
    BEGIN
        INSERT INTO Proveedores(nombre, telefono, direccion)
        VALUES(p_nombre, p_telefono, p_direccion);
        COMMIT;
    END;

    PROCEDURE PA_LEER_PROVEEDOR_ID(p_id_proveedor IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Proveedores WHERE id_proveedor = p_id_proveedor;
    END;

    PROCEDURE PA_ACTUALIZAR_PROVEEDOR(p_id_proveedor IN NUMBER, p_nombre IN VARCHAR2, p_telefono IN VARCHAR2, p_direccion IN VARCHAR2) IS
    BEGIN
        UPDATE Proveedores
        SET nombre = p_nombre, telefono = p_telefono, direccion = p_direccion
        WHERE id_proveedor = p_id_proveedor;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_PROVEEDOR(p_id_proveedor IN NUMBER) IS
    BEGIN
        DELETE FROM Proveedores WHERE id_proveedor = p_id_proveedor;
        COMMIT;
    END;
END PKG_PROVEEDORES;
/

/* ===========================================================
   PAQUETE: CLIENTES
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_CLIENTES AS
    PROCEDURE PA_CREAR_CLIENTE(p_nombre IN VARCHAR2, p_correo IN VARCHAR2, p_telefono IN VARCHAR2);
    PROCEDURE PA_LEER_CLIENTE_ID(p_id_cliente IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_CLIENTE(p_id_cliente IN NUMBER, p_nombre IN VARCHAR2, p_correo IN VARCHAR2, p_telefono IN VARCHAR2);
    PROCEDURE PA_ELIMINAR_CLIENTE(p_id_cliente IN NUMBER);
END PKG_CLIENTES;
/
CREATE OR REPLACE PACKAGE BODY PKG_CLIENTES AS
    PROCEDURE PA_CREAR_CLIENTE(p_nombre IN VARCHAR2, p_correo IN VARCHAR2, p_telefono IN VARCHAR2) IS
    BEGIN
        INSERT INTO Clientes(nombre, correo, telefono)
        VALUES(p_nombre, p_correo, p_telefono);
        COMMIT;
    END;

    PROCEDURE PA_LEER_CLIENTE_ID(p_id_cliente IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Clientes WHERE id_cliente = p_id_cliente;
    END;

    PROCEDURE PA_ACTUALIZAR_CLIENTE(p_id_cliente IN NUMBER, p_nombre IN VARCHAR2, p_correo IN VARCHAR2, p_telefono IN VARCHAR2) IS
    BEGIN
        UPDATE Clientes
        SET nombre = p_nombre, correo = p_correo, telefono = p_telefono
        WHERE id_cliente = p_id_cliente;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_CLIENTE(p_id_cliente IN NUMBER) IS
    BEGIN
        DELETE FROM Clientes WHERE id_cliente = p_id_cliente;
        COMMIT;
    END;
END PKG_CLIENTES;
/

/* ===========================================================
   PAQUETE: EMPLEADOS
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_EMPLEADOS AS
    PROCEDURE PA_CREAR_EMPLEADO(p_nombre IN VARCHAR2, p_puesto IN VARCHAR2, p_salario IN NUMBER, p_fecha_contratacion IN DATE);
    PROCEDURE PA_LEER_EMPLEADO_ID(p_id_empleado IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_EMPLEADO(p_id_empleado IN NUMBER, p_nombre IN VARCHAR2, p_puesto IN VARCHAR2, p_salario IN NUMBER, p_fecha_contratacion IN DATE);
    PROCEDURE PA_ELIMINAR_EMPLEADO(p_id_empleado IN NUMBER);
END PKG_EMPLEADOS;
/
CREATE OR REPLACE PACKAGE BODY PKG_EMPLEADOS AS
    PROCEDURE PA_CREAR_EMPLEADO(p_nombre IN VARCHAR2, p_puesto IN VARCHAR2, p_salario IN NUMBER, p_fecha_contratacion IN DATE) IS
    BEGIN
        INSERT INTO Empleados(nombre, puesto, salario, fecha_contratacion)
        VALUES(p_nombre, p_puesto, p_salario, p_fecha_contratacion);
        COMMIT;
    END;

    PROCEDURE PA_LEER_EMPLEADO_ID(p_id_empleado IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Empleados WHERE id_empleado = p_id_empleado;
    END;

    PROCEDURE PA_ACTUALIZAR_EMPLEADO(p_id_empleado IN NUMBER, p_nombre IN VARCHAR2, p_puesto IN VARCHAR2, p_salario IN NUMBER, p_fecha_contratacion IN DATE) IS
    BEGIN
        UPDATE Empleados
        SET nombre = p_nombre, puesto = p_puesto, salario = p_salario, fecha_contratacion = p_fecha_contratacion
        WHERE id_empleado = p_id_empleado;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_EMPLEADO(p_id_empleado IN NUMBER) IS
    BEGIN
        DELETE FROM Empleados WHERE id_empleado = p_id_empleado;
        COMMIT;
    END;
END PKG_EMPLEADOS;
/

/* ===========================================================
   PAQUETE: MENU
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_MENU AS
    PROCEDURE PA_CREAR_MENU(p_nombre IN VARCHAR2, p_descripcion IN CLOB, p_precio_venta IN NUMBER);
    PROCEDURE PA_LEER_MENU_ID(p_id_plato IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_MENU(p_id_plato IN NUMBER, p_nombre IN VARCHAR2, p_descripcion IN CLOB, p_precio_venta IN NUMBER);
    PROCEDURE PA_ELIMINAR_MENU(p_id_plato IN NUMBER);
END PKG_MENU;
/
CREATE OR REPLACE PACKAGE BODY PKG_MENU AS
    PROCEDURE PA_CREAR_MENU(p_nombre IN VARCHAR2, p_descripcion IN CLOB, p_precio_venta IN NUMBER) IS
    BEGIN
        INSERT INTO Menu(nombre, descripcion, precio_venta)
        VALUES(p_nombre, p_descripcion, p_precio_venta);
        COMMIT;
    END;

    PROCEDURE PA_LEER_MENU_ID(p_id_plato IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Menu WHERE id_plato = p_id_plato;
    END;

    PROCEDURE PA_ACTUALIZAR_MENU(p_id_plato IN NUMBER, p_nombre IN VARCHAR2, p_descripcion IN CLOB, p_precio_venta IN NUMBER) IS
    BEGIN
        UPDATE Menu
        SET nombre = p_nombre, descripcion = p_descripcion, precio_venta = p_precio_venta
        WHERE id_plato = p_id_plato;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_MENU(p_id_plato IN NUMBER) IS
    BEGIN
        DELETE FROM Menu WHERE id_plato = p_id_plato;
        COMMIT;
    END;
END PKG_MENU;
/

/* ===========================================================
   PAQUETE: PRODUCTOS
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_PRODUCTOS AS
    PROCEDURE PA_CREAR_PRODUCTO(p_nombre IN VARCHAR2, p_categoria IN VARCHAR2, p_precio_compra IN NUMBER, p_stock IN NUMBER, p_id_proveedor IN NUMBER);
    PROCEDURE PA_LEER_PRODUCTO_ID(p_id_producto IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_PRODUCTO(p_id_producto IN NUMBER, p_nombre IN VARCHAR2, p_categoria IN VARCHAR2, p_precio_compra IN NUMBER, p_stock IN NUMBER, p_id_proveedor IN NUMBER);
    PROCEDURE PA_ELIMINAR_PRODUCTO(p_id_producto IN NUMBER);
END PKG_PRODUCTOS;
/
CREATE OR REPLACE PACKAGE BODY PKG_PRODUCTOS AS
    PROCEDURE PA_CREAR_PRODUCTO(p_nombre IN VARCHAR2, p_categoria IN VARCHAR2, p_precio_compra IN NUMBER, p_stock IN NUMBER, p_id_proveedor IN NUMBER) IS
    BEGIN
        INSERT INTO Productos(nombre, categoria, precio_compra, stock, id_proveedor)
        VALUES(p_nombre, p_categoria, p_precio_compra, p_stock, p_id_proveedor);
        COMMIT;
    END;

    PROCEDURE PA_LEER_PRODUCTO_ID(p_id_producto IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Productos WHERE id_producto = p_id_producto;
    END;

    PROCEDURE PA_ACTUALIZAR_PRODUCTO(p_id_producto IN NUMBER, p_nombre IN VARCHAR2, p_categoria IN VARCHAR2, p_precio_compra IN NUMBER, p_stock IN NUMBER, p_id_proveedor IN NUMBER) IS
    BEGIN
        UPDATE Productos
        SET nombre = p_nombre, categoria = p_categoria, precio_compra = p_precio_compra, stock = p_stock, id_proveedor = p_id_proveedor
        WHERE id_producto = p_id_producto;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_PRODUCTO(p_id_producto IN NUMBER) IS
    BEGIN
        DELETE FROM Productos WHERE id_producto = p_id_producto;
        COMMIT;
    END;
END PKG_PRODUCTOS;
/

/* ===========================================================
   PAQUETE: PEDIDOS
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_PEDIDOS AS
    PROCEDURE PA_CREAR_PEDIDO(p_fecha IN DATE, p_id_cliente IN NUMBER);
    PROCEDURE PA_LEER_PEDIDO_ID(p_id_pedido IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_PEDIDO(p_id_pedido IN NUMBER, p_fecha IN DATE, p_total IN NUMBER, p_estado IN VARCHAR2, p_id_cliente IN NUMBER);
    PROCEDURE PA_ELIMINAR_PEDIDO(p_id_pedido IN NUMBER);
END PKG_PEDIDOS;
/
CREATE OR REPLACE PACKAGE BODY PKG_PEDIDOS AS
    PROCEDURE PA_CREAR_PEDIDO(p_fecha IN DATE, p_id_cliente IN NUMBER) IS
    BEGIN
        INSERT INTO Pedidos(fecha, total, estado, id_cliente)
        VALUES(p_fecha, 0, 'En Proceso', p_id_cliente);
        COMMIT;
    END;

    PROCEDURE PA_LEER_PEDIDO_ID(p_id_pedido IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Pedidos WHERE id_pedido = p_id_pedido;
    END;

    PROCEDURE PA_ACTUALIZAR_PEDIDO(p_id_pedido IN NUMBER, p_fecha IN DATE, p_total IN NUMBER, p_estado IN VARCHAR2, p_id_cliente IN NUMBER) IS
    BEGIN
        UPDATE Pedidos
        SET fecha = p_fecha, total = p_total, estado = p_estado, id_cliente = p_id_cliente
        WHERE id_pedido = p_id_pedido;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_PEDIDO(p_id_pedido IN NUMBER) IS
    BEGIN
        DELETE FROM Pedidos WHERE id_pedido = p_id_pedido;
        COMMIT;
    END;
END PKG_PEDIDOS;
/

/* ===========================================================
   PAQUETE: DETALLE_PEDIDO
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_DETALLE_PEDIDO AS
    PROCEDURE PA_CREAR_DETALLE_PEDIDO(p_id_pedido IN NUMBER, p_id_plato IN NUMBER, p_cantidad IN NUMBER, p_subtotal IN NUMBER);
    PROCEDURE PA_LEER_DETALLE_ID(p_id_detalle IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_DETALLE_PEDIDO(p_id_detalle IN NUMBER, p_cantidad IN NUMBER, p_subtotal IN NUMBER);
    PROCEDURE PA_ELIMINAR_DETALLE_PEDIDO(p_id_detalle IN NUMBER);
END PKG_DETALLE_PEDIDO;
/
CREATE OR REPLACE PACKAGE BODY PKG_DETALLE_PEDIDO AS
    PROCEDURE PA_CREAR_DETALLE_PEDIDO(p_id_pedido IN NUMBER, p_id_plato IN NUMBER, p_cantidad IN NUMBER, p_subtotal IN NUMBER) IS
    BEGIN
        INSERT INTO Detalle_Pedido(id_pedido, id_plato, cantidad, subtotal)
        VALUES(p_id_pedido, p_id_plato, p_cantidad, p_subtotal);
        COMMIT;
    END;

    PROCEDURE PA_LEER_DETALLE_ID(p_id_detalle IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Detalle_Pedido WHERE id_detalle = p_id_detalle;
    END;

    PROCEDURE PA_ACTUALIZAR_DETALLE_PEDIDO(p_id_detalle IN NUMBER, p_cantidad IN NUMBER, p_subtotal IN NUMBER) IS
    BEGIN
        UPDATE Detalle_Pedido
        SET cantidad = p_cantidad, subtotal = p_subtotal
        WHERE id_detalle = p_id_detalle;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_DETALLE_PEDIDO(p_id_detalle IN NUMBER) IS
    BEGIN
        DELETE FROM Detalle_Pedido WHERE id_detalle = p_id_detalle;
        COMMIT;
    END;
END PKG_DETALLE_PEDIDO;
/

/* ===========================================================
   PAQUETE: FACTURAS
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_FACTURAS AS
    PROCEDURE PA_CREAR_FACTURA(p_id_pedido IN NUMBER, p_fecha_emision IN DATE, p_monto_total IN NUMBER, p_metodo_pago IN VARCHAR2);
    PROCEDURE PA_LEER_FACTURA_ID(p_id_factura IN NUMBER, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_ACTUALIZAR_FACTURA(p_id_factura IN NUMBER, p_fecha_emision IN DATE, p_monto_total IN NUMBER, p_metodo_pago IN VARCHAR2);
    PROCEDURE PA_ELIMINAR_FACTURA(p_id_factura IN NUMBER);
END PKG_FACTURAS;
/
CREATE OR REPLACE PACKAGE BODY PKG_FACTURAS AS
    PROCEDURE PA_CREAR_FACTURA(p_id_pedido IN NUMBER, p_fecha_emision IN DATE, p_monto_total IN NUMBER, p_metodo_pago IN VARCHAR2) IS
    BEGIN
        INSERT INTO Facturas(id_pedido, fecha_emision, monto_total, metodo_pago)
        VALUES(p_id_pedido, p_fecha_emision, p_monto_total, p_metodo_pago);
        COMMIT;
    END;

    PROCEDURE PA_LEER_FACTURA_ID(p_id_factura IN NUMBER, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR SELECT * FROM Facturas WHERE id_factura = p_id_factura;
    END;

    PROCEDURE PA_ACTUALIZAR_FACTURA(p_id_factura IN NUMBER, p_fecha_emision IN DATE, p_monto_total IN NUMBER, p_metodo_pago IN VARCHAR2) IS
    BEGIN
        UPDATE Facturas
        SET fecha_emision = p_fecha_emision, monto_total = p_monto_total, metodo_pago = p_metodo_pago
        WHERE id_factura = p_id_factura;
        COMMIT;
    END;

    PROCEDURE PA_ELIMINAR_FACTURA(p_id_factura IN NUMBER) IS
    BEGIN
        DELETE FROM Facturas WHERE id_factura = p_id_factura;
        COMMIT;
    END;
END PKG_FACTURAS;
/

/* ===========================================================
   PAQUETE: REPORTES
   Generación de informes de ventas, pedidos e inventario
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_REPORTES AS
    PROCEDURE PA_REPORTE_VENTAS(p_fecha_inicio IN DATE, p_fecha_fin IN DATE, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_REPORTE_PEDIDOS(p_fecha_inicio IN DATE, p_fecha_fin IN DATE, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE PA_REPORTE_INVENTARIO(p_cursor OUT SYS_REFCURSOR);
END PKG_REPORTES;
/
CREATE OR REPLACE PACKAGE BODY PKG_REPORTES AS
    PROCEDURE PA_REPORTE_VENTAS(p_fecha_inicio IN DATE, p_fecha_fin IN DATE, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR
            SELECT F.id_factura,
                   F.fecha_emision,
                   F.monto_total,
                   C.nombre AS cliente,
                   P.id_pedido
              FROM Facturas F
              JOIN Pedidos P ON F.id_pedido = P.id_pedido
              JOIN Clientes C ON P.id_cliente = C.id_cliente
             WHERE F.fecha_emision BETWEEN p_fecha_inicio AND p_fecha_fin
             ORDER BY F.fecha_emision;
    END;

    PROCEDURE PA_REPORTE_PEDIDOS(p_fecha_inicio IN DATE, p_fecha_fin IN DATE, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR
            SELECT P.id_pedido,
                   C.nombre AS cliente,
                   P.fecha,
                   P.total,
                   P.estado
              FROM Pedidos P
              JOIN Clientes C ON P.id_cliente = C.id_cliente
             WHERE P.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
             ORDER BY P.fecha;
    END;

    PROCEDURE PA_REPORTE_INVENTARIO(p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR
            SELECT PR.id_producto,
                   PR.nombre,
                   PR.categoria,
                   PR.stock,
                   PR.precio_compra,
                   PROV.nombre AS proveedor
              FROM Productos PR
              JOIN Proveedores PROV ON PR.id_proveedor = PROV.id_proveedor
             ORDER BY PR.nombre;
    END;
END PKG_REPORTES;
/

/* ===========================================================
   PAQUETE: UTILIDADES
   Funciones y procedimientos auxiliares
=========================================================== */
CREATE OR REPLACE PACKAGE PKG_UTILIDADES AS
    FUNCTION PA_CALCULAR_TOTAL_PEDIDO(p_id_pedido IN NUMBER) RETURN NUMBER;
    PROCEDURE PA_ACTUALIZAR_TOTAL_PEDIDO(p_id_pedido IN NUMBER);
    FUNCTION PA_OBTENER_STOCK_PRODUCTO(p_id_producto IN NUMBER) RETURN NUMBER;
END PKG_UTILIDADES;
/
CREATE OR REPLACE PACKAGE BODY PKG_UTILIDADES AS
    FUNCTION PA_CALCULAR_TOTAL_PEDIDO(p_id_pedido IN NUMBER) RETURN NUMBER IS
        v_total NUMBER := 0;
    BEGIN
        SELECT NVL(SUM(subtotal),0)
        INTO v_total
        FROM Detalle_Pedido
        WHERE id_pedido = p_id_pedido;
        RETURN v_total;
    END;

    PROCEDURE PA_ACTUALIZAR_TOTAL_PEDIDO(p_id_pedido IN NUMBER) IS
        v_total NUMBER;
    BEGIN
        v_total := PA_CALCULAR_TOTAL_PEDIDO(p_id_pedido);
        UPDATE Pedidos
        SET total = v_total
        WHERE id_pedido = p_id_pedido;
        COMMIT;
    END;

    FUNCTION PA_OBTENER_STOCK_PRODUCTO(p_id_producto IN NUMBER) RETURN NUMBER IS
        v_stock NUMBER;
    BEGIN
        SELECT stock INTO v_stock
        FROM Productos
        WHERE id_producto = p_id_producto;
        RETURN v_stock;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END;
END PKG_UTILIDADES;
/
