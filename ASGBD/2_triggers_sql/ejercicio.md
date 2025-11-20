Crea una base de datos llamada `banco`, dentro de la cual se debe crear una tabla movimiento. Esta tabla tendrá dos columnas: `num_cuenta` (número de cuenta) y `cantidad` (monto asociado con el movimiento). Luego, crea un trigger que ajuste automáticamente la cantidad insertada en la tabla movimiento de acuerdo con el siguiente criterio:

- Si el número de cuenta está entre 100 y 150, incrementa la cantidad en un 50%.
- Si el número de cuenta está entre 151 y 200, reduce la cantidad en un 50%.

Haced un par de pruebas comprobando que funcionen correctamente.


```sql
CREATE DATABASE IF NOT EXISTS banco;

USE banco;

CREATE TABLE IF NOT EXISTS movimiento (
  num_cuenta INT,
  cantidad DECIMAL(10, 2)
);


// Trigger a partir de aquí
```