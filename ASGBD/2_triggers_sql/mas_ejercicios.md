# Ejercicios de triggers para la base de datos `clase_bbdd`
Para hacer estos ejercicios, tendremos que cargar el script de la carperta `/1_scripts_sql`

## 1. Trigger para actualizar el número de alumnos en un módulo
Crea un trigger que, al insertar una matrícula en la tabla `matriculas`, incremente el campo `n_alu` del módulo correspondiente en la tabla `modulos`.

---

## 2. Trigger para evitar matrículas duplicadas
Crea un trigger que impida insertar una matrícula si el alumno ya está matriculado en ese módulo (además de la restricción de clave primaria).

---

## 3. Trigger para registrar bajas de alumnos
Crea una tabla `bajas_alumnos` y un trigger que, al eliminar un alumno de la tabla `alumnos`, registre su información en la tabla de bajas.

---

## 4. Trigger para controlar el máximo de alumnos por módulo
Supón que cada módulo puede tener como máximo 30 alumnos. Crea un trigger que impida nuevas matrículas si el módulo ya tiene 30 alumnos.

---

## 5. Trigger para registrar cambios de nombre de alumno
Crea una tabla `cambios_nombre` y un trigger que, al actualizar el nombre de un alumno en la tabla `alumnos`, registre el cambio en la tabla de cambios.

---

## 6. Trigger para eliminar matrículas asociadas al eliminar un alumno
Crea un trigger que, al eliminar un alumno, elimine automáticamente todas sus matrículas en la tabla `matriculas`.

---
