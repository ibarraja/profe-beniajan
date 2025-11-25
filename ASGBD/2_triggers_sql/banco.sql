CREATE DATABASE IF NOT EXISTS banco; 
USE banco; 
CREATE TABLE IF NOT EXISTS movimiento ( 
    num_cuenta INT, cantidad DECIMAL(10, 2) 
);

DELIMITER $$

CREATE TRIGGER ajustar_cantidad
BEFORE INSERT ON movimiento
FOR EACH ROW
BEGIN
  IF NEW.num_cuenta BETWEEN 100 AND 150 THEN
    SET NEW.cantidad = NEW.cantidad * 1.50;
  ELSEIF NEW.num_cuenta BETWEEN 151 AND 200 THEN
    SET NEW.cantidad = NEW.cantidad * 0.50;
  END IF;
END $$

DELIMITER ;


INSERT INTO movimiento (num_cuenta, cantidad) VALUES (120, 200);
INSERT INTO movimiento (num_cuenta, cantidad) VALUES (170, 200);