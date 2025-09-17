package org.iesch.app00


fun main() {

    //getMonth(5)

    resultado(true)

}

fun getMonth(mes: Int){
    when (mes){
        1 -> print("Enero")
        2 -> print("Febrero")
        3 -> print("Marzo")
        4 -> print("Abril")
        5 -> print("Mayo")
        6 -> print("Junio")
        7 -> print("Julio")
        8 -> print("Agosto")
        9 -> print("Septiembre")
        10 -> print("Octubre")
        11 -> print("Noviembre")
        12 -> print("Diciembre")
        else -> print("Mes erroneo")
    }
}

fun getTrimester(mes:Int) {
    when (mes){
        1, 2, 3 -> print("Primer trimestre")
        4, 5, 6 -> print("Segundo trimestre")
        7, 8, 9 -> print("Tercer trimestre")
        10, 11, 12 -> print("Cuarto trimestre")
        else -> print("Mes erroneo")
    }
}

fun getSemester(mes:Int){
    when (mes){
        in 1..6 -> print("Primer semestre")
        in 7..12 -> print("Segundo semestre")
        !in 1..12 -> print("Mes erroneo")
    }
}

fun resultado( valor: Any) {
    when (valor){
        is Int -> valor+ valor
        is String -> print(valor)
        is Boolean -> if ( valor ) print("Es booleano y vale true")
    }
}