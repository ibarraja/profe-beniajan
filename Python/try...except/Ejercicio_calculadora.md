# Ejercicio: Calculadora con funciones, bucles y manejo de excepciones

Crea un programa en Python que simule una calculadora básica por consola. El programa debe mostrar un menú en bucle con las siguientes operaciones:

1. Suma
2. Resta
3. Multiplicación
4. División
5. Potencia
6. Salir

## Requisitos obligatorios

1. **Menú con bucle**
   - El programa debe mostrarse repetidamente hasta que el usuario elija la opción “6. Salir”.
   - Después de realizar una operación, debe volver a aparecer el menú.

2. **Funciones**
   - Crea al menos una función por operación:
      1. sumar(a, b)
      2. restar(a, b)
      3. multiplicar(a, b)
      4. dividir(a, b)
      5. potencia(a, b)
   - Crea, además, una función que se encargue de mostrar el menú y otra para leer la opción del usuario si lo ves necesario.

3. **Entrada de datos**
   - Para cada operación (excepto salir), el programa debe pedir dos números al usuario.
   - Los números deberán leerse por teclado.

4. **Manejo de excepciones con try y except**
   - Controla con `try` / `except` que:
     - Si el usuario introduce algo que no sea un número, se muestre un mensaje de error y se vuelva a pedir el dato.
     - En la división, si el segundo número es cero, se capture la excepción correspondiente y se muestre un mensaje como: 
     `Error: no se puede dividir entre cero.`
   - Puedes añadir más controles de errores si lo consideras necesario.

5. **Salida por pantalla**
   Después de cada operación, muestra el resultado con un mensaje claro, por ejemplo:
   `La suma de 4.0 y 5.0 es 9.0`

Si el usuario introduce una opción de menú que no exista, muestra un mensaje de error y vuelve a mostrar el menú.

>**Ejemplo de funcionamiento**
>```bash
>=== CALCULADORA ===
>1. Suma
>2. Resta
>3. Multiplicación
>4. División
>5. Potencia
>6. Salir
>Elige una opción: 4
>Introduce el primer número: 10
>Introduce el segundo número: 0
>Error: no se puede dividir entre cero.
>
>=== CALCULADORA ===
>1. Suma
>2. Resta
>3. Multiplicación
>4. División
>5. Potencia
>6. Salir
>Elige una opción: 1
>Introduce el primer número: 3
>Introduce el segundo número: 7
>La suma de 3.0 y 7.0 es 10.0
>```