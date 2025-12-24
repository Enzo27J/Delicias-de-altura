/* ===========================================================
    PAQUETES PL/SQL - PROYECTO: "DELICIAS DE ALTURA"
    Autores: Enzo Morales y Andrey Rodríguez
    Descripción: Encapsulación de procedimientos CRUD por entidad
=========================================================== */

/* ===========================================================
    PAQUETE: PROVEEDORES
=========================================================== */
DELIMITER //

CREATE PROCEDURE PA_PROVEEDORES_CREAR(p_nombre VARCHAR(100), p_telefono VARCHAR(20), p_direccion VARCHAR(255))
BEGIN
    INSERT INTO Proveedores(nombre, telefono, direccion)
    VALUES(p_nombre, p_telefono, p_direccion);
END //

CREATE PROCEDURE PA_PROVEEDORES_LEER_ID(p_id_proveedor INT)
BEGIN
    SELECT * FROM Proveedores WHERE id_proveedor = p_id_proveedor;
END //

CREATE PROCEDURE PA_PROVEEDORES_ACTUALIZAR(p_id_proveedor INT, p_nombre VARCHAR(100), p_telefono VARCHAR(20), p_direccion VARCHAR(255))
BEGIN
    UPDATE Proveedores
    SET nombre = p_nombre, telefono = p_telefono, direccion = p_direccion
    WHERE id_proveedor = p_id_proveedor;
END //

CREATE PROCEDURE PA_PROVEEDORES_ELIMINAR(p_id_proveedor INT)
BEGIN
    DELETE FROM Proveedores WHERE id_proveedor = p_id_proveedor;
END //

/* ===========================================================
    PAQUETE: CLIENTES
=========================================================== */
CREATE PROCEDURE PA_CLIENTES_CREAR(p_nombre VARCHAR(100), p_correo VARCHAR(100), p_telefono VARCHAR(20))
BEGIN
    INSERT INTO Clientes(nombre, correo, telefono)
    VALUES(p_nombre, p_correo, p_telefono);
END //

CREATE PROCEDURE PA_CLIENTES_LEER_ID(p_id_cliente INT)
BEGIN
    SELECT * FROM Clientes WHERE id_cliente = p_id_cliente;
END //

CREATE PROCEDURE PA_CLIENTES_ACTUALIZAR(p_id_cliente INT, p_nombre VARCHAR(100), p_correo VARCHAR(100), p_telefono VARCHAR(20))
BEGIN
    UPDATE Clientes
    SET nombre = p_nombre, correo = p_correo, telefono = p_telefono
    WHERE id_cliente = p_id_cliente;
END //

CREATE PROCEDURE PA_CLIENTES_ELIMINAR(p_id_cliente INT)
BEGIN
    DELETE FROM Clientes WHERE id_cliente = p_id_cliente;
END //

/* ===========================================================
    PAQUETE: EMPLEADOS
=========================================================== */
CREATE PROCEDURE PA_EMPLEADOS_CREAR(p_nombre VARCHAR(100), p_puesto VARCHAR(100), p_salario DECIMAL(10,2), p_fecha_contratacion DATE)
BEGIN
    INSERT INTO Empleados(nombre, puesto, salario, fecha_contratacion)
    VALUES(p_nombre, p_puesto, p_salario, p_fecha_contratacion);
END //

CREATE PROCEDURE PA_EMPLEADOS_LEER_ID(p_id_empleado INT)
BEGIN
    SELECT * FROM Empleados WHERE id_empleado = p_id_empleado;
END //

CREATE PROCEDURE PA_EMPLEADOS_ACTUALIZAR(p_id_empleado INT, p_nombre VARCHAR(100), p_puesto VARCHAR(100), p_salario DECIMAL(10,2), p_fecha_contratacion DATE)
BEGIN
    UPDATE Empleados
    SET nombre = p_nombre, puesto = p_puesto, salario = p_salario, fecha_contratacion = p_fecha_contratacion
    WHERE id_empleado = p_id_empleado;
END //

CREATE PROCEDURE PA_EMPLEADOS_ELIMINAR(p_id_empleado INT)
BEGIN
    DELETE FROM Empleados WHERE id_empleado = p_id_empleado;
END //

