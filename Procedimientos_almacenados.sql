CREATE OR REPLACE PACKAGE Tipos_Comunes AS
    TYPE t_cursor IS REF CURSOR;
END Tipos_Comunes;

// Proveedores
CREATE OR REPLACE PROCEDURE PA_CREAR_PROVEEDOR (
    p_nombre IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_direccion IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Proveedores (nombre, telefono, direccion)
    VALUES (p_nombre, p_telefono, p_direccion);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_PROVEEDOR_ID (
    p_id_proveedor IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_proveedor, nombre, telefono, direccion
        FROM Proveedores
        WHERE id_proveedor = p_id_proveedor;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_PROVEEDOR (
    p_id_proveedor IN NUMBER,
    p_nombre IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_direccion IN VARCHAR2
)
IS
BEGIN
    UPDATE Proveedores
    SET
        nombre = p_nombre,
        telefono = p_telefono,
        direccion = p_direccion
    WHERE id_proveedor = p_id_proveedor;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_PROVEEDOR (
    p_id_proveedor IN NUMBER
)
IS
BEGIN
    DELETE FROM Proveedores
    WHERE id_proveedor = p_id_proveedor;
    COMMIT;
END;

// Clientes
CREATE OR REPLACE PROCEDURE PA_CREAR_CLIENTE (
    p_nombre IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_telefono IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Clientes (nombre, correo, telefono)
    VALUES (p_nombre, p_correo, p_telefono);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_CLIENTE_ID (
    p_id_cliente IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_cliente, nombre, correo, telefono
        FROM Clientes
        WHERE id_cliente = p_id_cliente;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_CLIENTE (
    p_id_cliente IN NUMBER,
    p_nombre IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_telefono IN VARCHAR2
)
IS
BEGIN
    UPDATE Clientes
    SET
        nombre = p_nombre,
        correo = p_correo,
        telefono = p_telefono
    WHERE id_cliente = p_id_cliente;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_CLIENTE (
    p_id_cliente IN NUMBER
)
IS
BEGIN
    DELETE FROM Clientes
    WHERE id_cliente = p_id_cliente;
    COMMIT;
END;

// Empleados
CREATE OR REPLACE PROCEDURE PA_CREAR_EMPLEADO (
    p_nombre IN VARCHAR2,
    p_puesto IN VARCHAR2,
    p_salario IN NUMBER,
    p_fecha_contratacion IN DATE
)
IS
BEGIN
    INSERT INTO Empleados (nombre, puesto, salario, fecha_contratacion)
    VALUES (p_nombre, p_puesto, p_salario, p_fecha_contratacion);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_EMPLEADO_ID (
    p_id_empleado IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_empleado, nombre, puesto, salario, fecha_contratacion
        FROM Empleados
        WHERE id_empleado = p_id_empleado;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_EMPLEADO (
    p_id_empleado IN NUMBER,
    p_nombre IN VARCHAR2,
    p_puesto IN VARCHAR2,
    p_salario IN NUMBER,
    p_fecha_contratacion IN DATE
)
IS
BEGIN
    UPDATE Empleados
    SET
        nombre = p_nombre,
        puesto = p_puesto,
        salario = p_salario,
        fecha_contratacion = p_fecha_contratacion
    WHERE id_empleado = p_id_empleado;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_EMPLEADO (
    p_id_empleado IN NUMBER
)
IS
BEGIN
    DELETE FROM Empleados
    WHERE id_empleado = p_id_empleado;
    COMMIT;
END;

// Menu
CREATE OR REPLACE PROCEDURE PA_CREAR_MENU (
    p_nombre IN VARCHAR2,
    p_descripcion IN CLOB,
    p_precio_venta IN NUMBER
)
IS
BEGIN
    INSERT INTO Menu (nombre, descripcion, precio_venta)
    VALUES (p_nombre, p_descripcion, p_precio_venta);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_MENU_ID (
    p_id_plato IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_plato, nombre, descripcion, precio_venta
        FROM Menu
        WHERE id_plato = p_id_plato;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_MENU (
    p_id_plato IN NUMBER,
    p_nombre IN VARCHAR2,
    p_descripcion IN CLOB,
    p_precio_venta IN NUMBER
)
IS
BEGIN
    UPDATE Menu
    SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        precio_venta = p_precio_venta
    WHERE id_plato = p_id_plato;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_MENU (
    p_id_plato IN NUMBER
)
IS
BEGIN
    DELETE FROM Menu
    WHERE id_plato = p_id_plato;
    COMMIT;
END;

// Productos
CREATE OR REPLACE PROCEDURE PA_CREAR_PRODUCTO (
    p_nombre IN VARCHAR2,
    p_categoria IN VARCHAR2,
    p_precio_compra IN NUMBER,
    p_stock IN NUMBER,
    p_id_proveedor IN NUMBER
)
IS
BEGIN
    INSERT INTO Productos (nombre, categoria, precio_compra, stock, id_proveedor)
    VALUES (p_nombre, p_categoria, p_precio_compra, p_stock, p_id_proveedor);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_PRODUCTO_ID (
    p_id_producto IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_producto, nombre, categoria, precio_compra, stock, id_proveedor
        FROM Productos
        WHERE id_producto = p_id_producto;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_PRODUCTO (
    p_id_producto IN NUMBER,
    p_nombre IN VARCHAR2,
    p_categoria IN VARCHAR2,
    p_precio_compra IN NUMBER,
    p_stock IN NUMBER,
    p_id_proveedor IN NUMBER
)
IS
BEGIN
    UPDATE Productos
    SET
        nombre = p_nombre,
        categoria = p_categoria,
        precio_compra = p_precio_compra,
        stock = p_stock,
        id_proveedor = p_id_proveedor
    WHERE id_producto = p_id_producto;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_PRODUCTO (
    p_id_producto IN NUMBER
)
IS
BEGIN
    DELETE FROM Productos
    WHERE id_producto = p_id_producto;
    COMMIT;
END;

// Pedidos
CREATE OR REPLACE PROCEDURE PA_CREAR_PEDIDO (
    p_fecha IN DATE,
    p_id_cliente IN NUMBER
)
IS
BEGIN
    INSERT INTO Pedidos (fecha, total, estado, id_cliente)
    VALUES (p_fecha, 0, 'En Proceso', p_id_cliente); -- El total debe ser 0 inicialmente, se calcula al cerrar.
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_PEDIDO_ID (
    p_id_pedido IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_pedido, fecha, total, estado, id_cliente
        FROM Pedidos
        WHERE id_pedido = p_id_pedido;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_PEDIDO (
    p_id_pedido IN NUMBER,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN VARCHAR2,
    p_id_cliente IN NUMBER
)
IS
BEGIN
    UPDATE Pedidos
    SET
        fecha = p_fecha,
        total = p_total,
        estado = p_estado,
        id_cliente = p_id_cliente
    WHERE id_pedido = p_id_pedido;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_PEDIDO (
    p_id_pedido IN NUMBER
)
IS
BEGIN
    DELETE FROM Pedidos
    WHERE id_pedido = p_id_pedido;
    COMMIT;
END;

// Detalle pedido
CREATE OR REPLACE PROCEDURE PA_CREAR_DETALLE_PEDIDO (
    p_id_pedido IN NUMBER,
    p_id_plato IN NUMBER,
    p_cantidad IN NUMBER,
    p_subtotal IN NUMBER
)
IS
BEGIN
    INSERT INTO Detalle_Pedido (id_pedido, id_plato, cantidad, subtotal)
    VALUES (p_id_pedido, p_id_plato, p_cantidad, p_subtotal);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_DETALLE_ID (
    p_id_detalle IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_detalle, id_pedido, id_plato, cantidad, subtotal
        FROM Detalle_Pedido
        WHERE id_detalle = p_id_detalle;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_DETALLE_PEDIDO (
    p_id_detalle IN NUMBER,
    p_cantidad IN NUMBER,
    p_subtotal IN NUMBER
)
IS
BEGIN
    UPDATE Detalle_Pedido
    SET
        cantidad = p_cantidad,
        subtotal = p_subtotal
    WHERE id_detalle = p_id_detalle;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_DETALLE_PEDIDO (
    p_id_detalle IN NUMBER
)
IS
BEGIN
    DELETE FROM Detalle_Pedido
    WHERE id_detalle = p_id_detalle;
    COMMIT;
END;

// Facturas
CREATE OR REPLACE PROCEDURE PA_CREAR_FACTURA (
    p_id_pedido IN NUMBER,
    p_fecha_emision IN DATE,
    p_monto_total IN NUMBER,
    p_metodo_pago IN VARCHAR2
)
IS
BEGIN
    INSERT INTO Facturas (id_pedido, fecha_emision, monto_total, metodo_pago)
    VALUES (p_id_pedido, p_fecha_emision, p_monto_total, p_metodo_pago);
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_LEER_FACTURA_ID (
    p_id_factura IN NUMBER,
    p_cursor OUT Tipos_Comunes.t_cursor
)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT id_factura, id_pedido, fecha_emision, monto_total, metodo_pago
        FROM Facturas
        WHERE id_factura = p_id_factura;
END;


CREATE OR REPLACE PROCEDURE PA_ACTUALIZAR_FACTURA (
    p_id_factura IN NUMBER,
    p_fecha_emision IN DATE,
    p_monto_total IN NUMBER,
    p_metodo_pago IN VARCHAR2
)
IS
BEGIN
    UPDATE Facturas
    SET
        fecha_emision = p_fecha_emision,
        monto_total = p_monto_total,
        metodo_pago = p_metodo_pago
    WHERE id_factura = p_id_factura;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE PA_ELIMINAR_FACTURA (
    p_id_factura IN NUMBER
)
IS
BEGIN
    DELETE FROM Facturas
    WHERE id_factura = p_id_factura;
    COMMIT;
END;

//
