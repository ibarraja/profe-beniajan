# 🏀 Ejercicios de Cursores en MySQL — Base de Datos NBA

A continuación tienes una colección completa de ejercicios organizados por niveles para aprender a trabajar con **cursores en MySQL**. Puedes copiar este contenido y subirlo directamente a tu GitHub.

---

## 🟦 NIVEL 1 — Primeros cursores

### Objetivo: aprender a declarar, abrir, recorrer y cerrar un cursor.

---

### **1. Recorrer jugadores y mostrar sus nombres**

**Objetivo:** aprender la estructura básica del cursor.

**Enunciado:**
Crea un procedimiento que use un cursor para recorrer la tabla `jugadores` y muestre el nombre de cada jugador con `SELECT` dentro del bucle.

---

### **2. Mostrar jugadores y su altura**

**Objetivo:** leer más de una columna.

**Enunciado:**
Haz un cursor que recorra la tabla `jugadores` y muestre cada jugador con este formato:

```
Jugador: <Nombre> — Altura: <Altura>
```

---

### **3. Listar equipos**

**Objetivo:** cursor sobre una tabla pequeña.

**Enunciado:**
Crea un cursor que muestre los nombres y ciudades de todos los equipos.

---

## 🟩 NIVEL 2 — Cursores con lógica

### Objetivo: hacer cálculos mientras recorres registros.

---

### **4. Contar cuántos jugadores pesan más de 100 kg**

**Objetivo:** uso de variables acumuladoras.

**Enunciado:**
Recorre la tabla `jugadores` con un cursor y cuenta cuántos tienen un peso mayor a 100.
Muestra el total al final.

---

### **5. Calcular la suma total de puntos registrados**

**Objetivo:** acumular valores de otra tabla.

**Enunciado:**
Crea un cursor que recorra la tabla `estadisticas` y vaya sumando el valor de `Puntos_por_partido`.
Al final, muestra la suma total.

---

### **6. Crear una tabla temporal con los jugadores que juegan de base (PG)**

**Objetivo:** insertar dentro de un cursor.

**Enunciado:**
Crea un cursor que recorra `jugadores`.
Si `Posicion = 'PG'`, inserta el jugador en una tabla temporal:

```
CREATE TEMPORARY TABLE bases (
  codigo INT,
  nombre VARCHAR(30)
);
```

---

## 🟧 NIVEL 3 — Cursores con actualizaciones

### Objetivo: modificar datos usando condiciones.

---

### **7. Aumentar 1 kg a todos los jugadores que midan más de 2 metros**

**Objetivo:** `UPDATE` dentro de cursor.

**Enunciado:**
Usa un cursor que recorra `jugadores`.
Cuando el jugador tenga una altura mayor o igual a `'2.00'`, incrementa su peso en **1 kg**.

---

### **8. Incrementar 0.5 rebotes a pívots**

**Objetivo:** combinar dos tablas.

**Enunciado:**
Haz un cursor que recorra `estadisticas`.
Para cada registro, consulta en `jugadores` si `Posicion = 'C'`.
Si es así, aumenta `Rebotes_por_partido` en **0.5**.

---

### **9. Detectar jugadores que nunca han jugado un partido**

**Objetivo:** LEFT JOIN + lógica en cursor.

**Enunciado:**
Recorre la tabla `jugadores` y por cada uno verifica (con un SELECT dentro del bucle) si existe al menos un registro en `estadisticas`.
Muestra los jugadores que no aparecen en la tabla de estadísticas.

