// Función que saluda
function saludar() {
    console.log("¡hola mundo!");
}

saludar();
// Función para calcular el área de un triángulo
function calcular_area_triangulo(base, altura) {
    return (base*altura/2);
}

let b = 5
let a = 10

let area = calcular_area_triangulo(b, a);

console.log(area);
