package org.iesch.a03_menu_principal.settings

import android.content.Context
import android.os.Bundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import org.iesch.a03_menu_principal.R
import org.iesch.a03_menu_principal.databinding.ActivitySettingsBinding

// 1 - Me creo una función de extensión.
// Nos premiten a través de un componente crear métodos o propiedades adicionales sin necesidad de heredar de la clase original.
// Esta funcion de extensión hereda del Context
val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "settings")
// Este delegado nos permite crear unaúnica instancia de la Base de Datos
// name es el nombre de la base de datos


class SettingsActivity : AppCompatActivity() {

    //3
    companion object {
        const val VOLUME_LEVEL = "volume_level"
    }
    private lateinit var binding: ActivitySettingsBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivitySettingsBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        initUI()
    }

    private fun initUI() {
        binding.rsVolumen.addOnChangeListener { _, value, _ ->
            Log.i("alberto", "Guardando valñor de volumen: $value")
        }
    }

    // 2
    private suspend fun saveVolume( value: Int ) {
        // Aquí irá el código para guardar datos en el DataStore
        // No puede ser llamado desde fuera de una corrutina
        dataStore.edit {
            it[intPreferencesKey(VOLUME_LEVEL)] = value
        }
    }
}