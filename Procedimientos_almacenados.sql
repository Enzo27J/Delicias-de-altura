-- En MySQL no existe el objeto PACKAGE. Los procedimientos se crean de forma individual.

DELIMITER //

-- Proveedores
CREATE PROCEDURE PA_CREAR_PROVEEDOR (
    p_nombre VARCHAR(100),
    p_telefono VARCHAR(20),
    p_direccion VARCHAR(255)
)
BEGIN
    INSERT INTO Proveedores (nombre, telefono, direccion)
    VALUES (p_nombre, p_telefono, p_direccion);
END //

CREATE PROCEDURE PA_LEER_PROVEEDOR_ID (
    p_id_proveedor INT
)
BEGIN
    SELECT id_proveedor, nombre, telefono, direccion
    FROM Proveedores
    WHERE id_proveedor = p_id_proveedor;
END //

CREATE PROCEDURE PA_ACTUALIZAR_PROVEEDOR (
    p_id_proveedor INT,
    p_nombre VARCHAR(100),
    p_telefono VARCHAR(20),
    p_direccion VARCHAR(255)
)
BEGIN
    UPDATE Proveedores
    SET
        nombre = p_nombre,
        telefono = p_telefono,
        direccion = p_direccion
    WHERE id_proveedor = p_id_proveedor;
END //

CREATE PROCEDURE PA_ELIMINAR_PROVEEDOR (
    p_id_proveedor INT
)
BEGIN
    DELETE FROM Proveedores
    WHERE id_proveedor = p_id_proveedor;
END //

-- Clientes
CREATE PROCEDURE PA_CREAR_CLIENTE (
    p_nombre VARCHAR(100),
    p_correo VARCHAR(100),
    p_telefono VARCHAR(20)
)
BEGIN
    INSERT INTO Clientes (nombre, correo, telefono)
    VALUES (p_nombre, p_correo, p_telefono);
END //

CREATE PROCEDURE PA_LEER_CLIENTE_ID (
    p_id_cliente INT
)
BEGIN
    SELECT id_cliente, nombre, correo, telefono
    FROM Clientes
    WHERE id_cliente = p_id_cliente;
END //

CREATE PROCEDURE PA_ACTUALIZAR_CLIENTE (
    p_id_cliente INT,
    p_nombre VARCHAR(100),
    p_correo VARCHAR(100),
    p_telefono VARCHAR(20)
)
BEGIN
    UPDATE Clientes
    SET
        nombre = p_nombre,
        correo = p_correo,
        telefono = p_telefono
    WHERE id_cliente = p_id_cliente;
END //

CREATE PROCEDURE PA_ELIMINAR_CLIENTE (
    p_id_cliente INT
)
BEGIN
    DELETE FROM Clientes
    WHERE id_cliente = p_id_cliente;
END //

-- Empleados
CREATE PROCEDURE PA_CREAR_EMPLEADO (
    p_nombre VARCHAR(100),
    p_puesto VARCHAR(100),
    p_salario DECIMAL(10,2),
    p_fecha_contratacion DATE
)
BEGIN
    INSERT INTO Empleados (nombre, puesto, salario, fecha_contratacion)
    VALUES (p_nombre, p_puesto, p_salario, p_fecha_contratacion);
END //

CREATE PROCEDURE PA_LEER_EMPLEADO_ID (
    p_id_empleado INT
)
BEGIN
    SELECT id_empleado, nombre, puesto, salario, fecha_contratacion
    FROM Empleados
    WHERE id_empleado = p_id_empleado;
END //

CREATE PROCEDURE PA_ACTUALIZAR_EMPLEADO (
    p_id_empleado INT,
    p_nombre VARCHAR(100),
    p_puesto VARCHAR(100),
    p_salario DECIMAL(10,2),
    p_fecha_contratacion DATE
)
BEGIN
    UPDATE Empleados
    SET
        nombre = p_nombre,
        puesto = p_puesto,
        salario = p_salario,
        fecha_contratacion = p_fecha_contratacion
    WHERE id_empleado = p_id_empleado;
END //

CREATE PROCEDURE PA_ELIMINAR_EMPLEADO (
    p_id_empleado INT
)
BEGIN
    DELETE FROM Empleados
    WHERE id_empleado = p_id_empleado;
END //

-- Menu
CREATE PROCEDURE PA_CREAR_MENU (
    p_nombre VARCHAR(100),
    p_descripcion TEXT,
    p_precio_venta DECIMAL(10,2)
)
BEGIN
    INSERT INTO Menu (nombre, descripcion, precio_venta)
    VALUES (p_nombre, p_descripcion, p_precio_venta);
END //

CREATE PROCEDURE PA_LEER_MENU_ID (
    p_id_plato INT
)
BEGIN
    SELECT id_plato, nombre, descripcion, precio_venta
    FROM Menu
    WHERE id_plato = p_id_plato;
END //

CREATE PROCEDURE PA_ACTUALIZAR_MENU (
    p_id_plato INT,
    p_nombre VARCHAR(100),
    p_descripcion TEXT,
    p_precio_venta DECIMAL(10,2)
)
BEGIN
    UPDATE Menu
    SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        precio_venta = p_precio_venta
    WHERE id_plato = p_id_plato;
END //

CREATE PROCEDURE PA_ELIMINAR_MENU (
    p_id_plato INT
)
BEGIN
    DELETE FROM Menu
    WHERE id_plato = p_id_plato;
END //

