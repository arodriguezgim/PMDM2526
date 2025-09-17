package org.iesch.app00

var weekDays = arrayOf("Lunes", "Martes", "Miercoles", "jueves", "Viernes", "Sabado", "Domingo")

fun main() {
    println( weekDays ) // Nos muestra la direccion de la memoria
    println( weekDays[2] )
    println( weekDays.size )
    weekDays[2] = "Hoy es Miercoles!!!!" // Le puedo cambiar el valor a un array
    println( weekDays[2] )
    // Recorrer Arrays
    /*
    for (position in weekDays.indices){
        println(weekDays[position])
    }

    for ((position, value) in weekDays.withIndex()){
        println("La poosicion $position contiene $value")
    }
    */

    for ( valor in weekDays ){
        println( "El dia es $valor")
    }

    weekDays.forEach { dia -> print(dia) }

}