/* ===========================================================
    PAQUETE: MENU
=========================================================== */
CREATE PROCEDURE PA_MENU_CREAR(p_nombre VARCHAR(100), p_descripcion TEXT, p_precio_venta DECIMAL(10,2))
BEGIN
    INSERT INTO Menu(nombre, descripcion, precio_venta)
    VALUES(p_nombre, p_descripcion, p_precio_venta);
END //

CREATE PROCEDURE PA_MENU_LEER_ID(p_id_plato INT)
BEGIN
    SELECT * FROM Menu WHERE id_plato = p_id_plato;
END //

CREATE PROCEDURE PA_MENU_ACTUALIZAR(p_id_plato INT, p_nombre VARCHAR(100), p_descripcion TEXT, p_precio_venta DECIMAL(10,2))
BEGIN
    UPDATE Menu
    SET nombre = p_nombre, descripcion = p_descripcion, precio_venta = p_precio_venta
    WHERE id_plato = p_id_plato;
END //

CREATE PROCEDURE PA_MENU_ELIMINAR(p_id_plato INT)
BEGIN
    DELETE FROM Menu WHERE id_plato = p_id_plato;
END //

/* ===========================================================
    PAQUETE: PRODUCTOS
=========================================================== */
CREATE PROCEDURE PA_PRODUCTOS_CREAR(p_nombre VARCHAR(100), p_categoria VARCHAR(100), p_precio_compra DECIMAL(10,2), p_stock INT, p_id_proveedor INT)
BEGIN
    INSERT INTO Productos(nombre, categoria, precio_compra, stock, id_proveedor)
    VALUES(p_nombre, p_categoria, p_precio_compra, p_stock, p_id_proveedor);
END //

CREATE PROCEDURE PA_PRODUCTOS_LEER_ID(p_id_producto INT)
BEGIN
    SELECT * FROM Productos WHERE id_producto = p_id_producto;
END //

CREATE PROCEDURE PA_PRODUCTOS_ACTUALIZAR(p_id_producto INT, p_nombre VARCHAR(100), p_categoria VARCHAR(100), p_precio_compra DECIMAL(10,2), p_stock INT, p_id_proveedor INT)
BEGIN
    UPDATE Productos
    SET nombre = p_nombre, categoria = p_categoria, precio_compra = p_precio_compra, stock = p_stock, id_proveedor = p_id_proveedor
    WHERE id_producto = p_id_producto;
END //

CREATE PROCEDURE PA_PRODUCTOS_ELIMINAR(p_id_producto INT)
BEGIN
    DELETE FROM Productos WHERE id_producto = p_id_producto;
END //

/* ===========================================================
    PAQUETE: PEDIDOS
=========================================================== */
CREATE PROCEDURE PA_PEDIDOS_CREAR(p_fecha DATE, p_id_cliente INT)
BEGIN
    INSERT INTO Pedidos(fecha, total, estado, id_cliente)
    VALUES(p_fecha, 0, 'En Proceso', p_id_cliente);
END //

CREATE PROCEDURE PA_PEDIDOS_LEER_ID(p_id_pedido INT)
BEGIN
    SELECT * FROM Pedidos WHERE id_pedido = p_id_pedido;
END //

CREATE PROCEDURE PA_PEDIDOS_ACTUALIZAR(p_id_pedido INT, p_fecha DATE, p_total DECIMAL(10,2), p_estado VARCHAR(50), p_id_cliente INT)
BEGIN
    UPDATE Pedidos
    SET fecha = p_fecha, total = p_total, estado = p_estado, id_cliente = p_id_cliente
    WHERE id_pedido = p_id_pedido;
END //

CREATE PROCEDURE PA_PEDIDOS_ELIMINAR(p_id_pedido INT)
BEGIN
    DELETE FROM Pedidos WHERE id_pedido = p_id_pedido;
END //

/* ===========================================================
    PAQUETE: DETALLE_PEDIDO
=========================================================== */
CREATE PROCEDURE PA_DETALLE_PEDIDO_CREAR(p_id_pedido INT, p_id_plato INT, p_cantidad INT, p_subtotal DECIMAL(10,2))
BEGIN
    INSERT INTO Detalle_Pedido(id_pedido, id_plato, cantidad, subtotal)
    VALUES(p_id_pedido, p_id_plato, p_cantidad, p_subtotal);
END //

CREATE PROCEDURE PA_DETALLE_PEDIDO_LEER_ID(p_id_detalle INT)
BEGIN
    SELECT * FROM Detalle_Pedido WHERE id_detalle = p_id_detalle;
