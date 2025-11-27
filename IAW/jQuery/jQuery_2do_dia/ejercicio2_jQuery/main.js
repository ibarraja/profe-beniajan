$(document).ready(function() {
    $("#btn").click(function(event) {
        event.preventDefault(); // evita recargar el formulario

        var dni = $("#dni").val();
        var pass = $("#pass").val();
        var $resultado = $("#resultado");

        // Expresiones regulares
        var formato1 = /^[0-9]{8}-[A-Za-z]{1}$/;
        var formato2 = /^[0-9]{8}[A-Za-z]{1}$/;
        var formato3 = /^[0-9]{2}\.[0-9]{3}\.[0-9]{3}-[A-Za-z]{1}$/;
        var formatos = [formato1, formato2, formato3];

        var formato_pass = /^[A-Za-z0-9]{8,10}$/;

        // Validaciones
        var dni_correcto = false;
        for (var i = 0; i < formatos.length; i++) {
            if (formatos[i].test(dni)) {
                dni_correcto = true;
                break;
            }
        }

        var pass_correcto = formato_pass.test(pass);

        // Limpiar el div
        $resultado.empty().removeClass("correcto incorrecto");

        if (dni_correcto && pass_correcto) {
            $resultado.text("Información validada correctamente!")
                      .addClass("correcto");
        } else {
            $resultado.addClass("incorrecto");
            if (!dni_correcto) {
                $resultado.append("<p>DNI formato incorrecto!</p>");
            }
            if (!pass_correcto) {
                $resultado.append("<p>Contraseña formato incorrecto!</p>");
            }
        }
    });
});

