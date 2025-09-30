package org.iesch.a02_registro_superheroes

import android.content.Intent
import android.graphics.Bitmap
import android.health.connect.datatypes.units.Power
import android.os.Bundle
import android.widget.ImageView
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.graphics.drawable.toBitmap
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.a02_registro_superheroes.databinding.ActivityRegisterBinding
import org.iesch.a02_registro_superheroes.detalle.DetalleHeroeActivity
import org.iesch.a02_registro_superheroes.model.SuperHeroe

class RegisterActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRegisterBinding
    private lateinit var heroImage: ImageView
    // 9 - Creamos una variable que va a manejar el resultado de haber hecho la foto
    private var heroBitmap: Bitmap? = null
    private val getContent = registerForActivityResult(ActivityResultContracts.TakePicturePreview()){
        // Esto nos va a devolver un objeto de tipo bitmap
        bitmap ->
            heroBitmap = bitmap
            heroImage.setImageBitmap(heroBitmap)
    }

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

            val superHeroName = binding.etHeroName.text.toString()
            val alterEgo = binding.etAlterEgo.text.toString()
            val bio = binding.etBio.text.toString()
            val power = binding.rbPower.rating

            val superHeroe = SuperHeroe(superHeroName, alterEgo, bio, power)
            irADetalleHeroe( superHeroe )

        }

            // 10
        heroImage = binding.superheroImage
        binding.superheroImage.setOnClickListener {
            openCamera()
        }
    }

    private fun openCamera() {
        // 11 - Abrimos la camara llamando al getContent launch
        getContent.launch(null)
    }

    private fun irADetalleHeroe( superHeroe: SuperHeroe ) {

        val intent = Intent(this, DetalleHeroeActivity::class.java)
        intent.putExtra(DetalleHeroeActivity.SUPERHEROE_KEY, superHeroe)
        // 12 - Añado el objeto bitmap al intent
        intent.putExtra(DetalleHeroeActivity.FOTO_KEY, heroImage.drawable.toBitmap())
        startActivity(intent)
    }
}