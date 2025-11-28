$(document).ready(function() {
    $("#btn").click(function(){

        var dni = $("#dni").val();
        var pass = $("#pass").val();
        var $resultado = $("#resultado");

        // Expresiones regulares
        var formato1= /^[0-9]{8}[A-Za-z]{1}$/;
        var formato2= /^[0-9]{2}\.[0-9]{3}\.[0-9]{3}-[A-Za-z]{1}$/;
        var array_formatos_dni = [formato1, formato2];
        
        var formato_pass = /^[!-z]{8,10}$/;

        // Validaciones
        var dni_correcto = false;
        for (var i = 0;i < array_formatos_dni.length; i++) {
            if(array_formatos_dni[i].test(dni)) {
                dni_correcto = true;
            }
        }

        var pass_correcto = formato_pass.test(pass);

        // Limpiamos div
        $resultado.empty().removeClass("correcto incorrecto");

        if (dni_correcto &&  pass_correcto) {
            $resultado.text("Información validada correctamente!")
                      .addClass("correcto");
            $resultado.classList.add("correcto");
        } else{
            $resultado.classList.addClass("incorrecto");

            if(!dni_correcto) {
                $resultado.append("<p>DNI formato incorrecto!</p>");
            }
            if(!pass_correcto) {
                $resultado.append("<p>Contraseña formato incorrecto!</p>");
            }
        }
    })
})
