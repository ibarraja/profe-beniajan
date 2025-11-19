# Formularios en HTML

## 1. ¿Qué es un formulario?

Un **formulario HTML** es la parte de una página web que permite al usuario **introducir datos** y enviarlos a un servidor para ser procesados.

```html
<form action="/procesar" method="post">
  <!-- campos del formulario -->
</form>
```

**Ideas clave**

* Se define con la etiqueta `form`.
* Envía la información a una URL indicada en `action`.
* Usa un método de envío (`method`) como `get` o `post`.

---

## 2. Atributos importantes de `<form>`

* **action**: URL donde se envían los datos.
* **method**:

  * `get`: los datos viajan en la URL (visible, para búsquedas simples).
  * `post`: los datos viajan en el cuerpo de la petición (más seguro, para formularios largos o con datos sensibles).
* **autocomplete**: `on` / `off` para controlar la autocompletación.
* **novalidate**: desactiva la validación HTML5 al enviar.

Ejemplo:

```html
<form action="/registro" method="post" autocomplete="on">
  ...
</form>
```

---

## 3. Controles básicos de formulario

Los controles se suelen definir con la etiqueta `input` o con otras etiquetas específicas.

### 3.1. Campo de texto

```html
<label for="nombre">Nombre:</label>
<input type="text" id="nombre" name="nombre" required>
```

Atributos habituales: `name`, `id`, `placeholder`, `value`, `required`, `maxlength`.

### 3.2. Contraseña

```html
<label for="pass">Contraseña:</label>
<input type="password" id="pass" name="pass" required>
```

### 3.3. Números

```html
<label for="edad">Edad:</label>
<input type="number" id="edad" name="edad" min="0" max="120" step="1">
```

### 3.4. Correo electrónico

```html
<label for="email">Correo:</label>
<input type="email" id="email" name="email" required>
```

### 3.5. Teléfono

```html
<label for="tel">Teléfono:</label>
<input type="tel" id="tel" name="tel" placeholder="600123456">
```

### 3.6. Fecha y hora (HTML5)

```html
<label for="fecha">Fecha de nacimiento:</label>
<input type="date" id="fecha" name="fecha">
```

```html
<label for="hora">Hora de cita:</label>
<input type="time" id="hora" name="hora">
```

---

## 4. Botones de opción (`radio`) y casillas (`checkbox`)

### 4.1. Botones de opción (una sola elección)

```html
<p>Género:</p>
<label>
  <input type="radio" name="genero" value="m"> Masculino
</label>
<label>
  <input type="radio" name="genero" value="f"> Femenino
</label>
<label>
  <input type="radio" name="genero" value="o"> Otro
</label>
```

Todos los `radio` comparten el mismo atributo `name` para permitir **una sola opción**.

### 4.2. Casillas de verificación (múltiple elección)

```html
<p>Aficiones:</p>
<label><input type="checkbox" name="aficiones" value="deporte"> Deporte</label>
<label><input type="checkbox" name="aficiones" value="lectura"> Lectura</label>
<label><input type="checkbox" name="aficiones" value="musica"> Música</label>
```

---

## 5. Listas desplegables y áreas de texto

### 5.1. Lista desplegable (`select`)

```html
<label for="pais">País:</label>
<select id="pais" name="pais">
  <option value="es">España</option>
  <option value="fr">Francia</option>
  <option value="it">Italia</option>
</select>
```

### 5.2. Área de texto (`textarea`)

```html
<label for="comentarios">Comentarios:</label>
<textarea id="comentarios" name="comentarios" rows="4" cols="40" placeholder="Escribe aquí..."></textarea>
```

---

## 6. Etiqueta `<label>` y accesibilidad

La etiqueta `label` se usa para **asociar un texto descriptivo** a un control de formulario:

```html
<label for="email">Correo electrónico</label>
<input type="email" id="email" name="email">
```

Beneficios:

* Mejora la **accesibilidad** (lectores de pantalla).
* Amplía el área de clic.
* Facilita entender qué hay que escribir en cada campo.

---

## 7. Envío y reseteo del formulario

### 7.1. Botón de enviar
#### 7.1.1. Estructura básica
**1.** `<input type="submit">`
```html
<input type="submit" value="Enviar formulario">
```
- **Etiqueta vacía** (No tiene contenido dentro).
- El texto del botón se pone con el atributo `value`.
- No puedes meter HTML dentro (iconos, spans, etc.).

**2.** `<button type="submit"">`:
```html
<button type="submit">Enviar</button>
```
- **Etiqueta contenedora** (tiene contenido dentro).
- El texto del botón va dentro de la etiqueta de apertura y cierre.
- Puedes meter más HTML dentro:
    ```html
    <button type="submit">
    <span>Enviar</span> ✅
    </button>
    ```

### 7.1.2. Flexibilidad y diseño
`button` es más flexible:
- Permite iconos, imágenes, `<span>`, `<strong>`, etc.
- Es más cómodo para diseño avanzado (CSS, iconos de librerías, etc.).

`input` es más simple:
- Ideal para formularios sencillos tipo “Enviar” y “Cancelar”.
- Menos posibilidades de “liarla” con estilos y contenido.


### 7.2. Botón de resetear

```html
<button type="reset">Limpiar</button>
```

---

## 8. Validación básica en HTML5

HTML5 ofrece atributos para **validar datos** sin usar JavaScript.

Atributos:

* `required`: campo obligatorio.
* `min`, `max`, `step`: rangos numéricos o de fecha.
* `pattern`: expresión regular.
* `maxlength`: longitud máxima.

Ejemplo con `pattern`:

```html
<label for="usuario">Usuario (solo letras y números):</label>
<input type="text" id="usuario" name="usuario" pattern="[A-Za-z0-9]+" required>
```

---

## 9. Ejemplo de formulario completo

```html
<form action="/registro" method="post">
  <h2>Formulario de registro</h2>

  <label for="nombre">Nombre:</label>
  <input type="text" id="nombre" name="nombre" required>

  <label for="email">Correo electrónico:</label>
  <input type="email" id="email" name="email" required>

  <label for="pass">Contraseña:</label>
  <input type="password" id="pass" name="pass" minlength="6" required>

  <p>Sexo:</p>
  <label><input type="radio" name="sexo" value="h"> Hombre</label>
  <label><input type="radio" name="sexo" value="m"> Mujer</label>

  <label for="pais">País:</label>
  <select id="pais" name="pais">
    <option value="es">España</option>
    <option value="mx">México</option>
    <option value="ar">Argentina</option>
  </select>

  <label for="bio">Sobre ti:</label>
  <textarea id="bio" name="bio" rows="4"></textarea>

  <label>
    <input type="checkbox" name="condiciones" required>
    Acepto las condiciones de uso
  </label>

  <button type="submit">Registrarme</button>
</form>
```



