package org.iesch.a03_menu_principal.mapas

import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.mapbox.geojson.Point
import com.mapbox.maps.CameraOptions
import com.mapbox.maps.MapView
import com.mapbox.maps.Style
import com.mapbox.maps.plugin.annotation.annotations
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions
import org.iesch.a03_menu_principal.R
import org.iesch.a03_menu_principal.databinding.ActivityMapasBinding

class MapasActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMapasBinding
    private lateinit var mapView: MapView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityMapasBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        // Iniciamos el mapa
        mapView = binding.mapView
        // Necesitamos el Token
        val mapboxToken = getString(R.string.mapbox_access_token)
        // Configuramos el mapa y el estilo del mapa
        mapView.mapboxMap.apply {
            // Cargamos el estilo del mapa
            loadStyle(Style.MAPBOX_STREETS) { style ->
                // Configuramos la ubicacion inicial del mapa
                setCamera(
                    CameraOptions.Builder()
                        .center(Point.fromLngLat(-1.097681, 40.327509))
                        .zoom(16.0)
                        .build()
                )
                style.addImage()
                val bitmap = BitmapFactory.decodeResource(resources, R.drawable.marker_red)
                val annotationApi = mapView.annotations
                val pointAnnotationManager = annotationApi.createAnnotationManager()
            }
        }

        // Pongo un marker
        addMarker()
    }

    private fun addMarker() {
        val annotationApi = mapView.annotations
        val pointAnnotationManager = annotationApi.createAnnotationManager()
        // Cargar imagen desde recursos
        val bitmap = BitmapFactory.decodeResource(resources, R.drawable.marker_red)
        style.add

        val pointAnnotationOptions = PointAnnotationOptions()
            .withPoint(Point.fromLngLat(-1.097681, 40.327509))
            .withIconImage("custom-marker")
            .withIconSize(1.5) // Tamaño del icono

        pointAnnotationManager.create(pointAnnotationOptions)
    }
}