-- Productos
CREATE PROCEDURE PA_CREAR_PRODUCTO (
    p_nombre VARCHAR(100),
    p_categoria VARCHAR(100),
    p_precio_compra DECIMAL(10,2),
    p_stock INT,
    p_id_proveedor INT
)
BEGIN
    INSERT INTO Productos (nombre, categoria, precio_compra, stock, id_proveedor)
    VALUES (p_nombre, p_categoria, p_precio_compra, p_stock, p_id_proveedor);
END //

CREATE PROCEDURE PA_LEER_PRODUCTO_ID (
    p_id_producto INT
)
BEGIN
    SELECT id_producto, nombre, categoria, precio_compra, stock, id_proveedor
    FROM Productos
    WHERE id_producto = p_id_producto;
END //

CREATE PROCEDURE PA_ACTUALIZAR_PRODUCTO (
    p_id_producto INT,
    p_nombre VARCHAR(100),
    p_categoria VARCHAR(100),
    p_precio_compra DECIMAL(10,2),
    p_stock INT,
    p_id_proveedor INT
)
BEGIN
    UPDATE Productos
    SET
        nombre = p_nombre,
        categoria = p_categoria,
        precio_compra = p_precio_compra,
        stock = p_stock,
        id_proveedor = p_id_proveedor
    WHERE id_producto = p_id_producto;
END //

CREATE PROCEDURE PA_ELIMINAR_PRODUCTO (
    p_id_producto INT
)
BEGIN
    DELETE FROM Productos
    WHERE id_producto = p_id_producto;
END //

-- Pedidos
CREATE PROCEDURE PA_CREAR_PEDIDO (
    p_fecha DATE,
    p_id_cliente INT
)
BEGIN
    INSERT INTO Pedidos (fecha, total, estado, id_cliente)
    VALUES (p_fecha, 0, 'En Proceso', p_id_cliente);
END //

CREATE PROCEDURE PA_LEER_PEDIDO_ID (
    p_id_pedido INT
)
BEGIN
    SELECT id_pedido, fecha, total, estado, id_cliente
    FROM Pedidos
    WHERE id_pedido = p_id_pedido;
END //

CREATE PROCEDURE PA_ACTUALIZAR_PEDIDO (
    p_id_pedido INT,
    p_fecha DATE,
    p_total DECIMAL(10,2),
    p_estado VARCHAR(50),
    p_id_cliente INT
)
BEGIN
    UPDATE Pedidos
    SET
        fecha = p_fecha,
        total = p_total,
        estado = p_estado,
        id_cliente = p_id_cliente
    WHERE id_pedido = p_id_pedido;
END //

CREATE PROCEDURE PA_ELIMINAR_PEDIDO (
    p_id_pedido INT
)
BEGIN
    DELETE FROM Pedidos
    WHERE id_pedido = p_id_pedido;
END //

-- Detalle pedido
CREATE PROCEDURE PA_CREAR_DETALLE_PEDIDO (
    p_id_pedido INT,
    p_id_plato INT,
    p_cantidad INT,
    p_subtotal DECIMAL(10,2)
)
BEGIN
    INSERT INTO Detalle_Pedido (id_pedido, id_plato, cantidad, subtotal)
    VALUES (p_id_pedido, p_id_plato, p_cantidad, p_subtotal);
END //

CREATE PROCEDURE PA_LEER_DETALLE_ID (
    p_id_detalle INT
)
BEGIN
    SELECT id_detalle, id_pedido, id_plato, cantidad, subtotal
    FROM Detalle_Pedido
    WHERE id_detalle = p_id_detalle;
END //

CREATE PROCEDURE PA_ACTUALIZAR_DETALLE_PEDIDO (
    p_id_detalle INT,
    p_cantidad INT,
    p_subtotal DECIMAL(10,2)
)
BEGIN
    UPDATE Detalle_Pedido
    SET
        cantidad = p_cantidad,
        subtotal = p_subtotal
    WHERE id_detalle = p_id_detalle;
END //

CREATE PROCEDURE PA_ELIMINAR_DETALLE_PEDIDO (
    p_id_detalle INT
)
BEGIN
    DELETE FROM Detalle_Pedido
    WHERE id_detalle = p_id_detalle;
END //

-- Facturas
CREATE PROCEDURE PA_CREAR_FACTURA (
    p_id_pedido INT,
    p_fecha_emision DATE,
    p_monto_total DECIMAL(10,2),
    p_metodo_pago VARCHAR(50)
)
BEGIN
    INSERT INTO Facturas (id_pedido, fecha_emision, monto_total, metodo_pago)
    VALUES (p_id_pedido, p_fecha_emision, p_monto_total, p_metodo_pago);
END //

CREATE PROCEDURE PA_LEER_FACTURA_ID (
    p_id_factura INT
)
BEGIN
    SELECT id_factura, id_pedido, fecha_emision, monto_total, metodo_pago
    FROM Facturas
    WHERE id_factura = p_id_factura;
END //

CREATE PROCEDURE PA_ACTUALIZAR_FACTURA (
    p_id_factura INT,
    p_fecha_emision DATE,
    p_monto_total DECIMAL(10,2),
    p_metodo_pago VARCHAR(50)
)
BEGIN
    UPDATE Facturas
    SET
        fecha_emision = p_fecha_emision,
        monto_total = p_monto_total,
        metodo_pago = p_metodo_pago
    WHERE id_factura = p_id_factura;
END //

CREATE PROCEDURE PA_ELIMINAR_FACTURA (
    p_id_factura INT
)
BEGIN
    DELETE FROM Facturas
    WHERE id_factura = p_id_factura;
END //

DELIMITER ;
