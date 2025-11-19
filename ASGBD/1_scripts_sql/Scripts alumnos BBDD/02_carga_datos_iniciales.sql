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
INSERT INTO matriculas (id_alumno, id_modulo) VALUES
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
JOIN matriculas mat ON a.id_alumno = mat.id_alumno
JOIN modulos m ON mat.id_modulo = m.id_modulo
ORDER BY a.nombre_alu, m.nombre;
