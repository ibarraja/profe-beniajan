let btn = document.getElementById("btn")

btn.addEventListener("click", function() {
    var dni = document.getElementById("dni").value;
    var pass = document.getElementById("pass").value;
    var resultado = document.getElementById("resultado");


    // Expresiones regulares
    var formato1 = /^[0-9]{8}-[A-Za-z]{1}$/;
    var formato2 = /^[0-9]{8}[A-Za-z]{1}$/;
    var formato3 = /^[0-9]{2}\.[0-9]{3}\.[0-9]{3}-[A-Za-z]{1}$/;
    var formatos = [formato1, formato2, formato3];

    var formato_pass = /^[A-Za-z0-9]{8,10}$/;

    // Validaciones
    var dni_correcto = formatos.some(function(f) {
        return f.test(dni);
    });

    var pass_correcto = formato_pass.test(pass);

    // Limpiar el div
    resultado.innerHTML = "";
    resultado.classList.remove("correcto", "incorrecto");

    if (dni_correcto && pass_correcto) {
        resultado.textContent = "Información validada correctamente!";
        resultado.classList.add("correcto");
    } else {
        resultado.classList.add("incorrecto");

        if (!dni_correcto) {
            resultado.innerHTML += "<p>DNI formato incorrecto!</p>";
        }
        if (!pass_correcto) {
            resultado.innerHTML += "<p>Contraseña formato incorrecto!</p>";
        }
    }
});
