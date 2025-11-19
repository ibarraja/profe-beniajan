### Actividad 1: Formulario de contacto
Crea un formulario web que simule una página de contacto.
El formulario debe incluir:
- Un campo para el nombre completo.
- Un campo para el correo electrónico.
- Un campo para el asunto del mensaje.
- Un área de texto donde el usuario pueda escribir su mensaje.
- Un botón para enviar el formulario.
Todos los campos deben estar correctamente identificados mediante etiquetas descriptivas.

### Actividad 2: Formulario de registro de usuario

Diseña un formulario destinado al registro de un nuevo usuario en una plataforma.
Debe incluir:

- Un campo para el nombre de usuario.
- Un campo para la contraseña y otro para repetir la contraseña.
- Un campo para el correo electrónico.
- Un campo para la fecha de nacimiento.
- Un apartado donde el usuario pueda seleccionar sus aficiones utilizando casillas de verificación (checkbox).
- Un botón para crear la cuenta.

El formulario debe estar organizado y ser fácil de leer.

### Actividad 3: Crear un formulario accesible desde cero (con un poco de CSS)

En esta actividad vas a diseñar un formulario nuevo prestando especial atención a la accesibilidad y a aplicar un poco de CSS básico.

#### Situación propuesta

Imagina que una empresa quiere recoger la opinión de sus clientes.
Vas a crear un formulario de encuesta de satisfacción accesible.

#### Pasos a seguir

**1. Crea un nuevo archivo HTML**
    - Crea un archivo llamado, por ejemplo, encuesta_accesible.html.
    - Añade la estructura básica de una página HTML y, dentro del <body>, crea un formulario.

**2. Añade los campos del formulario**
   - Tu formulario debe incluir, como mínimo:
   - Un campo de texto para el nombre de la persona.
   - Un campo de correo electrónico.
   - Un conjunto de opciones para valorar el servicio (por ejemplo: “Muy malo”, “Malo”, “Normal”, “Bueno”, “Excelente”), usando botones de opción (radio).
   - Un área de texto para comentarios adicionales.
   - Un botón para enviar el formulario.

**3. Usa correctamente `label`, `id` y `name`**
   - Cada campo del formulario debe tener:
     - Un atributo id único.
     - Un atributo name coherente con el dato que recoge (por ejemplo: name="nombre", `name="email"`, `name="valoracion"`, `name="comentarios"`).
   - Cada campo debe estar asociado a una etiqueta label:
     - La etiqueta label debe usar el atributo for con el mismo valor que el id del campo al que describe.
   - Para la valoración, escribe primero un texto (por ejemplo, “¿Cómo valoras nuestro servicio?”) y debajo coloca las distintas opciones con input type="radio" y sus label.

**4. Aplica un CSS**:
Añade una sección `<style>` en el `<head>` o un archivo CSS externo para mejorar un poco la presentación del formulario.
Como mínimo, debes:
  - Dar un poco de separación vertical entre los grupos de campos (por ejemplo, usando margin-bottom en los contenedores o en los label/input).
  - Aumentar ligeramente el tamaño de la letra del formulario (por ejemplo, en el body o en el formulario).
  - Poner las etiquetas label en negrita.
  - Mejorar el botón de enviar (por ejemplo, añadiendo un poco de relleno padding y cambiando el tipo de letra o el borde).

El objetivo no es hacer un diseño avanzado, sino que el formulario se vea un poco más ordenado y legible.
