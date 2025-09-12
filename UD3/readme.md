# UD 3 - Estructura de una Aplicación Android en Kotlin

## Introducción

Una aplicación Android nativa está compuesta por múltiples archivos y directorios que trabajan en conjunto. En esta guía aprenderemos qué función cumple cada componente y cómo se organiza el proyecto, tanto para aplicaciones tradicionales con XML como para aplicaciones modernas con Jetpack Compose.

## Estructura General del Proyecto

Cuando creas un nuevo proyecto en Android Studio, se genera automáticamente la siguiente estructura:

```
MiApp/
├── app/
│   ├── build.gradle.kts (Module: app)
│   ├── proguard-rules.pro
│   └── src/
│       ├── main/
│       │   ├── java/com/miempresa/miapp/
│       │   │   └── MainActivity.kt
│       │   ├── res/
│       │   │   ├── layout/
│       │   │   ├── values/
│       │   │   ├── drawable/
│       │   │   └── mipmap/
│       │   └── AndroidManifest.xml
│       ├── test/
│       └── androidTest/
├── gradle/
├── build.gradle.kts (Project)
├── gradle.properties
└── settings.gradle.kts
```

## Archivos de Configuración Principal

### 1. build.gradle.kts (Project Level)

Este archivo configura el proyecto completo y define las dependencias globales:

```kotlin
// Top-level build file where you can add configuration options common to all sub-modules/projects.
buildscript {
    ext.kotlin_version = "1.9.10"
    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

**Función:** Define las herramientas de construcción y repositorios que se usarán en todo el proyecto.

### 2. build.gradle.kts (Module: app)

Este es el archivo más importante para la configuración de tu aplicación:

```kotlin
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("kotlin-kapt") // Para anotaciones
}

android {
    namespace = "com.miempresa.miapp"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.miempresa.miapp"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        
        // Para Jetpack Compose
        vectorDrawables {
            useSupportLibrary = true
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            isDebuggable = true
        }
    }
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = "1.8"
    }
    
    // Para Jetpack Compose
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.4"
    }
    
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
    implementation("androidx.activity:activity-compose:1.8.0")
    
    // Jetpack Compose BOM
    implementation(platform("androidx.compose:compose-bom:2023.10.01"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-graphics")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material3:material3")
    
    // Testing
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}
```

**Componentes principales explicados:**

- **applicationId**: Identificador único de tu app en Google Play
- **minSdk**: Versión mínima de Android compatible
- **targetSdk**: Versión de Android para la que optimizas
- **versionCode**: Número de versión interno (debe incrementarse con cada actualización)
- **versionName**: Versión visible para el usuario
- **buildTypes**: Configuraciones para debug y release
- **dependencies**: Librerías externas que usa tu app

### 3. settings.gradle.kts

Define qué módulos incluir en el proyecto:

```kotlin
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "Mi App"
include(":app")
```

### 4. gradle.properties

Configuraciones globales del proyecto:

```properties
# Project-wide Gradle settings
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
org.gradle.parallel=true

# Android operating system
android.useAndroidX=true
android.enableJetifier=true

# Kotlin code style
kotlin.code.style=official
android.nonTransitiveRClass=true
```

## AndroidManifest.xml

Este archivo es el "documento de identidad" de tu aplicación:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <!-- Permisos que necesita la app -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CAMERA" />

    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.MiApp"
        tools:targetApi="31">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:label="@string/app_name"
            android:theme="@style/Theme.MiApp">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        
        <!-- Otras actividades -->
        <activity
            android:name=".SecondActivity"
            android:exported="false" />
            
    </application>

</manifest>
```

**Elementos importantes:**

- **uses-permission**: Permisos que solicita la app
- **application**: Configuración general de la aplicación
- **activity**: Cada pantalla de tu app debe declararse aquí
- **intent-filter**: Define qué actividad se abre al iniciar la app
- **exported**: Si la actividad puede ser llamada por otras apps

