-- Script 01_creacion_bbdd.sql
-- Crea la base de datos y sus tablas principales

DROP DATABASE IF EXISTS clase_bbdd;
CREATE DATABASE clase_bbdd;
USE clase_bbdd;

CREATE TABLE modulos (
  id_modulo INT PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(255) NOT NULL,
  n_alu     INT NOT NULL DEFAULT 0
);

CREATE TABLE alumnos (
  id_alumno   INT PRIMARY KEY AUTO_INCREMENT,
  dni         VARCHAR(9)    NOT NULL UNIQUE,
  nombre_alu  VARCHAR(255)  NOT NULL
);

CREATE TABLE matriculas (
  id_alumno_matriculas INT NOT NULL,
  id_modulo_matriculas INT NOT NULL,
  PRIMARY KEY (id_alumno_matriculas, id_modulo_matriculas),
  FOREIGN KEY (id_alumno_matriculas) REFERENCES alumnos(id_alumno),
  FOREIGN KEY (id_modulo_matriculas) REFERENCES modulos(id_modulo)
);

SHOW TABLES;

DESCRIBE modulos;
DESCRIBE alumnos;
DESCRIBE matriculas;





-- Script 02_carga_datos_iniciales.sql
USE clase_bbdd;

-- Módulos
INSERT INTO modulos (nombre, n_alu) VALUES
('Administración de sistemas gestores de bases de datos', 7),
('Python', 4),
('IAW', 10),
('SRI', 4),
('IPE', 4),
('Sostenibilidad', 4),
('Seguridad y Alta Disponibilidad', 6),
('Administración de SO', 8);

-- Alumnos
INSERT INTO alumnos (dni, nombre_alu) VALUES
('43333355A', 'Adrián'),
('24445566B', 'Beatriz'),
('35556677C', 'Carlos'),
('46667788D', 'Diana'),
('57778899E', 'Elena'),
('68889900F', 'Fernando'),
('79990011G', 'Gloria'),
('80001122H', 'Hugo'),
('91112233J', 'Julia'),
('02223344K', 'Kevin');

-- Matrículas (igual que ya tenías)
INSERT INTO matriculas (id_alumno_matriculas, id_modulo_matriculas) VALUES
(1,1), (1,2), (1,3),
(2,2), (2,3),
(3,1), (3,4), (3,7),
(4,3), (4,4), (4,5),
(5,6), (5,8),
(6,1), (6,8),
(7,2),
(8,5), (8,6),
(9,1), (9,2), (9,3), (9,4),
(10,7);

-- Comprobaciones al final

SELECT * FROM modulos;
SELECT * FROM alumnos;
SELECT * FROM matriculas;

SELECT a.nombre_alu, m.nombre AS modulo
FROM alumnos a
JOIN matriculas mat ON a.id_alumno = mat.id_alumno_matriculas
JOIN modulos m ON mat.id_modulo_matriculas = m.id_modulo
ORDER BY a.nombre_alu, m.nombre;


-- 1. Trigger para actualizar el número de alumnos en un módulo
-- Crea un trigger que, al insertar una matrícula en la tabla matriculas, incremente el campo n_alu del módulo correspondiente en la tabla modulos.

DROP TRIGGER IF EXISTS tr_ejer1;

DELIMITER $$

CREATE TRIGGER tr_ejer1
AFTER INSERT ON matriculas
FOR EACH ROW
BEGIN

    update modulos 
    set n_alu = n_alu +1 
    where id_modulo = new.id_modulo_matriculas;

END $$

DELIMITER ;


-- 2. Trigger para evitar matrículas duplicadas
-- Crea un trigger que impida insertar una matrícula si el alumno ya está matriculado en ese módulo (además de la restricción de clave primaria).

DROP TRIGGER IF EXISTS tr_ejer2;

DELIMITER $$

