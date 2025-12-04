# 🏀 Ejercicios de Cursores en MySQL — Base de Datos NBA

Base de datos: `prueba_nba`

---

## 🟦 NIVEL 1 — Primeros cursores

### ✅ 1. Recorrer jugadores y mostrar sus nombres

```sql
DELIMITER //

CREATE PROCEDURE mostrar_nombres_jugadores()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE nombre_jugador VARCHAR(30);

    DECLARE cur_jugadores CURSOR FOR
        SELECT Nombre FROM jugadores;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur_jugadores;

    leer: LOOP
        FETCH cur_jugadores INTO nombre_jugador;

        IF fin = 1 THEN
            LEAVE leer;
        END IF;

        SELECT nombre_jugador AS Jugador;
    END LOOP;

    CLOSE cur_jugadores;
END//

DELIMITER ;
```


### 2. Mostrar jugadores y su altura

```sql
DELIMITER //

CREATE PROCEDURE mostrar_jugadores_altura()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE nombre_jugador VARCHAR(30);
    DECLARE altura_jugador DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT Nombre, Altura FROM jugadores;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO nombre_jugador, altura_jugador;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        SELECT CONCAT('Jugador: ', nombre_jugador, ' — Altura: ', altura_jugador) AS Resultado;
    END LOOP;

    CLOSE cur;
END//

DELIMITER ;
```

### 3. Listar equipos

```sql
DELIMITER //

CREATE PROCEDURE listar_equipos()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE nombre_equipo VARCHAR(20);
    DECLARE ciudad_equipo VARCHAR(20);

    DECLARE cur CURSOR FOR
        SELECT Nombre, Ciudad FROM equipos;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO nombre_equipo, ciudad_equipo;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        SELECT nombre_equipo AS Equipo, ciudad_equipo AS Ciudad;
    END LOOP;

    CLOSE cur;
END//

DELIMITER ;
```

---

## 🟩 NIVEL 2 — Cursores con lógica

### 4. Contar jugadores que pesan más de 100 kg

```sql
DELIMITER //

CREATE PROCEDURE contar_jugadores_pesan_100()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE peso_jugador INT;
    DECLARE total INT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT Peso FROM jugadores;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO peso_jugador;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        IF peso_jugador > 100 THEN
            SET total = total + 1;
        END IF;
    END LOOP;

    CLOSE cur;

    SELECT total AS Total_Jugadores_Mas_100kg;
END//

DELIMITER ;
```


### 5. Sumar todos los puntos por partido

```sql
DELIMITER //

CREATE PROCEDURE suma_total_puntos()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE puntos FLOAT;
    DECLARE total FLOAT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT Puntos_por_partido FROM estadisticas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO puntos;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        SET total = total + puntos;
    END LOOP;

    CLOSE cur;

    SELECT total AS Suma_Total_Puntos;
END//

DELIMITER ;
```


### 6. Crear tabla temporal con los bases (PG)

```sql
DELIMITER //

CREATE PROCEDURE crear_tabla_bases()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE cod INT;
    DECLARE nombre VARCHAR(30);
    DECLARE posicion VARCHAR(5);

    CREATE TEMPORARY TABLE bases (
        codigo INT,
        nombre VARCHAR(30)
    );

    DECLARE cur CURSOR FOR
        SELECT codigo, Nombre, Posicion FROM jugadores;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO cod, nombre, posicion;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        IF posicion = 'PG' THEN
            INSERT INTO bases VALUES (cod, nombre);
        END IF;
    END LOOP;

    CLOSE cur;

    SELECT * FROM bases;
END//

DELIMITER ;
```

---

## 🟧 NIVEL 3 — Cursores con actualizaciones

### 7. Aumentar 1 kg a jugadores que midan más de 2 metros

```sql
DELIMITER //

CREATE PROCEDURE subir_peso_altos()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE cod INT;
    DECLARE altura DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT codigo, Altura FROM jugadores;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO cod, altura;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        IF altura >= 2.00 THEN
            UPDATE jugadores
            SET Peso = Peso + 1
            WHERE codigo = cod;
        END IF;
    END LOOP;

    CLOSE cur;
END//

DELIMITER ;
```

---

### 8. Aumentar 0.5 rebotes a los pívots (C)

```sql
DELIMITER //

CREATE PROCEDURE subir_rebotes_pivots()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE cod_jugador INT;
    DECLARE posicion VARCHAR(5);

    DECLARE cur CURSOR FOR
        SELECT jugador FROM estadisticas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO cod_jugador;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        SELECT Posicion INTO posicion
        FROM jugadores
        WHERE codigo = cod_jugador;

        IF posicion = 'C' THEN
            UPDATE estadisticas
            SET Rebotes_por_partido = Rebotes_por_partido + 0.5
            WHERE jugador = cod_jugador;
        END IF;
    END LOOP;

    CLOSE cur;
END//

DELIMITER ;
```

---

### 9. Detectar jugadores que nunca han jugado un partido

```sql
DELIMITER //

CREATE PROCEDURE jugadores_sin_partidos()
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE cod INT;
    DECLARE nombre VARCHAR(30);
    DECLARE total INT;

    DECLARE cur CURSOR FOR
        SELECT codigo, Nombre FROM jugadores;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN cur;

    bucle: LOOP
        FETCH cur INTO cod, nombre;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        SELECT COUNT(*) INTO total
        FROM estadisticas
        WHERE jugador = cod;

        IF total = 0 THEN
            SELECT nombre AS Jugador_Sin_Partidos;
        END IF;
    END LOOP;

    CLOSE cur;
END//

DELIMITER ;
```


##  Ejecución de ejemplos

```sql
CALL mostrar_nombres_jugadores();
CALL listar_equipos();
CALL contar_jugadores_pesan_100();
CALL suma_total_puntos();
CALL crear_tabla_bases();
CALL subir_peso_altos();
CALL subir_rebotes_pivots();
CALL jugadores_sin_partidos();
```


