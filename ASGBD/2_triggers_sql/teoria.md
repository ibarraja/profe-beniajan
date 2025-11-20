## Triggers en BBDD
Un **trigger** (o desencadenador) es un conjunto de instruccioines definidas en una base de datos que se ejecutan automáticamente en respuesta a ciertos eventos en una tabla o vista. Los triggers son funtamentales para mantener la integridad de los datos, realizar la auditoría y automatizar procesos dentro de una base de datos.

## Tipos de datos
Exisen varios tipos de triggers según el tipo de evento que los dispara:
    
1. **Triggers** `BEFORE`: Se ejecutan antes de que se realice la operación en la base de datos (como `INSERT`, `UPDATE`, `DELETE`). Son útiles para realizar validaciones o modificaciones en los datos antes de que sean efectivamente comprometidos.
2. **Triggers** `AFTER`: Se ejecutan después de que se realice la operación en la base de datos. Se utilizan para realizar tareas como auditoría, actualización de otras tablas o notificaciones posteriores a una operación.
3. **Triggers** `INSTEAD OF`: Son ejecutados en lugar de la operación original. En lugar de realizar la operación habitual de `INSERT`, `UPDATE` o `DELETE`, el trigger ejecuta su lógica definida. Se utilizan comúnmente en vistas.

### Eventos que activan un Trigger
Los triggers pueden ser configurados para activarse con varios tipos de operaciones:
- `INSERT`: Se activa cuando se inserta una nueva fila en una tabla.
- `UPDATE`: Se activa cuando se actualiza una fila existente.
- `DELETE`: Se activa cuando se elimina una fila.

### Sintaxis de los Triggers
La sintaxis básica para crear un trigger es la siguiente:
```sql
{CREATE | REPLACE} TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
   -- Instrucciones a ejecutar
END;
```
- `{CREATE | REPLACE} TRIGGER`. Crea o reemplaza (si existe) un trigger.   
- `trigger_name`: El nombre del trigger.
- `BEFORE | AFTER`: Define si el trigger se ejecuta antes o después de la operación.
- `INSERT | UPDATE | DELETE`: El evento que activará el trigger.
- `FOR EACH ROW`: Indica que el trigger se ejecutará para cada fila afectada por la operación.
- `BEGIN ... END`: Bloque de código que se ejecuta cuando se activa el trigger. **Ojo**: `BEGIN` y `END` son necesarios siempre que el trigger contiene varias instrucciones. Si el trigger contiene solo una instrucción no es necesario usarlos.

Si el trigger contiene solo una instrucción, como un SET, no es necesario usarlos.

#### Ejemplo de Trigger
Supongamos que tenemos una tabla matriculas y otra tabla modulos. Queremos actualizar el número de alumnos inscritos en cada módulo automáticamente después de cada inscripción. Para ello, se podría crear el siguiente trigger:

```sql
DELIMITER $$

CREATE TRIGGER actualizar_numero_alumnos
AFTER INSERT ON matriculas
FOR EACH ROW
BEGIN
  UPDATE modulos
  SET n_alu = n_alu + 1
  WHERE id_modulo = NEW.id_modulo;
END $$

DELIMITER ;
```

**En este ejemplo:**
```sql
DELIMITER $$
```
Cambia el delimitador a `$$` antes de crear el trigger. Esto le dice a MySQL que todo lo que se encuentre hasta `$$` debe ser tratado como un solo bloque de código, incluso si contiene múltiples `;`.

```sql
AFTER INSERT ON matriculas
```
El trigger se ejecutará después de que se inserte una nueva fila en la tabla `matriculas`.

```sql
BEGIN
    UPDATE modulos
    SET n_alu = n_alu + 1
    WHERE id_modulo = NEW.id_modulo;
```
Hace referencia al valor `id_modulo` de la fila recién insertada en `matriculas`, para saber qué módulo ha recibido una nueva inscripción.`n_alu = n_alu + 1`: Actualiza el contador de alumnos (`n_alu`) en la tabla modulos.

