package org.iesch.a02_registro_superheroes

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.health.connect.datatypes.units.Power
import android.os.Bundle
import android.os.Environment
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
import java.io.File

class RegisterActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRegisterBinding
    private lateinit var heroImage: ImageView

    private var heroBitmap: Bitmap? = null
    // 1 - Cambiamos el TakePicturePreview por TakePicture
    private  var picturePath = ""
    private val getContent = registerForActivityResult(ActivityResultContracts.TakePicture()){
        //Ahora en lugar de un bitmap nos va a devolver un booleano si la toma de la foto es exitosa
        success ->
            if ( success && picturePath.isNotEmpty() ){
                // Culquier imagen del directorio la podemos convertir en un bitmap
                heroBitmap = BitmapFactory.decodeFile(picturePath)
                // Pintamos la imagen en el cuadradito
                heroImage.setImageBitmap(heroBitmap)
            }
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


        heroImage = binding.superheroImage
        binding.superheroImage.setOnClickListener {
            openCamera()
        }
    }

    private fun openCamera() {
        // 2 - Ahora a quí debemos crear un path temporal para guardar la imagen
        val imageFile = createImageFile()
        //getContent.launch()
    }

    //3 - Esta función crea un File y de ese File recupreraremos el uri.
    private fun createImageFile() : File {
        val fileName = "superhero_image"
        // Esto será el directorio donde vamos a almcenar la imagen. Por defecto es DIRECTORY_PICTURES
        val fileDirectory = getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        // creamos nuestro file, y aqui nos pide el nombre, el formato, y el directorio
        val imageFile = File.createTempFile(fileName, ".jpg", fileDirectory )
        // Ahora ya podemos guardar el path en la variable global
        picturePath = imageFile.absolutePath
        return imageFile
    }

    private fun irADetalleHeroe( superHeroe: SuperHeroe ) {

        val intent = Intent(this, DetalleHeroeActivity::class.java)
        intent.putExtra(DetalleHeroeActivity.SUPERHEROE_KEY, superHeroe)
        intent.putExtra(DetalleHeroeActivity.FOTO_KEY, heroImage.drawable.toBitmap())
        startActivity(intent)
    }
}