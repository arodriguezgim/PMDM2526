package org.iesch.a08_firebasedam

import android.os.Bundle
import android.view.View
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.firebase.Firebase
import com.google.firebase.auth.auth
import com.google.firebase.remoteconfig.remoteConfig
import org.iesch.a08_firebasedam.databinding.ActivityHomeBinding


enum class ProviderType{
    EMAILYCONTRASENA,
    GOOGLE
}
class HomeActivity : AppCompatActivity() {

    private lateinit var binding: ActivityHomeBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(binding.root) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        //Recuperamos los valores del usuario
        initUI()
        // Recuperamos nuestra Configuración Remota
        configuracionRemota()


        // Listener para el boton de cerrar sesion
        binding.logoutButton.setOnClickListener {
            Firebase.auth.signOut()
            finish()
        }
    }

    private fun configuracionRemota() {
        binding.optionalButton.visibility = View.INVISIBLE
        Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener {
            val showOptionalButtom = Firebase.remoteConfig.getBoolean("show_optional_button")
            val textoBotonOpcional = Firebase.remoteConfig.getString("optional_button_text")
            val colorDeFondo = Firebase.remoteConfig.getString("color_bg")

            if (showOptionalButtom) {
                binding.optionalButton.visibility = View.VISIBLE
                binding.optionalButton.text = textoBotonOpcional
            }
            // Aplicar color de fondo usando la cadena desde Remote Config
            val bgColor = resolveColorString(colorDeFondo)
            binding.root.setBackgroundColor(bgColor)
        }
    }

    private fun resolveColorString(colorString: String?): Int {
        if (colorString.isNullOrBlank()) {
            return ContextCompat.getColor(this, android.R.color.background_light)
        }

        val trimmed = colorString.trim()

        // 1) Intentar como recurso en res/color (nombre en colors.xml)
        val colorResId = resources.getIdentifier(trimmed, "color", packageName)
        if (colorResId != 0) {
            return ContextCompat.getColor(this, colorResId)
        }
        // Fallback final
        return ContextCompat.getColor(this, android.R.color.background_light)
    }


    private fun initUI() {
        // Recuperamos los valores del Bundle
        val bundle = intent.extras
        val email = bundle?.getString("usuario")
        val provider = bundle?.getString("provider")

        // Lo mostramos en los textview para ello
        binding.emailTextView.text = email.toString()
        binding.metodoTextView.text = provider.toString()
    }
}