```sql
END $$
```
Aquí, el bloque del trigger termina, y `$$` marca el fin del trigger como una unidad completa.

```sql
DELIMITER ;
```
Después de la creación del trigger, el delimitador vuelve a ser `;` para que las instrucciones SQL estándar puedan ejecutarse nuevamente.

### Variables Especiales en Triggers:

En MySQL, cuando creas un trigger, puedes hacer uso de dos variables especiales para referenciar los valores de las filas antes y después de que se realice una operación de modificación de datos (como `INSERT`, `UPDATE`, o `DELETE`).

- **`OLD`**: Esta variable se refiere a los valores antiguos de las filas, es decir, antes de que se haya realizado la operación.
  - `OLD.column_name`: Hace referencia al valor de una columna de la fila antes de una actualización o eliminación. No puedes usar OLD en un INSERT porque no hay valores anteriores en ese caso.

- **`NEW`**: Esta variable se refiere a los valores nuevos de las filas, es decir, después de que se haya realizado la operación.
  - `NEW.column_name`: Hace referencia al valor de una columna después de que se haya insertado o actualizado una fila. Es especialmente útil en un UPDATE o INSERT, pero no se puede usar en un DELETE porque no hay nuevos valores en ese caso.

#### ¿Cómo se usan `NEW` y `OLD`?

**En un `INSERT`**:
Solo puedes usar `NEW` porque estás insertando nuevos datos en la base de datos. Ejemplo: En un trigger de tipo `AFTER INSERT`, puedes acceder a los valores de las columnas recién insertadas con `NEW.column_name`.

**En un `UPDATE`**:

Puedes usar tanto `NEW` como `OLD` porque estás modificando datos existentes. `OLD`: Accedes a los valores antes de la actualización. `NEW`: Accedes a los valores después de la actualización.

**En un `DELETE`**:

Solo puedes usar `OLD` porque estás eliminando una fila y no hay nuevos valores después de la operación. Ejemplo: En un trigger de tipo `AFTER DELETE`, puedes acceder a los valores de las columnas antes de que se eliminara la fila.


### Ejemplo de uso de `NEW` y `OLD` en un Trigger

Supongamos que tenemos una tabla de empleados con los siguientes campos:
```sql
id_empleado (INT)

nombre (VARCHAR)

salario (DECIMAL)
```

Queremos realizar un seguimiento de las actualizaciones del salario de los empleados y registrar en una tabla de auditoría los valores antiguos y nuevos del salario.

#### Estructura de las tablas
```sql
CREATE TABLE empleados (
  id_empleado INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  salario DECIMAL(10, 2)
);

CREATE TABLE auditoria_salarios (
  id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
  id_empleado INT,
  salario_anterior DECIMAL(10, 2),
  salario_nuevo DECIMAL(10, 2),
  fecha DATETIME
);
```

#### Creación del Trigger

El trigger auditar_salario se ejecutará después de que se actualice un salario en la tabla empleados. Utilizaremos OLD para acceder al salario antiguo y NEW para acceder al salario nuevo.

```sql
DELIMITER $$

CREATE TRIGGER auditar_salario
AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
  -- Comprobamos si el salario ha cambiado
  IF OLD.salario != NEW.salario THEN
    -- Insertamos un registro en la tabla de auditoría con los valores antiguos y nuevos
    INSERT INTO auditoria_salarios (id_empleado, salario_anterior, salario_nuevo, fecha)
    VALUES (NEW.id_empleado, OLD.salario, NEW.salario, NOW());
  END IF;
END $$

DELIMITER ;
```

#### Explicación del Trigger

`AFTER UPDATE`: El trigger se ejecuta después de que se actualice una fila en la tabla empleados.

`OLD.salario`: Se refiere al valor del salario anterior de la fila antes de la actualización. Si el salario de un empleado era 2000 y luego se actualiza a `2500`, `OLD.salario` será `2000`.

