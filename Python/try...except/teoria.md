# Python Try Except
El bloque `try` permite probar un bloque de código para detectar errores.

El bloque `except` permite gestionar el error.

El bloque `else` permite ejecutar código cuando no hay ningún error.

El bloque `finally` permite ejecutar código, independientemente del resultado de los bloques try y except.

## Manejo de excepciones
Cuando se produce un error, o una excepción como la llamamos, Python normalmente se detendrá y generará un mensaje de error

Estas excepciones se pueden manejar mediante la trydeclaración:

>**Ejemplo**
>El bloque `try` generará una excepción porque `x` no está definido:
>```py
>try:
>    print(x)
>except:
>    print("Un error ha ocurrido")
>```
Dado  que el bloque `try` genera un error, se ejecuta el bloque `except`.
Sin el bloque `try`, el programa se bloqueará y generará un error:
>**Ejemplo**
>Esta declaraación generará un error, >porque `x` no esta definido:
>```py
>print(x)
>```

## Muchas excepciones
Puedes definir tantos bloques de excepciones como quieras, por ejemplo, si quieres ejecutar un bloque de código especial para un tipo especial de error:
>**Ejemplo**
>Imprime un mensaje sie l bloque try genera un error `NameError` y otro para otros errores:
>```python
> try:
>     print(x)
> except NameError:
>     print("Variable x is not defined")
> except:
>     print("Something else went wrong")
> ```

Consulta mas errores [aquí](teoria.md)

## Else
Puedes usar `else` para definir un bloque de codigo que será ejecutado si no se ha lanzado ningun error:
>**Ejemplo**
>In este ejemplo, el bloque `try` no genera nigún error:
>```python
>try:
>    print("Hola")
>except:
>    print("Algo ha ido mal")
>else:
>    print("Nada ha ido mal")
>``` 

## Finally
El bloque `finally`, si se ha especificado, será ejecutado a pesar de si el bloque `try` lanza o no un error.
>**Ejemplo**
>```python
>try:
>    print(x)
>except:
>    print("Algo ha ido mal")
>finally:
>    print("El 'try except' ha terminado")
>```
Esto puede ser útil para cerrar objetos y limpiar recursos:
>**Ejemplo**
>Intentar abrir y escribir un archivo que no tiene permisos de escritura:
>```python
>try:
>    f = open("archivo_pruebas.txt")
>    try:
>        f.write("Lorem Ipsum")
>    except:
>        print("Algo ha salido mal")
>    finally:
>        f.close()
>except:
>    print("Algo haid mal cuando se ha tratado de abrir el archivo")
>```

El prograa puede continuar, sin dejar el objeto archivo abierto.

## Raise exception
Como desarrolladores Python podeis elejir lanzar una excepcion si una condición concreta ocurre.
Para *lanzar* una excepcion, hay que usar la palabra clave `raise`.
>**Ejemplo**
>Lanzar un error y detener el programa si x es menor que 0:
>```python
>x = -1
>if x < 0:
>    raise Exception("Error: no puedes poner un número negativo")
>```
`raise` es usada para lanzar la excepción.
Puedes definir el tipo de error que alzar, y el texto que se imprimirá al usuario.
>**Ejemplo**
>Lanzar un TyoeError si x no es un entero:
>```python
>x = "Hola"
>
>if not type(x) is int:
>    raise TypeError("Solo se permiten enteros")
>```