# Ejercicio Calendario
**Este ejercicio es de dificultad elevada**
Lo más importante para resolver este ejercicio es hacer de un problema grande muchos problemas pequeños e ir tratando de resolverlos todos para lograr el objetivo final.

Vais a crear un HTML y JS.

## HTML (parte fácil)
Creamos los siguientes elementos:
- `h1`: Por defecto aparece el texto "Calendario". (Extra de dificultad: hacer que aparezca en el centro superior de la pantalla).
- `div`: Contenedor vacío. Añadid un atributo `id` y dotarlo con un nombre descriptivo. Tened en cuenta que dentro de este `<div>` tendrá que aparecer una tabla representando un mes concreto.
- `input type="cal"`: Input donde el usuario selecciona una fecha concreta. Añadid un label que aclare que hay que escoger una fecha y pulsar el botón de mostrar en calendario.
- `button`: Al hacer click en el boton, si hemos introducido una fecha válida (básicamente que nos aseguremos que hemos seleccionado una fecha antes de pulsar el botón) generará un calendario mostrando el mes concreto seleccionado. Lo haremos generando una tabla con thead con los días de la semana como primera fila, luego completando el resto de filas con el número de día asociado a su día concreto. 

### Recuerda:
Las tablas en HTML se hacen del siguiente modo:
```html
<table>
    <thead>
        <tr>
            <th>TituloColumna1</th>
            <th>TituloColumna2</th>
            <th>TituloColumna3</th>
        </tr>
        <tr> <!-- Opcionalmente podemos meter más filas, pero es raro que se añadan más de una fila en <thead> -->
            <td>contenido1</td>
            <td>contenido1</td>
            <td>contenido1</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Contenido1</td>
            <td>Contenido2</td>
            <td>Contenido3</td>
        </tr>
        <tr>
            ...
        </tr>
    </tbody>
</table>

```
## JS (parte complicada)

### 1. Capturar elementos del DOM y preparar el flujo

Seleccionar y guardar en variables:
- El input de fecha.
- El botón.
- El div contenedor donde se pintará el calendario.

Antes de aplicar la lógica del calendario real, es recomendable hacer una tabla de prueba construida completamente con document.createElement, para verificar que dominas la generación dinámica de tablas.

### 2. Validar la fecha elegida
Objetivo: evitar errores por intentar construir un calendario sin fecha.

- Al hacer click: Comprobar si el input está vacío.
- Si está vacío: Mostrar un aviso claro (alert o mensaje en pantalla). Salir de la función sin construir nada.
- Si tiene fecha: Continuar con el proceso

### 3. Extraer año y mes de la fecha seleccionada

Objetivo: quedarte solo con lo que importa para construir el mes.
- Convertir el valor del input a objeto `Date`.
- Obtener:
- Año
- Mes (recordar que en JS va de 0 a 11).⚠️ Peligro típico: enero = 0, febrero = 1, etc.

Podéis usar `alert()` para comprobar que recogeis los valores correctamente

### 4. Calcular propiedades necesarias del mes
Objetivo: tener todos los datos para colocar los números en la tabla.

Necesitas tres cosas:
1. Día de la semana del día 1 del mes
   - Crear una fecha con año, mes y día=1.
   - Sacar qué weekday es (0–6).
   - Ajustar si el calendario empieza en lunes (lo normal en España). Ejemplo conceptual: si JS da `domingo=0`, lo pasas a `domingo=6`.
2. Número total de días del mes:
   - Obtener el “último día del mes” creando una fecha del mes siguiente con día 0.
   - Ese día te devuelve 28–31 según el mes (incluido febrero y bisiestos).
3. Número de semanas (filas) necesarias:
    - Total celdas = huecos iniciales + días del mes. Sí sabes cuántas filas crear y cuándo poner celdas vacías.
Número de semanas (filas) necesarias

Total celdas = huecos iniciales + días del mes.

Filas = ceil(total / 7).

✔️ Idea clave: así sabes cuántas filas crear y cuándo poner celdas vacías.