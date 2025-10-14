package org.iesch.a03_menu_principal.apirazas

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.iesch.a03_menu_principal.R
import org.iesch.a03_menu_principal.apirazas.model.APIService
import org.iesch.a03_menu_principal.databinding.ActivityRazasApiBinding
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


class RazasApiActivity : AppCompatActivity() {
    private lateinit var binding: ActivityRazasApiBinding
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
            if ( call.isSuccessful ){
                // Mostraremos el RecyclerView
            } else {
                // Mostraremos un error en un Toast
            }

        }
    }

}