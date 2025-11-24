# Ejercicios básicos de triggers

## 1. Trigger de inserción simple (auditoría en `clientes`)

```sql
CREATE TABLE auditoria_clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER after_insert_cliente
AFTER INSERT ON clientes
FOR EACH ROW
INSERT INTO auditoria_clientes (cliente_id) VALUES (NEW.id);
```

---

## 2. Trigger de actualización (`fecha_modificacion` en `productos`)

```sql
CREATE TRIGGER before_update_producto
BEFORE UPDATE ON productos
FOR EACH ROW
SET NEW.fecha_modificacion = CURRENT_TIMESTAMP;
```

---

## 3. Trigger de borrado (respaldo en `empleados`)

```sql
CREATE TABLE empleados_respaldo AS SELECT * FROM empleados WHERE 1=0;

CREATE TRIGGER before_delete_empleado
BEFORE DELETE ON empleados
FOR EACH ROW
INSERT INTO empleados_respaldo SELECT * FROM empleados WHERE id = OLD.id;
```

---

## 4. Trigger para validar datos (no negativos en `inventario`)

```sql
CREATE TRIGGER before_insert_inventario
BEFORE INSERT ON inventario
FOR EACH ROW
IF NEW.cantidad < 0 THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se permiten valores negativos en cantidad';
END IF;
```

---

## 5. Trigger para sumar valores (`ventas` y `resumen_ventas`)

```sql
CREATE TRIGGER after_insert_venta
AFTER INSERT ON ventas
FOR EACH ROW
UPDATE resumen_ventas SET total = total + NEW.monto WHERE id = 1;
```

---

## 6. Trigger para enviar mensajes (`logs` en actualizaciones de `usuarios`)

```sql
CREATE TABLE logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  mensaje VARCHAR(255),
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER after_update_usuario
AFTER UPDATE ON usuarios
FOR EACH ROW
INSERT INTO logs (mensaje) VALUES ('Usuario actualizado: ' || NEW.id);
```
