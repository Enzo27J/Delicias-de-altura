/* ===========================================================
   CURSORES EXPLÍCITOS - PROYECTO "DELICIAS DE ALTURA"
   Autores: Enzo Morales y Andrey Rodríguez
   Descripción: Consultas iterativas para informes y procesos
   =========================================================== */

/*============================================================
  CURSOR: Listar todos los clientes
============================================================*/
DELIMITER //
CREATE PROCEDURE PRC_LISTAR_CLIENTES()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_correo VARCHAR(100);
    DECLARE v_telefono VARCHAR(20);
    
    DECLARE cur_clientes CURSOR FOR 
        SELECT id_cliente, nombre, correo, telefono FROM Clientes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_clientes;
    read_loop: LOOP
        FETCH cur_clientes INTO v_id, v_nombre, v_correo, v_telefono;
        IF done THEN LEAVE read_loop; END IF;
        
        -- En MySQL se usa SELECT para mostrar el "output"
        SELECT CONCAT('Cliente: ', v_nombre, ' - ', v_correo) AS Informe;
    END LOOP;
    CLOSE cur_clientes;
END //

/*============================================================
  CURSOR: Listar empleados con su salario
============================================================*/
CREATE PROCEDURE PRC_LISTAR_EMPLEADOS_SALARIO()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_puesto VARCHAR(100);
    DECLARE v_salario DECIMAL(10,2);
    
    DECLARE cur_empleados CURSOR FOR 
        SELECT nombre, puesto, salario FROM Empleados;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_empleados;
    read_loop: LOOP
        FETCH cur_empleados INTO v_nombre, v_puesto, v_salario;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT(v_nombre, ' (', v_puesto, ') - $', v_salario) AS Detalle_Empleado;
    END LOOP;
    CLOSE cur_empleados;
END //

/*============================================================
  CURSOR: Productos con stock bajo
============================================================*/
CREATE PROCEDURE PRC_STOCK_BAJO()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_stock INT;
    
    DECLARE cur_stock_bajo CURSOR FOR 
        SELECT nombre, stock FROM Productos WHERE stock < 10;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_stock_bajo;
    read_loop: LOOP
        FETCH cur_stock_bajo INTO v_nombre, v_stock;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('ALERTA: ', v_nombre, ' tiene solo ', v_stock, ' unidades.') AS Alerta;
    END LOOP;
    CLOSE cur_stock_bajo;
END //

/*============================================================
  CURSOR: Platos del menú con su precio
============================================================*/
CREATE PROCEDURE PRC_LISTAR_MENU()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_precio DECIMAL(10,2);
    
    DECLARE cur_menu CURSOR FOR 
        SELECT nombre, precio_venta FROM Menu;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_menu;
    read_loop: LOOP
        FETCH cur_menu INTO v_nombre, v_precio;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Plato: ', v_nombre, ' - Precio: $', v_precio) AS Menu;
    END LOOP;
    CLOSE cur_menu;
END //

/*============================================================
  CURSOR: Pedidos pendientes de cierre
============================================================*/
CREATE PROCEDURE PRC_PEDIDOS_PENDIENTES()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_fecha DATETIME;
    DECLARE v_estado VARCHAR(50);
    
    DECLARE cur_pedidos CURSOR FOR 
        SELECT id_pedido, fecha, estado FROM Pedidos WHERE estado <> 'Cerrado';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_pedidos;
    read_loop: LOOP
        FETCH cur_pedidos INTO v_id, v_fecha, v_estado;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Pedido ', v_id, ' (', v_estado, ') - ', v_fecha) AS Pendiente;
    END LOOP;
    CLOSE cur_pedidos;
END //

