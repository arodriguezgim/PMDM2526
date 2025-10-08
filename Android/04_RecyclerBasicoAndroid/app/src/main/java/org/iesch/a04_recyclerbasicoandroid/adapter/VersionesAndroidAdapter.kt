package org.iesch.a04_recyclerbasicoandroid.adapter

import android.R
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView


/* Paso 3: Creamos el Adaptador:
El adaptador es elpuente entre nuestros datos y el RecyclerView.
Se encarga de:
1- Crear las vistas para cada elemento - onCreateViewHolder
2- Enlazar los datos con las vistas - onBindViewHolder
3- Indicar cuántos elementos hay - getItemCount
 */
class VersionesAndroidAdapter( val listaVersiones: List<String>) : RecyclerView.Adapter<AndroidVersionViewHolder>() {
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): AndroidVersionViewHolder {
        //Paso 5: Crea una nueva vista cuando es necesario
        // Infla el layout para cada item
        val layoutInflater = LayoutInflater.from( parent.context )
        return AndroidVersionViewHolder( layoutInflater.inflate(R.layout.simple_list_item_1, parent, false))
    }

    override fun onBindViewHolder(
        holder: AndroidVersionViewHolder,
        position: Int
    ) {
        TODO("Not yet implemented")
    }

    // Paso 4: Este metodo devuelve el numero todal de elementos
    override fun getItemCount(): Int {
        return listaVersiones.size
    }
}

class AndroidVersionViewHolder(view: View ) : RecyclerView.ViewHolder(view) {

}