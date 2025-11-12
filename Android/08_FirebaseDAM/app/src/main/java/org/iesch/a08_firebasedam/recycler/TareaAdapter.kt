package org.iesch.a08_firebasedam.recycler

import android.graphics.Color
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import org.iesch.a08_firebasedam.databinding.ActivityListaTareasBinding
import org.iesch.a08_firebasedam.databinding.ItemTareaBinding
import org.iesch.a08_firebasedam.model.Tarea


class TareaAdapter(
    private var listaTareas: MutableList<Tarea>,
    private val onBorrar: ((Tarea) -> Unit )? = null,
    private val onToogleCompletada: ((Tarea) -> Unit )? = null,
) : RecyclerView.Adapter<TareaViewHolder>() {
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): TareaViewHolder {

        val binding = ItemTareaBinding.inflate(LayoutInflater.from(parent.context), parent, false)

        return TareaViewHolder( binding )
    }

    override fun onBindViewHolder(
        holder: TareaViewHolder,
        position: Int
    ) {

        holder.bind( listaTareas[position], onBorrar, onToogleCompletada )
    }

    override fun getItemCount(): Int {

        return listaTareas.size
    }

    fun actualizarLista(  nuevaLista: MutableList<Tarea> ){
        listaTareas = nuevaLista
        notifyDataSetChanged()
    }

}
// 1 - Me creo el ViewHolder
class TareaViewHolder( private  val binding: ItemTareaBinding ) : RecyclerView.ViewHolder(binding.root){

    fun bind(
        tarea: Tarea,
        onBorrar: ((Tarea) -> Unit)? = null,
        onToogleCompletada: ((Tarea) -> Unit)? = null
    ){
        binding.tvTitulo.text = tarea.titulo
        binding.tvDescripcion.text = tarea.descripcion
        // Pongo a true o false el check que he añadido en base a lo que valga
        binding.swCompletada.setOnCheckedChangeListener(null)
        binding.swCompletada.isChecked = tarea.completada

        aplicarEstiloCompletada( tarea.completada )

        binding.swCompletada.setOnCheckedChangeListener { _, isChecked ->
            // Actualizamos el valor del objeto
            tarea.completada = isChecked
            aplicarEstiloCompletada( isChecked )
            onToogleCompletada?.invoke( tarea )
        }

        binding.imgBtnBorrar.setOnClickListener {
            onBorrar?.invoke( tarea )
        }
    }

    private fun aplicarEstiloCompletada( completada: Boolean) {
        if ( completada ) {
            binding.card.setBackgroundColor(Color.parseColor("#B9F1BB"))
        } else {
            binding.card.setBackgroundColor(Color.parseColor("#F0BFBB"))
        }
    }
}