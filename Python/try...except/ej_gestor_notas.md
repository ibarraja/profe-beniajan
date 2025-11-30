# Ejercicio: Gestor de notas con funciones, ficheros y manejo de excepciones

Crea un programa en Python que gestione las notas de una clase mediante un menú interactivo por consola.
El objetivo es practicar:

* Uso de funciones.
* Bucles.
* Manejo de excepciones (`try`, `except`, `else`, `finally`).
* Lectura y escritura de ficheros de texto.

El programa debe trabajar con un diccionario de alumnos y notas, por ejemplo:

```python
alumnos = {
    "Ana": 7.5,
    "Luis": 9.0
}
```

y mostrar un menú en bucle con las siguientes opciones:

1. Añadir nota de un alumno
2. Listar alumnos y notas
3. Calcular media de la clase
4. Guardar notas en archivo
5. Cargar notas desde archivo
6. Salir

---

## Requisitos obligatorios

### 1. Menú con bucle

* El programa debe mostrarse repetidamente hasta que el usuario elija la opción **“6. Salir”**.
* Después de realizar una operación, debe volver a aparecer el menú.
* Si el usuario introduce una opción que no existe (por ejemplo, 0, 7, una letra…), debe mostrarse un mensaje de error y volver a pedir una opción válida, usando manejo de excepciones cuando sea necesario.

---

### 2. Estructura del programa (funciones)

Organiza el código en funciones. Como mínimo, deben existir:

* `mostrar_menu()`
  Muestra el menú por pantalla.

* `leer_opcion() -> int`
  Lee la opción del usuario y se asegura de que es un número entero válido.
  Si el usuario escribe algo no numérico, debe capturarse el error (`ValueError`) y volver a pedir la opción.

* `anadir_nota(alumnos: dict) -> None`
  Pide el nombre de un alumno y su nota y la añade al diccionario.

* `listar_notas(alumnos: dict) -> None`
  Muestra todos los alumnos y sus notas.

* `calcular_media(alumnos: dict) -> None`
  Calcula y muestra la nota media de la clase.

* `guardar_en_archivo(alumnos: dict, nombre_archivo: str) -> None`
  Guarda las notas en un archivo de texto.

* `cargar_desde_archivo(nombre_archivo: str) -> dict`
  Lee un archivo de texto y devuelve un diccionario con las notas.

El programa principal debe estar dentro de un bucle que llame a estas funciones según la opción elegida.

---

### 3. Manejo de excepciones

El ejercicio debe incluir **obligatoriamente** manejo de excepciones en varias situaciones.

#### 3.1 Entrada de datos (notas)

Al añadir una nota:

* Pide el **nombre del alumno** (cadena).
* Pide la **nota del alumno** (número decimal).

Requisitos:

* Si el usuario introduce algo que no sea un número para la nota, debe capturarse `ValueError` y volver a pedir la nota.
* Si la nota no está entre **0 y 10**, el programa debe lanzar una excepción manualmente, por ejemplo:

  ```python
  raise ValueError("La nota debe estar entre 0 y 10")
  ```

  y capturarla con `try/except`, mostrando el mensaje de error y volviendo a pedir la nota.

---

#### 3.2 Cálculo de la media

En la opción de “Calcular media de la clase”:

* Si el diccionario `alumnos` está vacío (no hay alumnos), el programa **no** debe intentar dividir entre cero.
* En este caso, se deben contemplar dos opciones (elige una de ellas y documéntala en comentarios):

  1. Mostrar un mensaje indicando que no hay alumnos para calcular la media.
  2. Lanzar una excepción con un mensaje propio (por ejemplo, `Exception("No hay alumnos registrados")`) y capturarla adecuadamente.

---

#### 3.3 Trabajo con ficheros

El programa debe guardar y cargar los datos de un archivo de texto, por ejemplo `notas.txt`.

Formato sugerido del archivo (una línea por alumno):

```text
Ana;7.5
Luis;9.0
```

Puedes usar el carácter `;` como separador entre nombre y nota.

**Guardar en archivo (`guardar_en_archivo`)**:

* Utiliza un bloque `try/except/finally` al abrir el fichero y escribir en él.
* Si ocurre algún error al escribir (por ejemplo, problema de permisos o ruta incorrecta), captura una excepción de tipo `OSError` u otra apropiada y muestra un mensaje de error al usuario.

**Cargar desde archivo (`cargar_desde_archivo`)**:

* Si el archivo no existe, debe capturarse `FileNotFoundError` y mostrar un mensaje del estilo:

  > `Error: el archivo no existe. Asegúrate de haber guardado antes.`
* Si alguna línea del archivo está mal formateada (por ejemplo, falta el `;` o la nota no se puede convertir a `float`), debe capturarse `ValueError` y manejarse el error (ignorando esa línea con un aviso, o deteniendo la carga con un mensaje de error; pero siempre sin que el programa se rompa).

---

### 4. Salida elegante del programa

* La opción **“6. Salir”** debe terminar el bucle principal y finalizar el programa con un mensaje de despedida.
* Opcionalmente, puedes capturar `KeyboardInterrupt` (`Ctrl + C`) alrededor del bucle principal para que, si el usuario interrumpe el programa, se muestre un mensaje como:

  > `Programa interrumpido por el usuario.`

---

## Requisitos opcionales (para nota extra)

Estos puntos son opcionales, pero sirven para practicar más:

1. **Evitar alumnos duplicados**

   * Si el usuario intenta introducir un alumno que ya existe en el diccionario, puedes:

     * Preguntar si desea sobrescribir la nota anterior, o
     * Lanzar una excepción propia y gestionarla con un mensaje.

2. **Ficheros con nombre configurable**

   * Permitir que el usuario indique el nombre del archivo (por ejemplo, `notas1.txt`, `notas_segundoA.txt`, etc.) en las opciones 4 y 5.

3. **Ordenar alumnos al listar**

   * Al listar las notas, mostrar los alumnos ordenados alfabéticamente.

---

## Ejemplo de ejecución (orientativo)

```text
=== GESTOR DE NOTAS ===
1. Añadir nota de un alumno
2. Listar alumnos y notas
3. Calcular media de la clase
4. Guardar notas en archivo
5. Cargar notas desde archivo
6. Salir
Elige una opción: 1
Nombre del alumno: Ana
Nota de Ana: ocho
Error: la nota debe ser un número. Inténtalo de nuevo.
Nota de Ana: 12
Error: la nota debe estar entre 0 y 10.
Nota de Ana: 8.5
Nota de Ana añadida correctamente.

=== GESTOR DE NOTAS ===
1. Añadir nota de un alumno
2. Listar alumnos y notas
3. Calcular media de la clase
4. Guardar notas en archivo
5. Cargar notas desde archivo
6. Salir
Elige una opción: 3
La media de la clase es: 8.5

=== GESTOR DE NOTAS ===
1. Añadir nota de un alumno
2. Listar alumnos y notas
3. Calcular media de la clase
4. Guardar notas en archivo
5. Cargar notas desde archivo
6. Salir
Elige una opción: 4
Notas guardadas correctamente en 'notas.txt'.

=== GESTOR DE NOTAS ===
1. Añadir nota de un alumno
2. Listar alumnos y notas
3. Calcular media de la clase
4. Guardar notas en archivo
5. Cargar notas desde archivo
6. Salir
Elige una opción: 6
Saliendo del programa... ¡Hasta luego!
```
