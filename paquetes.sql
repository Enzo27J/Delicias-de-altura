/* ===========================================================
   PAQUETES PL/SQL - PROYECTO "DELICIAS DE ALTURA"
   Autores: Enzo Morales y Andrey Rodríguez
   Descripción: Estructura modular de lógica de negocio
   =========================================================== */


/*============================================================
  PAQUETE: CLIENTES_PKG
  CRUD y funciones relacionadas con clientes
============================================================*/
CREATE OR REPLACE PACKAGE CLIENTES_PKG AS
    PROCEDURE crear_cliente(p_nombre VARCHAR2, p_correo VARCHAR2, p_telefono VARCHAR2);
    PROCEDURE actualizar_cliente(p_id NUMBER, p_nombre VARCHAR2, p_correo VARCHAR2, p_telefono VARCHAR2);
    PROCEDURE eliminar_cliente(p_id NUMBER);
    FUNCTION obtener_total_pedidos(p_id NUMBER) RETURN NUMBER;
END CLIENTES_PKG;
/

CREATE OR REPLACE PACKAGE BODY CLIENTES_PKG AS
    PROCEDURE crear_cliente(p_nombre VARCHAR2, p_correo VARCHAR2, p_telefono VARCHAR2) IS
    BEGIN
        INSERT INTO Clientes (nombre, correo, telefono)
        VALUES (p_nombre, p_correo, p_telefono);
        COMMIT;
    END;

    PROCEDURE actualizar_cliente(p_id NUMBER, p_nombre VARCHAR2, p_correo VARCHAR2, p_telefono VARCHAR2) IS
    BEGIN
        UPDATE Clientes SET nombre=p_nombre, correo=p_correo, telefono=p_telefono WHERE id_cliente=p_id;
        COMMIT;
    END;

    PROCEDURE eliminar_cliente(p_id NUMBER) IS
    BEGIN
        DELETE FROM Clientes WHERE id_cliente=p_id;
        COMMIT;
    END;

    FUNCTION obtener_total_pedidos(p_id NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total FROM Pedidos WHERE id_cliente=p_id;
        RETURN v_total;
    END;
END CLIENTES_PKG;
/

/*============================================================
  PAQUETE: PROVEEDORES_PKG
  CRUD y utilidades de proveedores
============================================================*/
CREATE OR REPLACE PACKAGE PROVEEDORES_PKG AS
    PROCEDURE crear_proveedor(p_nombre VARCHAR2, p_telefono VARCHAR2, p_direccion VARCHAR2);
    FUNCTION total_productos_suministrados(p_id NUMBER) RETURN NUMBER;
END PROVEEDORES_PKG;
/

CREATE OR REPLACE PACKAGE BODY PROVEEDORES_PKG AS
    PROCEDURE crear_proveedor(p_nombre VARCHAR2, p_telefono VARCHAR2, p_direccion VARCHAR2) IS
    BEGIN
        INSERT INTO Proveedores (nombre, telefono, direccion)
        VALUES (p_nombre, p_telefono, p_direccion);
        COMMIT;
    END;

    FUNCTION total_productos_suministrados(p_id NUMBER) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Productos WHERE id_proveedor = p_id;
        RETURN v_count;
    END;
END PROVEEDORES_PKG;
/

/*============================================================
  PAQUETE: EMPLEADOS_PKG
  Acá vamos a empaquetar la gestión de empleados
============================================================*/
CREATE OR REPLACE PACKAGE EMPLEADOS_PKG AS
    PROCEDURE crear_empleado(p_nombre VARCHAR2, p_puesto VARCHAR2, p_salario NUMBER, p_fecha DATE);
    FUNCTION salario_promedio RETURN NUMBER;
END EMPLEADOS_PKG;
/

CREATE OR REPLACE PACKAGE BODY EMPLEADOS_PKG AS
    PROCEDURE crear_empleado(p_nombre VARCHAR2, p_puesto VARCHAR2, p_salario NUMBER, p_fecha DATE) IS
    BEGIN
        INSERT INTO Empleados (nombre, puesto, salario, fecha_contratacion)
        VALUES (p_nombre, p_puesto, p_salario, p_fecha);
        COMMIT;
    END;

    FUNCTION salario_promedio RETURN NUMBER IS
        v_prom NUMBER;
    BEGIN
        SELECT AVG(salario) INTO v_prom FROM Empleados;
        RETURN v_prom;
    END;
END EMPLEADOS_PKG;
/

/*============================================================
  PAQUETE: PRODUCTOS_PKG
  Control de inventario y stock
============================================================*/
CREATE OR REPLACE PACKAGE PRODUCTOS_PKG AS
    PROCEDURE crear_producto(p_nombre VARCHAR2, p_categoria VARCHAR2, p_precio NUMBER, p_stock NUMBER, p_id_proveedor NUMBER);
    FUNCTION stock_producto(p_id NUMBER) RETURN NUMBER;
END PRODUCTOS_PKG;
/

CREATE OR REPLACE PACKAGE BODY PRODUCTOS_PKG AS
    PROCEDURE crear_producto(p_nombre VARCHAR2, p_categoria VARCHAR2, p_precio NUMBER, p_stock NUMBER, p_id_proveedor NUMBER) IS
    BEGIN
        INSERT INTO Productos (nombre, categoria, precio_compra, stock, id_proveedor)
        VALUES (p_nombre, p_categoria, p_precio, p_stock, p_id_proveedor);
        COMMIT;
    END;

    FUNCTION stock_producto(p_id NUMBER) RETURN NUMBER IS
        v_stock NUMBER;
    BEGIN
        SELECT stock INTO v_stock FROM Productos WHERE id_producto=p_id;
        RETURN v_stock;
    END;
END PRODUCTOS_PKG;
/

/*============================================================
  PAQUETE: MENU_PKG
  Manejo de platos del menú
============================================================*/
CREATE OR REPLACE PACKAGE MENU_PKG AS
    PROCEDURE crear_plato(p_nombre VARCHAR2, p_desc CLOB, p_precio NUMBER);
    FUNCTION precio_plato(p_id NUMBER) RETURN NUMBER;
END MENU_PKG;
/

CREATE OR REPLACE PACKAGE BODY MENU_PKG AS
    PROCEDURE crear_plato(p_nombre VARCHAR2, p_desc CLOB, p_precio NUMBER) IS
    BEGIN
        INSERT INTO Menu (nombre, descripcion, precio_venta)
        VALUES (p_nombre, p_desc, p_precio);
        COMMIT;
    END;

    FUNCTION precio_plato(p_id NUMBER) RETURN NUMBER IS
        v_precio NUMBER;
    BEGIN
        SELECT precio_venta INTO v_precio FROM Menu WHERE id_plato=p_id;
        RETURN v_precio;
    END;
END MENU_PKG;
/

/*============================================================
  PAQUETE: PEDIDOS_PKG
  Control de pedidos y totales
============================================================*/
CREATE OR REPLACE PACKAGE PEDIDOS_PKG AS
    PROCEDURE crear_pedido(p_fecha DATE, p_id_cliente NUMBER);
    FUNCTION total_pedido(p_id NUMBER) RETURN NUMBER;
END PEDIDOS_PKG;
/

CREATE OR REPLACE PACKAGE BODY PEDIDOS_PKG AS
    PROCEDURE crear_pedido(p_fecha DATE, p_id_cliente NUMBER) IS
    BEGIN
        INSERT INTO Pedidos (fecha, total, estado, id_cliente)
        VALUES (p_fecha, 0, 'En Proceso', p_id_cliente);
        COMMIT;
    END;

    FUNCTION total_pedido(p_id NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(subtotal), 0)
        INTO v_total
        FROM Detalle_Pedido
        WHERE id_pedido = p_id;
        RETURN v_total;
    END;
END PEDIDOS_PKG;
/

/*============================================================
  PAQUETE: DETALLE_PEDIDO_PKG
  Gestión de detalles de pedido
============================================================*/
CREATE OR REPLACE PACKAGE DETALLE_PEDIDO_PKG AS
    PROCEDURE agregar_detalle(p_id_pedido NUMBER, p_id_plato NUMBER, p_cantidad NUMBER);
END DETALLE_PEDIDO_PKG;
/

CREATE OR REPLACE PACKAGE BODY DETALLE_PEDIDO_PKG AS
    PROCEDURE agregar_detalle(p_id_pedido NUMBER, p_id_plato NUMBER, p_cantidad NUMBER) IS
        v_subtotal NUMBER;
    BEGIN
        SELECT precio_venta * p_cantidad INTO v_subtotal FROM Menu WHERE id_plato=p_id_plato;
        INSERT INTO Detalle_Pedido (id_pedido, id_plato, cantidad, subtotal)
        VALUES (p_id_pedido, p_id_plato, p_cantidad, v_subtotal);
        COMMIT;
    END;
END DETALLE_PEDIDO_PKG;
/

/*============================================================
  PAQUETE: FACTURAS_PKG
  Generación y consulta de facturas
============================================================*/
CREATE OR REPLACE PACKAGE FACTURAS_PKG AS
    PROCEDURE crear_factura(p_id_pedido NUMBER, p_metodo VARCHAR2);
END FACTURAS_PKG;
/

CREATE OR REPLACE PACKAGE BODY FACTURAS_PKG AS
    PROCEDURE crear_factura(p_id_pedido NUMBER, p_metodo VARCHAR2) IS
        v_total NUMBER;
    BEGIN
        SELECT total INTO v_total FROM Pedidos WHERE id_pedido=p_id_pedido;
        INSERT INTO Facturas (id_pedido, fecha_emision, monto_total, metodo_pago)
        VALUES (p_id_pedido, SYSDATE, v_total, p_metodo);
        COMMIT;
    END;
END FACTURAS_PKG;
/

/*============================================================
  PAQUETE: REPORTES_PKG
  Reportes de ventas, inventario y clientes
============================================================*/
CREATE OR REPLACE PACKAGE REPORTES_PKG AS
    PROCEDURE reporte_ventas_fecha(p_fecha DATE, p_cursor OUT SYS_REFCURSOR);
    PROCEDURE reporte_inventario_bajo(p_cursor OUT SYS_REFCURSOR);
END REPORTES_PKG;
/

CREATE OR REPLACE PACKAGE BODY REPORTES_PKG AS
    PROCEDURE reporte_ventas_fecha(p_fecha DATE, p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR
            SELECT F.id_factura, C.nombre, F.monto_total, F.metodo_pago
            FROM Facturas F
            JOIN Pedidos P ON F.id_pedido=P.id_pedido
            JOIN Clientes C ON P.id_cliente=C.id_cliente
            WHERE TRUNC(F.fecha_emision)=TRUNC(p_fecha);
    END;

    PROCEDURE reporte_inventario_bajo(p_cursor OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_cursor FOR
            SELECT nombre, stock, precio_compra FROM Productos WHERE stock < 10;
    END;
END REPORTES_PKG;
/

/*============================================================
  PAQUETE: UTILIDADES_PKG
  Funciones generales de soporte y validación
============================================================*/
CREATE OR REPLACE PACKAGE UTILIDADES_PKG AS
    FUNCTION existe_cliente(p_id NUMBER) RETURN BOOLEAN;
    FUNCTION existe_proveedor(p_id NUMBER) RETURN BOOLEAN;
END UTILIDADES_PKG;
/

CREATE OR REPLACE PACKAGE BODY UTILIDADES_PKG AS
    FUNCTION existe_cliente(p_id NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Clientes WHERE id_cliente=p_id;
        RETURN v_count > 0;
    END;

    FUNCTION existe_proveedor(p_id NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM Proveedores WHERE id_proveedor=p_id;
        RETURN v_count > 0;
    END;
END UTILIDADES_PKG;
/
