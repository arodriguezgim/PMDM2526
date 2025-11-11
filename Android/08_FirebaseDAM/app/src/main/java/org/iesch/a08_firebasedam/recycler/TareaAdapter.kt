package org.iesch.a08_firebasedam.recycler

import androidx.recyclerview.widget.RecyclerView
import org.iesch.a08_firebasedam.databinding.ActivityListaTareasBinding
import org.iesch.a08_firebasedam.databinding.ItemTareaBinding
import org.iesch.a08_firebasedam.model.Tarea

// 7 - Creamos el Adaptador
class TareaAdapter(
    private var listaTareas: MutableList<Tarea>
) : RecyclerView.ViewHolder<TareaAdapter.TareaViewHolder> {
    class TareaViewHolder( private val binding: ItemTareaBinding): RecyclerView.ViewHolder(binding.root) {

    }

}