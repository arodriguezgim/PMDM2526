package org.iesch.a05_recycler_intermedio.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import org.iesch.a05_recycler_intermedio.databinding.ItemAndroidVersionBinding
import org.iesch.a05_recycler_intermedio.model.AndroidVersion

// 3- Me creo el adaptador
class AndroidVersionAdapter( val versionesAndroid: List<AndroidVersion>) : RecyclerView.Adapter<AndroidVersionViewHolder>() {
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): AndroidVersionViewHolder {
        // Inflar el layout para cada item
        // Le tengo que decir el item, me lo tengo que crear
        val binding = ItemAndroidVersionBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return AndroidVersionViewHolder( binding )
    }

    override fun onBindViewHolder(
        holder: AndroidVersionViewHolder,
        position: Int
    ) {
        // 5
        holder.render(versionesAndroid[position])

    }

    override fun getItemCount(): Int {
        return versionesAndroid.size
    }
}