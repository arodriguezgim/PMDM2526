# Tutorial: Cambiar Temas en styles.xml en Android con Kotlin

## Introducción

En Android, los temas se definen en archivos XML (generalmente `styles.xml` o `themes.xml`) y permiten personalizar la apariencia de tu aplicación. Este tutorial te mostrará cómo crear, personalizar y aplicar temas en tu proyecto Android con Kotlin.

## Ubicación de los Archivos

Los archivos de estilos se encuentran en:
```
app/src/main/res/values/styles.xml
app/src/main/res/values/themes.xml
```

## 1. Estructura Básica de un Tema

Un tema en Android hereda de un tema padre y puede personalizar atributos específicos:

```xml
<!-- res/values/themes.xml -->
<resources>
    <style name="AppTheme" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
        <!-- Personalización de colores -->
        <item name="colorPrimary">@color/purple_500</item>
        <item name="colorPrimaryVariant">@color/purple_700</item>
        <item name="colorOnPrimary">@color/white</item>
        
        <item name="colorSecondary">@color/teal_200</item>
        <item name="colorSecondaryVariant">@color/teal_700</item>
        <item name="colorOnSecondary">@color/black</item>
        
        <!-- Personalización de otros atributos -->
        <item name="android:statusBarColor">?attr/colorPrimaryVariant</item>
    </style>
</resources>
```

## 2. Crear Múltiples Temas

Puedes crear varios temas para diferentes propósitos:

```xml
<!-- res/values/themes.xml -->
<resources>
    <!-- Tema principal -->
    <style name="AppTheme" parent="Theme.MaterialComponents.Light">
        <item name="colorPrimary">@color/blue_500</item>
        <item name="colorPrimaryVariant">@color/blue_700</item>
        <item name="colorSecondary">@color/orange_500</item>
    </style>
    
    <!-- Tema oscuro -->
    <style name="AppTheme.Dark" parent="Theme.MaterialComponents">
        <item name="colorPrimary">@color/blue_200</item>
        <item name="colorPrimaryVariant">@color/blue_700</item>
        <item name="colorSecondary">@color/orange_200</item>
        <item name="android:windowBackground">@color/dark_background</item>
    </style>
    
    <!-- Tema sin ActionBar -->
    <style name="AppTheme.NoActionBar">
        <item name="windowActionBar">false</item>
        <item name="windowNoTitle">true</item>
    </style>
    
    <!-- Tema para pantalla completa -->
    <style name="AppTheme.FullScreen" parent="AppTheme.NoActionBar">
        <item name="android:windowFullscreen">true</item>
    </style>
</resources>
```

## 3. Aplicar Temas en AndroidManifest.xml

### Aplicar tema a toda la aplicación:

```xml
<!-- AndroidManifest.xml -->
<application
    android:theme="@style/AppTheme"
    ...>
    <!-- Tus actividades -->
</application>
```

### Aplicar tema a una actividad específica:

```xml
<application ...>
    <activity
        android:name=".MainActivity"
        android:theme="@style/AppTheme.NoActionBar" />
        
    <activity
        android:name=".SplashActivity"
        android:theme="@style/AppTheme.FullScreen" />
</application>
```

## 4. Cambiar Tema Dinámicamente desde Kotlin

### Opción 1: Cambiar tema antes de setContentView()

```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Cambiar el tema ANTES de setContentView()
        setTheme(R.style.AppTheme_Dark)
        
        setContentView(R.layout.activity_main)
    }
}
```

### Opción 2: Sistema de preferencias con SharedPreferences

```kotlin
class MainActivity : AppCompatActivity() {
    
    private lateinit var sharedPreferences: SharedPreferences
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Cargar preferencias
        sharedPreferences = getSharedPreferences("app_preferences", Context.MODE_PRIVATE)
        
        // Aplicar el tema guardado
        applyTheme()
        
        setContentView(R.layout.activity_main)
        
        // Configurar botón para cambiar tema
        findViewById<Button>(R.id.btnChangeTheme).setOnClickListener {
            toggleTheme()
        }
    }
    
    private fun applyTheme() {
        val isDarkTheme = sharedPreferences.getBoolean("dark_theme", false)
        if (isDarkTheme) {
            setTheme(R.style.AppTheme_Dark)
        } else {
            setTheme(R.style.AppTheme)
        }
    }
    
    private fun toggleTheme() {
        val isDarkTheme = sharedPreferences.getBoolean("dark_theme", false)
        
        // Guardar nueva preferencia
        sharedPreferences.edit().putBoolean("dark_theme", !isDarkTheme).apply()
        
        // Recrear la actividad para aplicar el nuevo tema
        recreate()
    }
}
```

### Opción 3: Clase Helper para gestionar temas

