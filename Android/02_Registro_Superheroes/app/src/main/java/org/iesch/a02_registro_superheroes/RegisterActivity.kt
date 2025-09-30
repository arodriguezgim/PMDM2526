package org.iesch.a02_registro_superheroes

import android.content.Intent
import android.health.connect.datatypes.units.Power
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.a02_registro_superheroes.databinding.ActivityRegisterBinding
import org.iesch.a02_registro_superheroes.detalle.DetalleHeroeActivity
import org.iesch.a02_registro_superheroes.model.SuperHeroe

class RegisterActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRegisterBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        binding.btnGuardar.setOnClickListener {
            // Nos creamos las variables necesarias para pasarlas al Intent
            val superHeroName = binding.etHeroName.text.toString()
            val alterEgo = binding.etAlterEgo.text.toString()
            val bio = binding.etBio.text.toString()
            val power = binding.rbPower.rating
            // 7 - Me creo un objeto SuperHeroe y se lo envío a la funcion irADetalle
            val superHeroe = SuperHeroe(superHeroName, alterEgo, bio, power)

            irADetalleHeroe( superHeroe )

        }
    }

    private fun irADetalleHeroe( superHeroe: SuperHeroe ) {
        // El intent debe tener muy claro desde dónde se le llama y a dónde va
        val intent = Intent(this, DetalleHeroeActivity::class.java)

        // Añado los valores al Intent con la función putExtra
        //intent.putExtra(DetalleHeroeActivity.HERO_NAME ,superHeroName)
        //intent.putExtra(DetalleHeroeActivity.ALTER_EGO, alterEgo)
        //intent.putExtra(DetalleHeroeActivity.BIO,bio)
        //intent.putExtra(DetalleHeroeActivity.POWER, power)
        intent.putExtra(DetalleHeroeActivity.SUPERHEROE_KEY, superHeroe)

        startActivity(intent)
    }
}