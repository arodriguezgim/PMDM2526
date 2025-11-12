package org.iesch.a08_firebasedam.recycler

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import org.iesch.a08_firebasedam.databinding.ActivityListaTareasBinding
import org.iesch.a08_firebasedam.databinding.ItemTareaBinding
import org.iesch.a08_firebasedam.model.Tarea

// 7 - Creamos el Adaptador
class TareaAdapter(
    private var listaTareas: MutableList<Tarea>
) : RecyclerView.Adapter<TareaViewHolder>() {
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): TareaViewHolder {
        // 4 Inflo el layout del Item
        val binding = ItemTareaBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        // 5 Devolvemos el ViewHolder
        return TareaViewHolder( binding )
    }

    override fun onBindViewHolder(
        holder: TareaViewHolder,
        position: Int
    ) {
        // 3 - Llamo al bind del ViewHolder
        holder.bind( listaTareas[position])
    }

    override fun getItemCount(): Int {
        // 2
        return listaTareas.size
    }

    fun actualizarLista(  nuevaLista: MutableList<Tarea> ){
        listaTareas = nuevaLista
        notifyDataSetChanged()
    }

}
// 1 - Me creo el ViewHolder
class TareaViewHolder( private  val binding: ItemTareaBinding ) : RecyclerView.ViewHolder(binding.root){

    fun bind( tarea: Tarea ){
        binding.tvTitulo.text = tarea.titulo
        binding.tvDescripcion.text = tarea.descripcion
    }
}