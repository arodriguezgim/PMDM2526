package org.iesch.a03_menu_principal.apirazas

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.iesch.a03_menu_principal.R
import org.iesch.a03_menu_principal.apirazas.adapter.DogAdapter
import org.iesch.a03_menu_principal.apirazas.model.APIService
import org.iesch.a03_menu_principal.databinding.ActivityRazasApiBinding
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


class RazasApiActivity : AppCompatActivity() {
    private lateinit var binding: ActivityRazasApiBinding

    // 9
    private lateinit var adapter: DogAdapter
    private val dogImages = mutableListOf<String>()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRazasApiBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //  1 - Creamos un metodo que inicie el RecyclerView
        initRecyclerView()

    }

    private fun initRecyclerView() {
        // 10 Hemos de crear el adaptador
        adapter = DogAdapter(dogImages)
        binding.rvDogs.layoutManager = LinearLayoutManager(this)
        binding.rvDogs.adapter = adapter
    }

    // 5 - Creamos una instancia de Retrofit
    private fun getRetrofit(): Retrofit{
        return Retrofit.Builder()
            .baseUrl("https://dog.ceo/api/breed/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }
    // hasta aqui to do lo de retrofit
    // 6 - Implemento la funcion de buscar por razas
    private fun buscarPorRaza( raza : String ){
        CoroutineScope(Dispatchers.IO).launch {
            // To do lo que se ejecute aquí se está ejecutando en un hilo secundario
            val call = getRetrofit().create<APIService>(APIService::class.java).getPerrosPorRaza("$raza/images")
            val puppies = call.body()
            // 11 - Estoy en un hilo secundario, ya para pintar la respuesta necesito volver al hilo principal
            // Lo haré mediante runOnUiThread

            runOnUiThread {
                // to do el codigo que se ejecute aquí lo hará en el hilo principal
                // 12 - Almacenamos en una variable las imagenes.
                val imagenes = puppies?.images ?: emptyList()
                // 13 Primero borro to do lo que tengamos y añado los datos recibidos
                dogImages.clear()
                dogImages.addAll( imagenes )
                // 14 - Avisamos al adaptador de que han habido cambios
                adapter.notifyDataSetChanged()

            }
            if ( call.isSuccessful ){
                // Mostraremos el RecyclerView
            } else {
                // Mostraremos un error en un Toast
            }

        }
    }

}