# Cursores
Un cursor se obtiene para el procesamiento individual de las filas devuelatas por el sistema gestor de datos para una consulta. Un cursor puede verse como un iterador sobre la colección de filas que se obtendrá como resultado de una consulta.

> **¿Esto qué significa?**
> Cuando haces una consulta a una base de datos (por ejemplo: "dame todos los alumnos"), la base de datos puede devolver muchas filas. En lugar de darte *todas* de golpe, te da un cursor.
> 
> **¿Qué es entonces un cursor?**
> Piensa en un cursor como un **dedo** que va señalando cada fila de la lista de resultados una por una. Sirve para que puedas **procesar cada fila por separado:** lees una fila, haces algo con ella; luego pasas a la siguiente; y así sucesivamente.
> 
> **¿Por qué existe?**
> Porque a veces la base de datos devuelve miles o millones de filas, y no quieres cargarlas todas de una vez en memoria. Con el cursor, solo trabajas una vez.
>
> **Caracterísitcas de los cursores**
> - Son de **solo lectura**: Solo sirven para leer datos. Es decir, solo podemos declarar un cursor para leer los datos que provienen de una consulta `SELECT` y nunca podremos modificar los datos de la tabla a través del cursor.
> - **Acceso secuencial**: La información que va a procesar el cursor (el resultado de un `SELECT`) es secuencial. Vamos a recorrer fila a fila desde la primera a la última de forma secuencial, una detrás de otra y no podremos saltar a una fila cualquiera de forma directa, tendremos que pasar por tadas las anteriores.
> - Puede crearse dentro de un procedimiento, función o trigger.

Un cursor se define con la siguiente sintaxis:
```sql
DECLARE nombre_cursor CURSOR FOR
SELECT columa1, [columna2, ...];
```
Para manipular los cursores disponemos de una serie de instrucciones
- `OPEN`: inicializa el conjunto de resultados asociados con el cursor.
- `FETCH`: extrae la siguiente fila de valores del conjunto de resultados del cursor, moviendo su puntero intero a una posición.
- `CLOSE`: cierra el cursor liberando la memoria que ocupa y haciendo imposible el acceso a cualquiera de sus datos.
```sql
OPEN nombre_cursor;
FETCH nombre_cursor INTO lista_de_variables;
CLOSE nombre_cursor;
``` 
Uno de los aspectos más importantes al trabajar con cursores es que tenemos que definir un manejador para el error `NOT FOUND` para evitar que nuestra rutina se pare de forma anormal cuando no queden más filas por procesar.

Veamos un ejemplo para ilustrar el uso de los cursores:
- Debemos crear una tabla llamada jardineria.limitecredito. con dos campos: `ciudad (VARCHAR(50))` y `limite (DECIMAL(15,2))`.
- En esta tabla almacenaremos dos registros, uno para ciudad de Madrid y otro para Paris, donde alamacenaremos la suma del campo `LimiteCredito` de los clientes de esas ciudades de la tabla `jardineria.Clientes`.

```sql
DELIMITER //
CREATE PROCEDURE ejemplo_cursores()
BEGIN
   DECLARE ultima_fila INT DEFAULT 0;
   DECLARE ciu VARCHAR(50);
   DECLARE imp DECIMAL(15,2);
   DECLARE suma_madrid DECIMAL (15,2) DEFAULT 0;
   DECLARE suma_paris decimal(15,2) DEFAULT 0; 
   DECLARE cursorLimite CURSOR FOR SELECT Ciudad, LimiteCredito FROM jardineria.Clientes; 
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET ultima_fila = 1; 

   /* Creamos la tabla limitecredito */ 
   DROP TABLE IF EXISTS jardineria.limitecredito; 
   CREATE TABLE jardineria.limitecredito (ciudad VARCHAR(50) PRIMARY KEY, limite 
   DECIMAL(15,2)); 

   /* Procesamos el cursor */ 
   OPEN cursorLimite; 
      bucle_cursor: LOOP 
      FETCH cursorLimite INTO ciu, imp; 
   
         IF ultima_fila = 1 THEN  
            LEAVE bucle_cursor; 
         END IF; 
         
         IF ciu = 'Madrid' THEN 
            SET suma_madrid = suma_madrid + imp; 
         ELSEIF ciu = 'Paris' THEN 
            SET suma_paris = suma_paris + imp; 
         END IF; 
         
      END LOOP bucle_cursor; 
   CLOSE cursorLimite; 
   
   /* Insertamos los valores obtenidos */ 
   INSERT INTO jardineria.limitecredito VALUES ('Madrid',suma_madrid); 
   INSERT INTO jardineria.limitecredito VALUES ('Paris',suma_paris); 
END; //
DELIMITER ;
```

**NOTA IMPORTANTE**: Debemos evitar declarar variables con el mismo nombre que los campos seleccionados en la definición del cursor. 

Para más información [click en el enlace](https://wiki.cifprodolfoucha.es/index.php?title=BD_UD7_Cursores#Manejo_de_cursores)
