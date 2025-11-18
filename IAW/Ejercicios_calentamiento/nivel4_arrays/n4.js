// Recorrer un array y mostrar elementos
const frutas = ["Manzana", "Banana", "Naranja", "Uva"];

for (let i = 0; i < frutas.length; i++) {
  console.log(frutas[i]);
}

// Encontrar el número mayor en un array

//let numeros = [0, 54, 53, 23, -8, 0, 55, 98, 36]
let numeros = [-70, -54, -53, -23, -8, -10, -55, -98, -36]

let mayor = numeros[0]

for (let i = 0; i<numeros.length; i++) {
    if (mayor < numeros[i]) {
        mayor = numeros[i]
    }
}

console.log(mayor)