END //

CREATE PROCEDURE PA_DETALLE_PEDIDO_ACTUALIZAR(p_id_detalle INT, p_cantidad INT, p_subtotal DECIMAL(10,2))
BEGIN
    UPDATE Detalle_Pedido
    SET cantidad = p_cantidad, subtotal = p_subtotal
    WHERE id_detalle = p_id_detalle;
END //

CREATE PROCEDURE PA_DETALLE_PEDIDO_ELIMINAR(p_id_detalle INT)
BEGIN
    DELETE FROM Detalle_Pedido WHERE id_detalle = p_id_detalle;
END //

/* ===========================================================
    PAQUETE: FACTURAS
=========================================================== */
CREATE PROCEDURE PA_FACTURAS_CREAR(p_id_pedido INT, p_fecha_emision DATE, p_monto_total DECIMAL(10,2), p_metodo_pago VARCHAR(50))
BEGIN
    INSERT INTO Facturas(id_pedido, fecha_emision, monto_total, metodo_pago)
    VALUES(p_id_pedido, p_fecha_emision, p_monto_total, p_metodo_pago);
END //

CREATE PROCEDURE PA_FACTURAS_LEER_ID(p_id_factura INT)
BEGIN
    SELECT * FROM Facturas WHERE id_factura = p_id_factura;
END //

CREATE PROCEDURE PA_FACTURAS_ACTUALIZAR(p_id_factura INT, p_fecha_emision DATE, p_monto_total DECIMAL(10,2), p_metodo_pago VARCHAR(50))
BEGIN
    UPDATE Facturas
    SET fecha_emision = p_fecha_emision, monto_total = p_monto_total, metodo_pago = p_metodo_pago
    WHERE id_factura = p_id_factura;
END //

CREATE PROCEDURE PA_FACTURAS_ELIMINAR(p_id_factura INT)
BEGIN
    DELETE FROM Facturas WHERE id_factura = p_id_factura;
END //

/* ===========================================================
    PAQUETE: REPORTES
    Generación de informes de ventas, pedidos e inventario
=========================================================== */
CREATE PROCEDURE PA_REPORTES_VENTAS(p_fecha_inicio DATE, p_fecha_fin DATE)
BEGIN
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
END //

CREATE PROCEDURE PA_REPORTES_PEDIDOS(p_fecha_inicio DATE, p_fecha_fin DATE)
BEGIN
    SELECT P.id_pedido,
           C.nombre AS cliente,
           P.fecha,
           P.total,
           P.estado
      FROM Pedidos P
      JOIN Clientes C ON P.id_cliente = C.id_cliente
     WHERE P.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
     ORDER BY P.fecha;
END //

CREATE PROCEDURE PA_REPORTES_INVENTARIO()
BEGIN
    SELECT PR.id_producto,
           PR.nombre,
           PR.categoria,
           PR.stock,
           PR.precio_compra,
           PROV.nombre AS proveedor
      FROM Productos PR
      JOIN Proveedores PROV ON PR.id_proveedor = PROV.id_proveedor
     ORDER BY PR.nombre;
END //

/* ===========================================================
    PAQUETE: UTILIDADES
    Funciones y procedimientos auxiliares
=========================================================== */
CREATE FUNCTION FN_UTILIDADES_CALCULAR_TOTAL_PEDIDO(p_id_pedido INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0;
    SELECT IFNULL(SUM(subtotal), 0)
    INTO v_total
    FROM Detalle_Pedido
    WHERE id_pedido = p_id_pedido;
    RETURN v_total;
END //

CREATE PROCEDURE PA_UTILIDADES_ACTUALIZAR_TOTAL_PEDIDO(p_id_pedido INT)
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SET v_total = FN_UTILIDADES_CALCULAR_TOTAL_PEDIDO(p_id_pedido);
    UPDATE Pedidos
    SET total = v_total
    WHERE id_pedido = p_id_pedido;
END //

CREATE FUNCTION FN_UTILIDADES_OBTENER_STOCK_PRODUCTO(p_id_producto INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_stock INT DEFAULT 0;
    SELECT stock INTO v_stock
    FROM Productos
    WHERE id_producto = p_id_producto;
    RETURN v_stock;
END //

DELIMITER ;
