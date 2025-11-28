let btn = document.getElementById("btn");
let dni = document.getElementById("dni");
let pass = document.getElementById("pass");
let resultado = document.getElementById("resultado");

btn.addEventListener("click", function() {
    // Expresiones regulares
    //DNI
    var formato1= /^[0-9]{8}[A-Za-z]{1}$/;
    var formato2= /^[0-9]{2}\.[0-9]{3}\.[0-9]{3}-[A-Za-z]{1}$/;
    var array_formatos_dni = [formato1, formato2];
    
    // Contraseña
    var formato_pass = /^[!-z]{8,10}$/;

    // Validaciones
    let dni_correcto = false;
    let pass_correcto = false;

    for(var i=0; i<array_formatos_dni.length; i++) {
        if(array_formatos_dni[i].test(dni.value)){
            dni_correcto = true;
        }
    }

    // validar si tiene un simbolo la contraseña 
    if(formato_pass.test(pass.value)){
        pass_correcto = true;
    }
    pass_tiene_caracter= false
    for (var i=0; i<pass.length; i++) {
        if (pass[i].in['+','*','@']){
            pass_tiene_caracter = true;
        }
    }
    var contraseña_super_segura = false;
    if(pass_tiene_caracter && pass_correcto){
        contraseña_super_segura=true;
    }


    // Limpiar el div
    resultado.innerHTML = "";
    resultado.classList.remove("correcto","incorrecto");

    // Rellenar información en div
    if (dni_correcto &&  contraseña_super_segura) {
        resultado.textContent = "Información validada correctamente!";
        resultado.classList.add("correcto");
    } else{
        resultado.classList.add("incorrecto");

        if(!dni_correcto) {
            resultado.innerHTML += "<p>DNI formato incorrecto!</p>";
        }
        if(!contraseña_super_segura) {
            resultado.innerHTML += "<p>Contraseña formato incorrecto!</p>";
        }
    }
});