`NEW.salario`: Se refiere al valor del salario nuevo de la fila después de la actualización. Siguiendo el mismo ejemplo, `NEW.salario` será `2500`.

`IF OLD.salario != NEW.salario`: Esta condición se asegura de que el trigger solo se ejecute si realmente ha habido un cambio en el salario (es decir, solo si el salario antiguo y el nuevo son diferentes).

`INSERT INTO auditoria_salarios`: Si el salario ha cambiado, el trigger inserta un registro en la tabla de auditoría auditoria_salarios, registrando el salario anterior (`OLD.salario`), el salario nuevo (`NEW.salario`), y la fecha y hora de la actualización (`NOW()`).

#### Flujo del Trigger
1. Antes de la actualización:
    El salario de un empleado es `2000` (valor almacenado en `OLD.salario`).

2. Después de la actualización:
    El salario de ese mismo empleado cambia a `2500` (valor almacenado en `NEW.salario`).

3. Inserción en la auditoría:
   Si el salario cambia, se inserta un registro en auditoria_salarios con:
   - `salario_anterior`: `2000` (valor de `OLD.salario`).
   - `salario_nuevo`: `2500` (valor de `NEW.salario`).
   - `fecha`: La fecha y hora actuales (`NOW()`).

#### Ejemplo de ejecución
1. **Datos iniciales**
   ```sql
   INSERT INTO empleados (nombre, salario) VALUES ('Carlos', 2000);
    ```
2. **Actualizar el salario**
    ```sql
    UPDATE empleados
    SET salario = 2500
    WHERE nombre = 'Carlos';
    ```
3. **Resultado en la tabla `auditoria_salarios`**
   ```sql
   SELECT * FROM auditoria_salarios;
   ```
| id_auditoria | id_empleado | salario_anterior | salario_nuevo | fecha               |
| ------------ | ----------- | ---------------- | ------------- | ------------------- |
| 1            | 1           | 2000             | 2500          | 2025-05-07 14:35:00 |


#### Conclusión
`OLD` se usa para obtener los valores antes de que se realice una actualización o eliminación. En este caso, accedemos al salario antiguo.

`NEW` se usa para obtener los valores después de la operación, como el salario nuevo después de la actualización.

## Usos Comunes de los Triggers

**Mantenimiento de la Integridad de los Datos**: Los triggers pueden ser utilizados para asegurar que los datos en la base de datos se mantengan consistentes. Por ejemplo, se puede evitar la inserción de datos inválidos mediante un trigger BEFORE INSERT.

**Auditoría de Cambios**: Se pueden registrar automáticamente los cambios que se realizan en la base de datos, como inserciones, actualizaciones o eliminaciones. Un trigger puede insertar estos cambios en una tabla de auditoría.

**Actualización Automática**: En muchos casos, los triggers se usan para mantener las tablas sincronizadas. Por ejemplo, actualizar una columna que contiene un conteo de registros o recalcular valores agregados como sumas o promedios.

**Envío de Notificaciones**: Algunos triggers pueden activar notificaciones (como correos electrónicos o registros en un sistema de monitoreo) cuando ocurren ciertos eventos en la base de datos.

### Consideraciones y Buenas Prácticas

**Rendimiento**: Los triggers pueden afectar el rendimiento de la base de datos, especialmente si son complejos o se ejecutan con frecuencia. Es importante considerar el impacto en el rendimiento antes de usarlos.

**Desarrollo de Lógica Compleja**: Evita colocar lógica compleja dentro de los triggers, ya que puede hacer que el mantenimiento de la base de datos sea más difícil. En su lugar, intenta mantener la lógica en procedimientos almacenados o en la aplicación.

**Depuración**: Los triggers pueden hacer más difícil depurar ciertos problemas, ya que la lógica del trigger se ejecuta automáticamente y puede no ser visible de inmediato para el desarrollador. Asegúrate de documentar y probar bien los triggers.

