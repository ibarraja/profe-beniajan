# Scripts en MySQL
## 1. Repaso rápido de MySQL y trabajo con scripts
### 1.1. Entorno de trabajo (HeidiSQL / Workbench)

Cómo abrir, guardar y ejecutar scripts:
  - HeidiSQL: pestaña "Consulta" → guardar como .sql → botón de ejecutar.
  - Workbench: File → Open SQL Script y botón de ejecutar o Ctrl+Shift+Enter.

### 1.2. Repaso sintaxis básica (usando tu script inicial)
- `DROP DATABASE IF EXISTS`, `CREATE DATABASE`, `USE`.
- `CREATE TABLE` con `PRIMARY KEY`, `AUTO_INCREMENT`, `FOREIGN KEY`.
- `INSERT INTO` (una fila y varias filas).
- `SELECT` con `JOIN` y `ORDER BY`.

### 1.3 Actividad de aprendizaje
Crear un script `01_creacion_clase_bbdd.sql` que contenga solo:
- Borrado y creación de BBDD.
- Creación de tablas `modulos`, `alumnos` y `matriculas`.
- Inserción de datos (Podéis pedir a la IA que os genere datos para hacer inserciones pasando el nombre de las columnas de cada tabla)

Al final del script, añadir un `SELECT` que muestre el resultado de `modulos`, `alumnos` y `matriculas`.

## 2. Scripts de administración y carga de datos
### 2.1 ¿Qué es un script de administración?
Un **script de administración** es un archivo `.sql` que contiene un conjunto de órdenes pensadas para:
- Crear o recrear una base de datos desde cero.
- Crear tablas, índices, claves foránea...
- Cargar datos iniciales o masivos.
- Hacer tareas de mantenimiento (borrados, copias lógicas, ajustes de estructura, etc.).

### 2.2 Organización básica de los scripts
Proponemos una estructura muy simple de carpetas/archivos:
- `01_creacion_bbdd.sql` → SOLO creación de la base de datos y las tablas.
- `02_carga_datos_iniciales.sql` → SOLO `INSERT` con los datos de ejemplo.
- (Más adelante) `03_consultas_utiles.sql`, `04_rutinas_y_triggers.sql`, etc.

Las ventajas de separar es que es más fácil depurar errores y se pueden ejecutar solo la parte que te interesa (por ejemplo, recargar datos sin tocar la estructura).

### 2.3. Sintaxis básica para un buen script de admin
Puntos mínimos que deben aparecer siempre:
**1. Borrar y crear la BBDD**
```sql
DROP DATABASE IF EXISTS clase_bbdd;
CREATE DATABASE clase_bbdd;
USE clase_bbdd;
```

**2. Comentarios claros**
```sql
-- Script 01_creacion_bbdd.sql
-- Crea la base de datos y sus tablas principales
```

**3. Creación de tablas con claves bien definidas** (ejemplo con tu modelo):

```sql
CREATE TABLE modulos (
  id_modulo INT PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(255) NOT NULL,
  n_alu     INT NOT NULL DEFAULT 0
);

CREATE TABLE alumnos (
  id_alumno   INT PRIMARY KEY AUTO_INCREMENT,
  dni         VARCHAR(9)  NOT NULL UNIQUE,
  nombre_alu  VARCHAR(255) NOT NULL
);

CREATE TABLE matriculas (
  id_alumno INT NOT NULL,
  id_modulo INT NOT NULL,
  PRIMARY KEY (id_alumno, id_modulo),
  FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo)
);
```

**4. Comprobaciones al final del script** (para ver rápidamente si todo está bien):

```sql
SHOW TABLES;
DESCRIBE modulos;
DESCRIBE alumnos;
DESCRIBE matriculas;
```

### 2.4. Script de carga de datos iniciales

Separado en `02_carga_datos_iniciales.sql`:

**1.** Indicar la BBDD que se va a usar
```sql
USE clase_bbdd;
```
**2.** Insertar datos en orden lógico (primero tablas sin FKs, luego las que dependen):
   - Primero `modulos` y `alumnos`.
   - Después `matriculas`.

**3.** Ejemplo con tu BBDD (resumido):
```sql
-- Carga de módulos
INSERT INTO modulos (nombre, n_alu) VALUES
('Administración de sistemas gestores de bases de datos', 7),
('Python', 4),
('IAW', 10),
('SRI', 4),
('IPE', 4),
('Sostenibilidad', 4),
('Seguridad y Alta Disponibilidad', 6),
('Administración de SO', 8);

-- Carga de alumnos
INSERT INTO alumnos (dni, nombre_alu) VALUES
('43333355A', 'Adrián'),
('24445566B', 'Beatriz'),
...
;

-- Carga de matrículas
INSERT INTO matriculas (id_alumno, id_modulo) VALUES
(1,1), (1,2), (1,3),
...
;
```

**4.** Comprobaciones al final:
```sql
SELECT * FROM modulos;
SELECT * FROM alumnos;
SELECT * FROM matriculas;
```

### 2.5. Restricciones CHECK y acciones en cascada (ON DELETE / ON UPDATE)

Antes de hacer el **Ejercicio 1 — Script de deploy completo**, repasamos dos ideas importantes que vais a usar: `CHECK` y las acciones en cascada de las claves foráneas.

#### 2.5.1. ¿Qué es una restricción CHECK?
Una restricción `CHECK` sirve para obligar a que los valores de una columna cumplan una condición lógica. Se define al crear o modificar una tabla y si intentas insertar o actualizar un dato que no cumple la condición, MySQL devuelve un error.

Ejemplos típicos:

```sql
-- La duración de un módulo debe ser positiva
duracion_horas INT,
CHECK (duracion_horas > 0);

-- El número de alumnos no puede ser negativo
n_alu INT DEFAULT 0,
CHECK (n_alu >= 0);
```


La idea es usar `CHECK` para reforzar reglas de negocio directamente en la base de datos, no solo en el código de la aplicación.

#### 2.5.2. ¿Qué es `ON DELETE CASCADE` y `ON UPDATE CASCADE`?

Cuando creamos una clave foránea (*FOREIGN KEY*), podemos indicar qué debe pasar en la tabla hija cuando cambia o se borra un registro de la tabla padre. Las dos acciones más usadas son:
- `ON DELETE CASCADE` → si borro el registro padre, se borran automáticamente los hijos relacionados.
- `ON UPDATE CASCADE` → si cambio el valor de la clave primaria en el padre, se actualizan automáticamente los hijos.

Ejemplo aplicado a nuestra BBDD:

```sql
CREATE TABLE matriculas (
  id_alumno INT NOT NULL,
  id_modulo INT NOT NULL,
  PRIMARY KEY (id_alumno, id_modulo),
  FOREIGN KEY (id_alumno)
    REFERENCES alumnos(id_alumno)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (id_modulo)
    REFERENCES modulos(id_modulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
```

¿Qué significa esto en la práctica?
- Si borras un alumno de alumnos, se borran automáticamente todas sus matrículas en matriculas.
- Si por alguna razón cambias el id_alumno o id_modulo en las tablas padre, esos cambios se propagan a matriculas.

Ventaja: evitas que queden datos huérfanos en las tablas hijas (por ejemplo, matrículas de alumnos que ya no existen).

