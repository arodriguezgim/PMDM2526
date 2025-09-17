package org.iesch.app00

import kotlin.reflect.KMutableProperty0

fun main() {
    listasMutables()
}

fun listasMutables() {

    val weekDays =
        mutableListOf("Lunes", "Martes", "Miercoles", "jueves", "Viernes", "Sabado", "Domingo")
    //print(weekDays)
    /*
        if ( weekDays.isEmpty() ){
            println("La lista está vacia")
        } else {
            weekDays.forEach { println(it) }
        }

        if ( weekDays.isNotEmpty()){
            println("La lista no está vacia")
        }
      */
    println(weekDays.last())
    println(weekDays.first())
    // Filtrar en listas
    println( weekDays.filter { it.contains('a') } )

    weekDays.add( 2, "Chomonero")
    println(weekDays)
}