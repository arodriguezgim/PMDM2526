package org.iesch.a06_ciclo_de_vida

import android.os.Bundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        Log.i("ciclovida", "Entramos en el método onCreate")
    }

    override fun onStart() {
        super.onStart()
        Log.w("ciclovida", "Entramos en el método onStart")
    }

    override fun onResume() {
        super.onResume()
        Log.e("ciclovida", "Entramos en el método onResume")
    }

    override fun onPause() {
        super.onPause()
        Log.e("ciclovida", "Entramos en el método onPause")
    }

    override fun onRestart() {
        super.onRestart()
        Log.e("ciclovida", "Entramos en el método onRestart")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.e("ciclovida", "Entramos en el método onDestroy")
    }
}