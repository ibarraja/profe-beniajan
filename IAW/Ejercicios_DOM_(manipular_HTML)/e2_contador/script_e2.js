const btn = document.getElementById("btnSumar");
const contador = document.getElementById("contador");

btn.addEventListener("click", () => {
    let valor = parseInt(contador.textContent);
    contador.textContent = valor + 1;
});

document.