/*============================================================
  CURSOR: Detalle de pedido por ID específico
============================================================*/
CREATE PROCEDURE PRC_DETALLE_PEDIDO_ESPECIFICO(IN p_id_pedido INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id_plato INT;
    DECLARE v_cantidad INT;
    DECLARE v_subtotal DECIMAL(10,2);
    
    DECLARE cur_detalle CURSOR FOR 
        SELECT id_plato, cantidad, subtotal FROM Detalle_Pedido WHERE id_pedido = p_id_pedido;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_detalle;
    read_loop: LOOP
        FETCH cur_detalle INTO v_id_plato, v_cantidad, v_subtotal;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Plato: ', v_id_plato, ' | Cantidad: ', v_cantidad, ' | Subtotal: $', v_subtotal) AS Detalle;
    END LOOP;
    CLOSE cur_detalle;
END //

/*============================================================
  CURSOR: Facturas emitidas hoy
============================================================*/
CREATE PROCEDURE PRC_FACTURAS_HOY()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_monto DECIMAL(10,2);
    DECLARE v_pago VARCHAR(50);
    
    DECLARE cur_facturas CURSOR FOR 
        SELECT id_factura, monto_total, metodo_pago 
        FROM Facturas 
        WHERE DATE(fecha_emision) = CURDATE();
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_facturas;
    read_loop: LOOP
        FETCH cur_facturas INTO v_id, v_monto, v_pago;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Factura ', v_id, ' - Total: $', v_monto, ' - Pago: ', v_pago) AS Reporte_Hoy;
    END LOOP;
    CLOSE cur_facturas;
END //

/*============================================================
  CURSOR: Total de ventas por cliente
============================================================*/
CREATE PROCEDURE PRC_VENTAS_POR_CLIENTE()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_total DECIMAL(10,2);
    
    DECLARE cur_ventas_cliente CURSOR FOR 
        SELECT C.nombre, SUM(F.monto_total) AS total_ventas
        FROM Facturas F
        JOIN Pedidos P ON F.id_pedido = P.id_pedido
        JOIN Clientes C ON P.id_cliente = C.id_cliente
        GROUP BY C.nombre;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_ventas_cliente;
    read_loop: LOOP
        FETCH cur_ventas_cliente INTO v_nombre, v_total;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Cliente: ', v_nombre, ' - Total Vendido: $', v_total) AS Ventas;
    END LOOP;
    CLOSE cur_ventas_cliente;
END //

/*============================================================
  CURSOR: Productos por proveedor
============================================================*/
CREATE PROCEDURE PRC_PRODUCTOS_PROVEEDOR()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_producto VARCHAR(100);
    DECLARE v_proveedor VARCHAR(100);
    
    DECLARE cur_productos_prov CURSOR FOR 
        SELECT P.nombre, R.nombre 
        FROM Productos P
        JOIN Proveedores R ON P.id_proveedor = R.id_proveedor;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_productos_prov;
    read_loop: LOOP
        FETCH cur_productos_prov INTO v_producto, v_proveedor;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT(v_producto, ' - Proveedor: ', v_proveedor) AS Suministro;
    END LOOP;
    CLOSE cur_productos_prov;
END //

/*============================================================
CURSOR: Empleados contratados este año
============================================================*/
CREATE PROCEDURE PRC_EMPLEADOS_NUEVOS()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_fecha DATE;
    
    DECLARE cur_empleados_nuevos CURSOR FOR 
        SELECT nombre, fecha_contratacion FROM Empleados
        WHERE YEAR(fecha_contratacion) = YEAR(CURDATE());
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_empleados_nuevos;
    read_loop: LOOP
        FETCH cur_empleados_nuevos INTO v_nombre, v_fecha;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Empleado: ', v_nombre, ' - Contratado: ', v_fecha) AS Ingresos;
    END LOOP;
    CLOSE cur_empleados_nuevos;
END //

/*============================================================
  CURSOR: Pedidos con total superior a $100
============================================================*/
CREATE PROCEDURE PRC_PEDIDOS_GRANDES()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_total DECIMAL(10,2);
    
    DECLARE cur_pedidos_grandes CURSOR FOR 
        SELECT id_pedido, total FROM Pedidos WHERE total > 100;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_pedidos_grandes;
    read_loop: LOOP
        FETCH cur_pedidos_grandes INTO v_id, v_total;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Pedido ', v_id, ' supera $100 con total: ', v_total) AS Grandes_Ventas;
    END LOOP;
    CLOSE cur_pedidos_grandes;
END //

/*============================================================
  CURSOR: Reporte de inventario completo
============================================================*/
CREATE PROCEDURE PRC_REPORTE_INVENTARIO()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_cat VARCHAR(100);
    DECLARE v_stock INT;
    DECLARE v_precio DECIMAL(10,2);
    
    DECLARE cur_inventario CURSOR FOR 
        SELECT nombre, categoria, stock, precio_compra FROM Productos;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_inventario;
    read_loop: LOOP
        FETCH cur_inventario INTO v_nombre, v_cat, v_stock, v_precio;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT(v_nombre, ' | ', v_cat, ' | Stock: ', v_stock, ' | Precio: $', v_precio) AS Inventario;
    END LOOP;
    CLOSE cur_inventario;
END //

/*============================================================
  CURSOR: Facturas y pedidos asociados
============================================================*/
CREATE PROCEDURE PRC_FACTURA_PEDIDO()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_fact INT;
    DECLARE v_ped INT;
    DECLARE v_total DECIMAL(10,2);
    
    DECLARE cur_factura_pedido CURSOR FOR 
        SELECT F.id_factura, P.id_pedido, F.monto_total
        FROM Facturas F JOIN Pedidos P ON F.id_pedido = P.id_pedido;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_factura_pedido;
    read_loop: LOOP
        FETCH cur_factura_pedido INTO v_fact, v_ped, v_total;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Factura ', v_fact, ' -> Pedido ', v_ped, ' | Total: ', v_total) AS Relacion;
    END LOOP;
    CLOSE cur_factura_pedido;
END //

/*============================================================
  CURSOR: Clientes sin pedidos registrados
============================================================*/
CREATE PROCEDURE PRC_CLIENTES_SIN_PEDIDOS()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_nombre VARCHAR(100);
    
    DECLARE cur_clientes_sin_pedidos CURSOR FOR 
        SELECT C.id_cliente, C.nombre FROM Clientes C
        WHERE NOT EXISTS (SELECT 1 FROM Pedidos P WHERE P.id_cliente = C.id_cliente);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_clientes_sin_pedidos;
    read_loop: LOOP
        FETCH cur_clientes_sin_pedidos INTO v_id, v_nombre;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Cliente sin pedidos: ', v_nombre) AS Inactivos;
    END LOOP;
    CLOSE cur_clientes_sin_pedidos;
END //

/*============================================================
  CURSOR: Log de movimientos de stock
============================================================*/
CREATE PROCEDURE PRC_LOG_STOCK()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_prod INT;
    DECLARE v_ant INT;
    DECLARE v_nue INT;
    DECLARE v_fecha DATETIME;
    DECLARE v_user VARCHAR(50);
    
    DECLARE cur_log_stock CURSOR FOR 
        SELECT id_producto, stock_anterior, stock_nuevo, fecha_cambio, usuario FROM LOG_STOCK;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_log_stock;
    read_loop: LOOP
        FETCH cur_log_stock INTO v_prod, v_ant, v_nue, v_fecha, v_user;
        IF done THEN LEAVE read_loop; END IF;
        SELECT CONCAT('Prod: ', v_prod, ' | Stock: ', v_ant, ' → ', v_nue, ' | Fecha: ', v_fecha) AS Auditoria;
    END LOOP;
    CLOSE cur_log_stock;
END //

DELIMITER ;