## Directorio src/main/

### Código Fuente (java/ o kotlin/)

Aquí vive todo el código de tu aplicación, organizado por paquetes:

```
java/com/miempresa/miapp/
├── MainActivity.kt
├── ui/
│   ├── theme/
│   │   ├── Color.kt
│   │   ├── Theme.kt
│   │   └── Type.kt
│   └── screens/
│       ├── HomeScreen.kt
│       └── DetailScreen.kt
├── data/
│   ├── model/
│   └── repository/
└── util/
```

### Recursos (res/)

Contiene todos los recursos no-código de tu aplicación:

#### drawable/
Imágenes, iconos y formas vectoriales:
```
drawable/
├── ic_home.xml        # Icono vectorial
├── background.png     # Imagen PNG
└── button_shape.xml   # Forma personalizada
```

#### layout/ (Solo para apps tradicionales, no Compose)
Archivos XML que definen la interfaz:
```xml
<!-- activity_main.xml -->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <TextView
        android:id="@+id/tvTitle"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="@string/welcome" />

</LinearLayout>
```

#### values/
Valores constantes como colores, strings, dimensiones:

**strings.xml:**
```xml
<resources>
    <string name="app_name">Mi App</string>
    <string name="welcome">¡Bienvenido!</string>
</resources>
```

**colors.xml:**
```xml
<resources>
    <color name="primary">#6200EE</color>
    <color name="primary_dark">#3700B3</color>
    <color name="accent">#03DAC5</color>
</resources>
```

#### mipmap/
Iconos de la aplicación en diferentes resoluciones:
```
mipmap-hdpi/
mipmap-mdpi/
mipmap-xhdpi/
mipmap-xxhdpi/
mipmap-xxxhdpi/
```

## Diferencias entre App Tradicional y Jetpack Compose

### App Tradicional (XML + Kotlin)

**MainActivity.kt:**
```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        val textView = findViewById<TextView>(R.id.tvTitle)
        textView.text = "¡Hola desde Kotlin!"
    }
}
```

**Características:**
- Usa archivos XML para definir la UI
- Necesita findViewById() para acceder a vistas
- Separación clara entre lógica (Kotlin) y vista (XML)

### App con Jetpack Compose

**MainActivity.kt:**
```kotlin
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MiAppTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Greeting("Android")
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "¡Hola $name!",
        modifier = modifier
    )
}
```

**Características:**
- UI definida completamente en Kotlin usando funciones @Composable
- No necesita XML layouts
- Programación declarativa vs imperativa
- Mayor reutilización de componentes


## Archivos Adicionales Importantes

### proguard-rules.pro
Reglas para ofuscar y optimizar el código en release:
```pro
# Keep class names for reflection
-keep class com.miempresa.miapp.data.model.** { *; }

# Keep Compose classes
-keep class androidx.compose.** { *; }
```

### gradle.properties (Módulo)
Configuraciones específicas del módulo si es necesario.

## Flujo de Construcción

1. **Gradle** lee la configuración y dependencias
2. **Android Manifest** se procesa para conocer la estructura de la app
3. **Recursos** se compilan y optimizan
4. **Código Kotlin** se compila a bytecode
5. Se genera el **APK** final


## Ejemplo Práctico: App Básica

Vamos a crear una aplicación simple que muestre una lista de elementos:

### Con XML tradicional:

**activity_main.xml:**
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <TextView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="@string/title"
        android:textSize="24sp"
        android:textStyle="bold" />

    <RecyclerView
        android:id="@+id/recyclerView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_marginTop="16dp" />

</LinearLayout>
```

### Con Jetpack Compose:

```kotlin
@Composable
fun MainScreen(items: List<String>) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        Text(
            text = stringResource(id = R.string.title),
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        LazyColumn {
            items(items) { item ->
                ItemCard(text = item)
            }
        }
    }
}
```