```kotlin
object ThemeHelper {
    private const val PREF_NAME = "theme_preferences"
    private const val KEY_THEME = "selected_theme"
    
    const val THEME_LIGHT = 0
    const val THEME_DARK = 1
    const val THEME_BLUE = 2
    
    fun applyTheme(activity: Activity) {
        val prefs = activity.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
        val theme = prefs.getInt(KEY_THEME, THEME_LIGHT)
        
        when (theme) {
            THEME_LIGHT -> activity.setTheme(R.style.AppTheme)
            THEME_DARK -> activity.setTheme(R.style.AppTheme_Dark)
            THEME_BLUE -> activity.setTheme(R.style.AppTheme_Blue)
        }
    }
    
    fun setTheme(activity: Activity, theme: Int) {
        val prefs = activity.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
        prefs.edit().putInt(KEY_THEME, theme).apply()
        activity.recreate()
    }
    
    fun getCurrentTheme(context: Context): Int {
        val prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
        return prefs.getInt(KEY_THEME, THEME_LIGHT)
    }
}

// Uso en tu Activity:
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        ThemeHelper.applyTheme(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        // Cambiar a tema oscuro
        findViewById<Button>(R.id.btnDarkTheme).setOnClickListener {
            ThemeHelper.setTheme(this, ThemeHelper.THEME_DARK)
        }
    }
}
```

## 5. Atributos Comunes Personalizables

```xml
<style name="CustomTheme" parent="Theme.MaterialComponents.Light">
    <!-- Colores principales -->
    <item name="colorPrimary">#6200EE</item>
    <item name="colorPrimaryVariant">#3700B3</item>
    <item name="colorOnPrimary">#FFFFFF</item>
    
    <!-- Colores secundarios -->
    <item name="colorSecondary">#03DAC6</item>
    <item name="colorSecondaryVariant">#018786</item>
    <item name="colorOnSecondary">#000000</item>
    
    <!-- Colores de fondo -->
    <item name="android:colorBackground">#FFFFFF</item>
    <item name="colorSurface">#FFFFFF</item>
    <item name="colorOnBackground">#000000</item>
    <item name="colorOnSurface">#000000</item>
    
    <!-- Colores de error -->
    <item name="colorError">#B00020</item>
    <item name="colorOnError">#FFFFFF</item>
    
    <!-- Barra de estado y navegación -->
    <item name="android:statusBarColor">?attr/colorPrimaryVariant</item>
    <item name="android:navigationBarColor">?attr/colorPrimaryVariant</item>
    
    <!-- Tipografía -->
    <item name="textAppearanceHeadline1">@style/TextAppearance.MyApp.Headline1</item>
    <item name="textAppearanceBody1">@style/TextAppearance.MyApp.Body1</item>
    
    <!-- Formas de componentes -->
    <item name="shapeAppearanceSmallComponent">@style/ShapeAppearance.MyApp.SmallComponent</item>
</style>
```

## 6. Ejemplo Completo: Selector de Temas

```kotlin
class SettingsActivity : AppCompatActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        ThemeHelper.applyTheme(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_settings)
        
        val radioGroup = findViewById<RadioGroup>(R.id.themeRadioGroup)
        
        // Marcar el tema actual
        when (ThemeHelper.getCurrentTheme(this)) {
            ThemeHelper.THEME_LIGHT -> radioGroup.check(R.id.radioLight)
            ThemeHelper.THEME_DARK -> radioGroup.check(R.id.radioDark)
            ThemeHelper.THEME_BLUE -> radioGroup.check(R.id.radioBlue)
        }
        
        // Listener para cambios
        radioGroup.setOnCheckedChangeListener { _, checkedId ->
            when (checkedId) {
                R.id.radioLight -> ThemeHelper.setTheme(this, ThemeHelper.THEME_LIGHT)
                R.id.radioDark -> ThemeHelper.setTheme(this, ThemeHelper.THEME_DARK)
                R.id.radioBlue -> ThemeHelper.setTheme(this, ThemeHelper.THEME_BLUE)
            }
        }
    }
}
```

## 7. Definir Colores en colors.xml

```xml
<!-- res/values/colors.xml -->
<resources>
    <!-- Tema claro -->
    <color name="purple_500">#6200EE</color>
    <color name="purple_700">#3700B3</color>
    <color name="teal_200">#03DAC5</color>
    <color name="teal_700">#018786</color>
    
    <!-- Tema oscuro -->
    <color name="purple_200">#BB86FC</color>
    <color name="dark_background">#121212</color>
    
    <!-- Colores básicos -->
    <color name="white">#FFFFFF</color>
    <color name="black">#000000</color>
</resources>
```

## Consejos Importantes

1. Siempre llama a `setTheme()` ANTES de `setContentView()`
2. Usa `recreate()` para aplicar cambios de tema en tiempo real
3. Considera usar `AppCompatDelegate.setDefaultNightMode()` para modo oscuro del sistema
4. Guarda las preferencias del usuario con SharedPreferences
5. Hereda de temas Material Components para mejores resultados