CREATE TRIGGER tr_ejer2
BEFORE INSERT ON matriculas
FOR EACH ROW
BEGIN
  DECLARE alumnos_matriculados int;
  SELECT count(*) INTO alumnos_matriculados
  from matriculas 
  WHERE id_modulo_matriculas = NEW.id_modulo_matriculas 
  AND id_alumno_matriculas =  NEW.id_alumno_matriculas;

  if alumnos_matriculados > 0 THEN
    SIGNAL  SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El alumno ya está matriculado en este módulo';
  END IF;
END$$

DELIMITER ;

-- 3. Trigger para registrar bajas de alumnos
-- Crea una tabla bajas_alumnos y un trigger que, al eliminar un alumno de la tabla alumnos, registre su información en la tabla de bajas.

CREATE TABLE IF NOT EXISTS bajas_alumnos (
  id_alumno INT AUTO_INCREMENT,
  dni VARCHAR(9) NOT NULL,
  nombre_alu VARCHAR(255) NOT NULL,
  fecha_baja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS tr_ejer3;
DELIMITER $$

CREATE TRIGGER tr_ejer3
AFTER DELETE ON alumnos
FOR EACH ROW
BEGIN
    INSERT INTO bajas_alumnos (id_alumno, dni, nombre_alu)
    VALUES (OLD.id_alumno, OLD.dni, OLD.nombre_alu);
END$$

DELIMITER ;


-- 4. Trigger para controlar el máximo de alumnos por módulo
-- Supón que cada módulo puede tener como máximo 30 alumnos. Crea un trigger que impida nuevas matrículas si el módulo ya tiene 30 alumnos.

DROP TRIGGER IF EXISTS tr_ejer4;
DELIMITER $$
CREATE TRIGGER tr_ejer4
BEFORE INSERT ON matriculas
FOR EACH ROW
BEGIN
  
  DECLARE n_alu_matriculados INT;
    
  SELECT count(id_alumno_matriculas) INTO n_alu_matriculados
  FROM matriculas
  WHERE id_modulo_matriculas = NEW.id_modulo_matriculas;

  IF n_alu_matriculados >= 30 THEN 
    SIGNAL  SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Este módulo ya tiene matriculado a 30 alumnos!';
  END IF;


END$$
DELIMITER ;


-- 5. Trigger para registrar cambios de nombre de alumno:
-- Crea una tabla cambios_nombre y un trigger que, al actualizar el nombre de un alumno en la tabla alumnos, registre el cambio en la tabla de cambios.

CREATE TABLE IF NOT EXISTS cambios_nombre (
  id_cambios_nombres INT PRIMARY KEY AUTO_INCREMENT,
  id_alumno_cambios_nombre INT NOT NULL,
  nombre_antiguo VARCHAR(50),
  nombre_nuevo VARCHAR(50),
  fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
  FOREIGN KEY (id_alumno_cambios_nombre) REFERENCES alumnos(id_alumno)
);

DROP TRIGGER IF EXISTS tr_ejer5;

DELIMITER $$
CREATE TRIGGER tr_ejer5
BEFORE UPDATE ON alumnos
FOR EACH ROW
BEGIN
  
  IF OLD.nombre_alu != NEW.nombre_alu THEN
      INSERT INTO cambios_nombre (id_alumno_cambios_nombre, nombre_antiguo, nombre_nuevo)
      VALUES (OLD.id_alumno, OLD.nombre_alu, NEW.nombre_alu);
  END IF;

END$$
DELIMITER ;

-- 6. Trigger para eliminar matrículas asociadas al eliminar un alumno
-- Crea un trigger que, al eliminar un alumno, elimine automáticamente todas sus matrículas en la tabla matriculas.

DROP TRIGGER IF EXISTS tr_ejer6;

DELIMITER $$

CREATE TRIGGER tr_ejer6
AFTER DELETE ON alumnos
FOR EACH ROW
BEGIN
    DELETE FROM matriculas
    WHERE id_alumno_matriculas = OLD.id_alumno;
END$$

DELIMITER ;
