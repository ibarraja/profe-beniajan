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
  id_alumno INT NOT NULL,
  id_modulo INT NOT NULL,
  PRIMARY KEY (id_alumno, id_modulo),
  FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo)
);

SHOW TABLES;

DESCRIBE modulos;
DESCRIBE alumnos;
DESCRIBE matriculas;
