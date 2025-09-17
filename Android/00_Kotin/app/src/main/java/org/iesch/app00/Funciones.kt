package org.iesch.app00

var nombre = "Alberto"

var numero1 = 23
var numero2 = 34
fun saludar(){
    print("Hola $nombre")
}


fun main() {
    // el nombre delas funciones siempre en camelCase
    //saludar()
    sumar(numero1, numero2)
}

fun sumar(num1: Int, num2: Int) : Int {
    var resultado = num1 + num2
    return resultado

}