// 1.Mostrar los números del 1 al 10
    // con `for`:
for (let i=1; i <= 10; i++) {
    console.log(i);
}
    // con `while`:
let j = 1;
while (j <= 10) {
    console.log(j);
    j++;
}
    // con `do while`:
let k = 1;
do {
    console.log(k);
    k++;
} while (k <= 10);

// 2. Sumar números del 1 al 100
// Calcular suma y luego mostrarla. No es necesario mostrar cada iteración
let suma = 0;
for (l = 1; l <= 100; l++) {
    suma += l;
}
console.log(suma);

// 3. Mostrar una tabla de multiplicar
const numero = 5;
for (let num = 1; num <= 10; num++) {
    console.log(`${numero} x ${num} = ${numero * num}`)
}