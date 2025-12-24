/* ===========================================================
   TRIGGERS - PROYECTO "DELICIAS DE ALTURA"
   Autores: Enzo Morales y Andrey Rodríguez
   Descripción: Automatización de procesos y control de integridad
   =========================================================== */

/*============================================================
  TRIGGER: ACTUALIZAR INVENTARIO AL INSERTAR DETALLE DE PEDIDO
  Reduce el stock del producto correspondiente al plato vendido
============================================================*/
DELIMITER //
CREATE TRIGGER TRG_ACTUALIZAR_STOCK
AFTER INSERT ON Detalle_Pedido
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_plato;
END //
DELIMITER ;

/*============================================================
  TRIGGER: RECALCULAR TOTAL DE PEDIDO
  Cada vez que se inserta, actualiza o elimina un detalle,
  se recalcula el total del pedido
============================================================*/
DELIMITER //
CREATE TRIGGER TRG_RECALCULAR_TOTAL_PEDIDO_INSERT
AFTER INSERT ON Detalle_Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET total = (SELECT IFNULL(SUM(subtotal), 0) FROM Detalle_Pedido WHERE id_pedido = NEW.id_pedido)
    WHERE id_pedido = NEW.id_pedido;
END //

CREATE TRIGGER TRG_RECALCULAR_TOTAL_PEDIDO_UPDATE
AFTER UPDATE ON Detalle_Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET total = (SELECT IFNULL(SUM(subtotal), 0) FROM Detalle_Pedido WHERE id_pedido = NEW.id_pedido)
    WHERE id_pedido = NEW.id_pedido;
END //

CREATE TRIGGER TRG_RECALCULAR_TOTAL_PEDIDO_DELETE
AFTER DELETE ON Detalle_Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET total = (SELECT IFNULL(SUM(subtotal), 0) FROM Detalle_Pedido WHERE id_pedido = OLD.id_pedido)
    WHERE id_pedido = OLD.id_pedido;
END //
DELIMITER ;

/*============================================================
  TRIGGER: GENERAR FACTURA AUTOMÁTICA
  Al cambiar el estado del pedido a “Cerrado”,
  se genera la factura correspondiente.
============================================================*/
DELIMITER //
CREATE TRIGGER TRG_GENERAR_FACTURA
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    IF NEW.estado = 'Cerrado' AND OLD.estado <> 'Cerrado' THEN
        INSERT INTO Facturas (id_pedido, fecha_emision, monto_total, metodo_pago)
        VALUES (NEW.id_pedido, NOW(), NEW.total, 'Efectivo');
    END IF;
END //
DELIMITER ;

/*============================================================
  TRIGGER: PREVENIR ELIMINACIÓN DE CLIENTES CON PEDIDOS
  Evita eliminar clientes que tengan pedidos registrados.
============================================================*/
DELIMITER //
CREATE TRIGGER TRG_PREVENIR_BORRADO_CLIENTE
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count 
    FROM Pedidos 
    WHERE id_cliente = OLD.id_cliente;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar cliente con pedidos existentes.';
    END IF;
END //
DELIMITER ;

/*============================================================
  TRIGGER: AUDITORÍA DE CAMBIOS DE STOCK
  Registra en una tabla LOG_STOCK cada vez que cambia el stock.
============================================================*/

-- Crear tabla de auditoría si no existe
CREATE TABLE IF NOT EXISTS LOG_STOCK (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    stock_anterior INT,
    stock_nuevo INT,
    fecha_cambio DATETIME,
    usuario VARCHAR(50)
);

-- Trigger de auditoría
DELIMITER //
CREATE TRIGGER TRG_LOG_CAMBIO_STOCK
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF OLD.stock <> NEW.stock THEN
        INSERT INTO LOG_STOCK (id_producto, stock_anterior, stock_nuevo, fecha_cambio, usuario)
        VALUES (OLD.id_producto, OLD.stock, NEW.stock, NOW(), CURRENT_USER());
    END IF;
END //
DELIMITER ;
