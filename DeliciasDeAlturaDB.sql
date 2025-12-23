-- Universidad Fidélitas
-- Lenguajes de bases de datos

-- Autores: Enzo Morales y Andrey Rodríguez

-- Creación de la base de datos de Delicias de altura
CREATE DATABASE delicias_altura;
USE delicias_altura;

-------------------------------------------------
-- Primero vamos a crear las tablas necesarias --
-------------------------------------------------

-- Tabla de empleados
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

-- Tabla de los clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

-- Tabla de los proveedores
CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(100)
);

-- Tabla de los productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    stock INT,
    precio_unitario DECIMAL(10,2),
    id_proveedor INT,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

-- Tabla de los platos
CREATE TABLE platos (
    id_plato INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);

-- Tabla de los productos por plato
CREATE TABLE plato_producto (
    id_plato INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_plato, id_producto),
    FOREIGN KEY (id_plato) REFERENCES platos(id_plato),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla para los pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabla para los detalles del pedido
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_plato INT,
    cantidad INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_plato) REFERENCES platos(id_plato)
);

-- Tabla para las facturas
CREATE TABLE facturas (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

---------------------------------------
-- Función para calcular el subtotal --
---------------------------------------
DELIMITER $$

CREATE FUNCTION calcular_subtotal(precio DECIMAL(10,2), cantidad INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN precio * cantidad;
END$$

DELIMITER ;

------------------------------------------
-- Triger para actualizar el inventario --
------------------------------------------
DELIMITER $$

CREATE TRIGGER descontar_stock
AFTER INSERT ON detalle_pedido -- Importante que sea despues de insertar el pedido para actualizar la base correctamente
FOR EACH ROW
BEGIN
    UPDATE productos p
    JOIN plato_producto pp ON p.id_producto = pp.id_producto
    SET p.stock = p.stock - (pp.cantidad * NEW.cantidad)
    WHERE pp.id_plato = NEW.id_plato;
END$$

DELIMITER ;
-------------------------------------------------------------------
-- Ahora vamos a crear el procedimeinto para almacenar el pedido --
-------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE registrar_pedido(
    IN p_id_cliente INT,
    IN p_id_plato INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    SELECT precio INTO v_precio FROM platos WHERE id_plato = p_id_plato;
    SET v_subtotal = calcular_subtotal(v_precio, p_cantidad); -- Llamamos a la función para calcular el subtotal

    INSERT INTO pedidos(id_cliente, total) -- Insertamos en pedidos
    VALUES (p_id_cliente, 0);

    SET v_id_pedido = LAST_INSERT_ID();

    INSERT INTO detalle_pedido(id_pedido, id_plato, cantidad, subtotal) -- Guardamos el detalle del pedido
    VALUES (v_id_pedido, p_id_plato, p_cantidad, v_subtotal);

    UPDATE pedidos SET total = v_subtotal WHERE id_pedido = v_id_pedido; -- Actualizamos

    INSERT INTO facturas(id_pedido, total)
    VALUES (v_id_pedido, v_subtotal);
END$$

DELIMITER ;

-- Ahora nos vamos a ayudar una vista para las ventas. Procedemos con la creación --

CREATE VIEW vista_ventas AS
SELECT f.id_factura, c.nombre AS cliente, f.total, f.fecha
FROM facturas f
JOIN pedidos p ON f.id_pedido = p.id_pedido
JOIN clientes c ON p.id_cliente = c.id_cliente;

-----------------------------------------------------------------------------------------------------
-- Finalmente vamos a insertar algunos datos de prueba iniciales para probarlos con la app de Java --
-----------------------------------------------------------------------------------------------------
INSERT INTO proveedores VALUES (NULL, 'Proveedor Carnes Castillo', '87654321');
INSERT INTO proveedores VALUES (NULL, 'Proveedor Verduras del pacifico', '83458624');
INSERT INTO proveedores VALUES (NULL, 'Proveedor Condimentos Sasón', '27425584');

INSERT INTO productos VALUES (NULL, 'Arroz', 100, 1.50, 1);
INSERT INTO productos VALUES (NULL, 'Tomates', 22, 2.50, 2);
INSERT INTO productos VALUES (NULL, 'Consomé', 250, 1.00, 3);


INSERT INTO platos VALUES (NULL, 'Arroz con Pollo', 8.00);
INSERT INTO plato_producto VALUES (1, 1, 2);

INSERT INTO clientes VALUES (NULL, 'Carlos Jiménez', '70231245');
INSERT INTO clientes VALUES (NULL, 'Jose Luna', '85231025');
INSERT INTO clientes VALUES (NULL, 'Ana Castillo', '60112364');