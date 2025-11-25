# Ejemplos básicos de triggers en MySQL
A continuación se muestran los ejemplos de triggers adaptados a MySQL:

---

## 1. Trigger de inserción simple (auditoría en `clientes`)

```sql
CREATE TABLE IF NOT EXISTS auditoria_clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_insert_cliente
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
  INSERT INTO auditoria_clientes (cliente_id)
  VALUES (NEW.id);
END;
//

DELIMITER ;
```

---

## 2. Trigger de actualización (`fecha_modificacion` en `productos`)

```sql
ALTER TABLE productos
  ADD COLUMN IF NOT EXISTS fecha_modificacion TIMESTAMP NULL;

DELIMITER //

CREATE TRIGGER before_update_producto
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
  SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
END;
//

DELIMITER ;
```

---

## 3. Trigger de borrado (respaldo en `empleados`)

> Versión recomendada: usar `OLD` en lugar de leer otra vez de la tabla `empleados`.

Primero creamos la tabla de respaldo con la misma estructura básica (ajusta columnas según tu tabla real):

```sql
CREATE TABLE IF NOT EXISTS empleados_respaldo LIKE empleados;
```

Luego el trigger:

```sql
DELIMITER //

CREATE TRIGGER before_delete_empleado
BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
  INSERT INTO empleados_respaldo
  SELECT OLD.*;
END;
//

DELIMITER ;
```

Si prefieres ser explícito con columnas (recomendado en proyectos reales):

```sql
DELIMITER //

CREATE TRIGGER before_delete_empleado
BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
  INSERT INTO empleados_respaldo (id, nombre, puesto, salario /*, ... */)
  VALUES (OLD.id, OLD.nombre, OLD.puesto, OLD.salario /*, ... */);
END;
//

DELIMITER ;
```

---

## 4. Trigger para validar datos (no negativos en `inventario`)

```sql
DELIMITER //

CREATE TRIGGER before_insert_inventario
BEFORE INSERT ON inventario
FOR EACH ROW
BEGIN
  IF NEW.cantidad < 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se permiten valores negativos en cantidad';
  END IF;
END;
//

DELIMITER ;
```

(Análogo para `BEFORE UPDATE` si quieres validar también en actualizaciones.)

---

## 5. Trigger para sumar valores (`ventas` y `resumen_ventas`)

Suponiendo que `resumen_ventas` tiene al menos una fila con `id = 1` y un campo `total` numérico:

```sql
DELIMITER //

CREATE TRIGGER after_insert_venta
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
  UPDATE resumen_ventas
  SET total = total + NEW.monto
  WHERE id = 1;
END;
//

DELIMITER ;
```

---

## 6. Trigger para registrar cambios en `usuarios` (`logs`)

Primero la tabla de logs:

```sql
CREATE TABLE IF NOT EXISTS logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  mensaje VARCHAR(255),
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Luego el trigger con `CONCAT` (correcto en MySQL):

```sql
DELIMITER //

CREATE TRIGGER after_update_usuario
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
  INSERT INTO logs (mensaje)
  VALUES (CONCAT('Usuario actualizado: ', NEW.id));
END;
//

DELIMITER ;
```
