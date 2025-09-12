# UD 2 - Introducción a Kotlin

## 1. Configuración Inicial y Estructura Básica

### Función main()

**Java:**
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("¡Hola, mundo!");
    }
}
```

**Kotlin:**
```kotlin
fun main() {
    println("¡Hola, mundo!")
}

// También puedes usar argumentos si los necesitas
fun main(args: Array<String>) {
    println("¡Hola, mundo!")
}
```

**Diferencias clave:**
- No necesitas una clase para la función `main()`
- `fun` es la palabra clave para funciones
- No hay `;` al final de las líneas (opcional)
- `println()` en lugar de `System.out.println()`

## 2. Variables y Tipos

### Declaración de Variables

**Java:**
```java
int numero = 42;
final String nombre = "Juan";
String apellido = "Pérez";
```

**Kotlin:**
```kotlin
var numero = 42              // Variable mutable (equivale a int en Java)
val nombre = "Juan"          // Variable inmutable (equivale a final)
var apellido: String = "Pérez" // Tipo explícito (opcional)

// Inferencia de tipos
val edad = 25               // Int
val precio = 19.99          // Double
val esEstudiante = true     // Boolean
```

**Conceptos importantes:**
- `var`: variable mutable (puede cambiar)
- `val`: variable inmutable (como `final` en Java)
- Kotlin infiere el tipo automáticamente
- No hay tipos primitivos, todo son objetos

### Tipos Básicos

**Java vs Kotlin:**
```java
// Java
int entero = 42;
long largo = 123L;
float flotante = 3.14f;
double doble = 3.14159;
boolean booleano = true;
char caracter = 'A';
```

```kotlin
// Kotlin
val entero: Int = 42
val largo: Long = 123L
val flotante: Float = 3.14f
val doble: Double = 3.14159
val booleano: Boolean = true
val caracter: Char = 'A'
```

### Nullable Types

**Java:**
```java
String texto = null; // Puede causar NullPointerException
```

**Kotlin:**
```kotlin
val texto: String = "Hola"        // No puede ser null
val textoNulable: String? = null  // Puede ser null

// Safe call operator
val longitud = textoNulable?.length  // Devuelve null si textoNulable es null

// Elvis operator
val longitudSegura = textoNulable?.length ?: 0  // Si es null, devuelve 0

// Assertion operator (¡cuidado!)
val longitudForzada = textoNulable!!.length  // Lanza excepción si es null
```

## 3. Strings y String Templates

**Java:**
```java
String nombre = "Ana";
int edad = 25;
String mensaje = "Hola " + nombre + ", tienes " + edad + " años";
String mensajeFormat = String.format("Hola %s, tienes %d años", nombre, edad);
```

**Kotlin:**
```kotlin
val nombre = "Ana"
val edad = 25
val mensaje = "Hola $nombre, tienes $edad años"
val mensajeComplejo = "Hola $nombre, el año que viene tendrás ${edad + 1} años"

// String multilínea
val poema = """
    |Roses are red,
    |Violets are blue,
    |Kotlin is awesome,
    |And so are you!
""".trimMargin()
```

## 4. Funciones

### Declaración Básica

**Java:**
```java
public int sumar(int a, int b) {
    return a + b;
}

public void saludar(String nombre) {
    System.out.println("Hola " + nombre);
}
```

**Kotlin:**
```kotlin
fun sumar(a: Int, b: Int): Int {
    return a + b
}

// Función de expresión (más concisa)
fun sumar(a: Int, b: Int): Int = a + b

// Función sin valor de retorno
fun saludar(nombre: String) {
    println("Hola $nombre")
}

// Tipo de retorno Unit (equivale a void, pero es opcional)
fun saludar(nombre: String): Unit {
    println("Hola $nombre")
}
```

### Parámetros por Defecto y Named Arguments

**Java:**
```java
// En Java necesitas sobrecargar métodos
public void conectar(String host) {
    conectar(host, 80);
}

public void conectar(String host, int puerto) {
    conectar(host, puerto, 5000);
}

public void conectar(String host, int puerto, int timeout) {
    // implementación
}
```

**Kotlin:**
```kotlin
// En Kotlin puedes usar valores por defecto
fun conectar(host: String, puerto: Int = 80, timeout: Int = 5000) {
    println("Conectando a $host:$puerto con timeout $timeout")
}

// Diferentes formas de llamar la función
fun main() {
    conectar("localhost")                          // Usa valores por defecto
    conectar("localhost", 8080)                   // Especifica puerto
    conectar("localhost", timeout = 10000)        // Named argument
    conectar(puerto = 9000, host = "example.com") // Orden diferente con named args
}
```

### Funciones de Extensión

Una característica única de Kotlin que permite "añadir" métodos a clases existentes:

```kotlin
// Función de extensión para String
fun String.esPalindromo(): Boolean {
    val limpio = this.lowercase().replace(" ", "")
    return limpio == limpio.reversed()
}

fun main() {
    val texto = "A man a plan a canal Panama"
    println(texto.esPalindromo()) // true
}

// Función de extensión para Int
fun Int.esPar(): Boolean = this % 2 == 0

fun main() {
    val numero = 42
    println(numero.esPar()) // true
}
```

## 5. Clases y Objetos

### Clases Básicas

**Java:**
```java
public class Persona {
    private String nombre;
    private int edad;
    
    public Persona(String nombre, int edad) {
        this.nombre = nombre;
        this.edad = edad;
    }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public int getEdad() { return edad; }
    public void setEdad(int edad) { this.edad = edad; }
    
    @Override
    public String toString() {
        return "Persona{nombre='" + nombre + "', edad=" + edad + "}";
    }
}
```

**Kotlin:**
```kotlin
// Versión básica
class Persona(val nombre: String, var edad: Int) {
    override fun toString(): String {
        return "Persona(nombre='$nombre', edad=$edad)"
    }
}

// Con constructor secundario
class Persona(val nombre: String, var edad: Int) {
    var email: String = ""
    
    // Constructor secundario
    constructor(nombre: String, edad: Int, email: String) : this(nombre, edad) {
        this.email = email
    }
    
    // Bloque init se ejecuta con el constructor primario
    init {
        println("Se ha creado una persona: $nombre")
    }
}
```

### Data Classes

Para clases que solo contienen datos, Kotlin ofrece `data class`:

**Java:**
```java
public class Usuario {
    private String nombre;
    private String email;
    
    // Constructor, getters, setters, equals, hashCode, toString...
    // Mucho código repetitivo
}
```

**Kotlin:**
```kotlin
// Una línea equivale a toda la clase Java anterior
data class Usuario(val nombre: String, val email: String)

fun main() {
    val usuario1 = Usuario("Ana", "ana@email.com")
    val usuario2 = Usuario("Ana", "ana@email.com")
    
    println(usuario1)                    // Usuario(nombre=Ana, email=ana@email.com)
    println(usuario1 == usuario2)        // true (equals automático)
    
    // Copy con modificaciones
    val usuario3 = usuario1.copy(email = "ana.nueva@email.com")
    println(usuario3)                    // Usuario(nombre=Ana, email=ana.nueva@email.com)
    
    // Destructuring
    val (nombre, email) = usuario1
    println("Nombre: $nombre, Email: $email")
}
```

### Herencia

**Java:**
```java
public class Animal {
    protected String nombre;
    
    public Animal(String nombre) {
        this.nombre = nombre;
    }
    
    public void hacerSonido() {
        System.out.println("El animal hace un sonido");
    }
}

public class Perro extends Animal {
    public Perro(String nombre) {
        super(nombre);
    }
    
    @Override
    public void hacerSonido() {
        System.out.println(nombre + " ladra: ¡Guau!");
    }
}
```

**Kotlin:**
```kotlin
// Las clases son final por defecto, usa 'open' para permitir herencia
open class Animal(protected val nombre: String) {
    open fun hacerSonido() {
        println("El animal hace un sonido")
    }
}

class Perro(nombre: String) : Animal(nombre) {
    override fun hacerSonido() {
        println("$nombre ladra: ¡Guau!")
    }
}

// Uso
fun main() {
    val miPerro = Perro("Rex")
    miPerro.hacerSonido() // Rex ladra: ¡Guau!
}
```

## 6. Interfaces

**Java:**
```java
public interface Volador {
    void volar();
    
    default void aterrizar() {
        System.out.println("Aterrizando...");
    }
}

public class Pajaro implements Volador {
    @Override
    public void volar() {
        System.out.println("El pájaro vuela con sus alas");
    }
}
```

**Kotlin:**
```kotlin
interface Volador {
    fun volar()
    
    // Implementación por defecto
    fun aterrizar() {
        println("Aterrizando...")
    }
}

class Pajaro : Volador {
    override fun volar() {
        println("El pájaro vuela con sus alas")
    }
}

// Interfaz con propiedades
interface Vehiculo {
    val velocidadMaxima: Int
    val marca: String
        get() = "Marca desconocida" // Implementación por defecto
}

class Coche : Vehiculo {
    override val velocidadMaxima = 200
    override val marca = "Toyota"
}
```

## 7. Colecciones

### Listas

**Java:**
```java
import java.util.*;

List<String> nombres = Arrays.asList("Ana", "Luis", "María");
List<String> nombresMutable = new ArrayList<>(nombres);
nombresMutable.add("Carlos");

for (String nombre : nombres) {
    System.out.println(nombre);
}
```

**Kotlin:**
```kotlin
// Lista inmutable
val nombres = listOf("Ana", "Luis", "María")

// Lista mutable
val nombresMutable = mutableListOf("Ana", "Luis", "María")
nombresMutable.add("Carlos")

// Iteración
for (nombre in nombres) {
    println(nombre)
}

// Funciones útiles
val nombresLargos = nombres.filter { it.length > 3 }
val nombresMayuscula = nombres.map { it.uppercase() }
val primerNombre = nombres.first()
val ultimoNombre = nombres.last()
```

### Maps

**Java:**
```java
Map<String, Integer> edades = new HashMap<>();
edades.put("Ana", 25);
edades.put("Luis", 30);
edades.put("María", 28);

for (Map.Entry<String, Integer> entry : edades.entrySet()) {
    System.out.println(entry.getKey() + ": " + entry.getValue());
}
```

**Kotlin:**
```kotlin
// Map inmutable
val edades = mapOf(
    "Ana" to 25,
    "Luis" to 30,
    "María" to 28
)

// Map mutable
val edadesMutable = mutableMapOf<String, Int>()
edadesMutable["Carlos"] = 35

// Iteración
for ((nombre, edad) in edades) {
    println("$nombre: $edad")
}

// Acceso seguro
val edadAna = edades["Ana"] ?: 0  // Si no existe, devuelve 0
```

## 8. Control de Flujo

### Condicionales

**Java:**
```java
int puntuacion = 85;
String grado;

if (puntuacion >= 90) {
    grado = "A";
} else if (puntuacion >= 80) {
    grado = "B";
} else if (puntuacion >= 70) {
    grado = "C";
} else {
    grado = "F";
}
```

**Kotlin:**
```kotlin
val puntuacion = 85

// if como expresión (devuelve un valor)
val grado = if (puntuacion >= 90) {
    "A"
} else if (puntuacion >= 80) {
    "B"
} else if (puntuacion >= 70) {
    "C"
} else {
    "F"
}

// when (equivalente a switch pero más potente)
val gradoWhen = when (puntuacion) {
    in 90..100 -> "A"
    in 80..89 -> "B"
    in 70..79 -> "C"
    else -> "F"
}

// when con condiciones
val mensaje = when {
    puntuacion >= 90 -> "¡Excelente!"
    puntuacion >= 80 -> "Muy bien"
    puntuacion >= 70 -> "Bien"
    else -> "Necesitas mejorar"
}
```

### Bucles

**Java:**
```java
// for tradicional
for (int i = 0; i < 5; i++) {
    System.out.println(i);
}

// for-each
List<String> nombres = Arrays.asList("Ana", "Luis");
for (String nombre : nombres) {
    System.out.println(nombre);
}

// while
int i = 0;
while (i < 5) {
    System.out.println(i);
    i++;
}
```

**Kotlin:**
```kotlin
// for con rangos
for (i in 0..4) {  // Incluye 0 y 4
    println(i)
}

for (i in 0 until 5) {  // Incluye 0, excluye 5
    println(i)
}

for (i in 4 downTo 0) {  // De 4 a 0
    println(i)
}

for (i in 0..10 step 2) {  // 0, 2, 4, 6, 8, 10
    println(i)
}

// for con colecciones
val nombres = listOf("Ana", "Luis")
for (nombre in nombres) {
    println(nombre)
}

// for con índice
for ((index, nombre) in nombres.withIndex()) {
    println("$index: $nombre")
}

// while (igual que Java)
var i = 0
while (i < 5) {
    println(i)
    i++
}
```

## 9. Lambdas y Funciones de Alto Orden

**Java (Java 8+):**
```java
List<Integer> numeros = Arrays.asList(1, 2, 3, 4, 5);

// Lambda
List<Integer> pares = numeros.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());

// Method reference
numeros.forEach(System.out::println);
```

**Kotlin:**
```kotlin
val numeros = listOf(1, 2, 3, 4, 5)

// Lambdas
val pares = numeros.filter { it % 2 == 0 }  // 'it' es el parámetro implícito
val cuadrados = numeros.map { it * it }
val suma = numeros.reduce { acc, n -> acc + n }

// Función de alto orden personalizada
fun operacion(a: Int, b: Int, op: (Int, Int) -> Int): Int {
    return op(a, b)
}

fun main() {
    val resultado1 = operacion(5, 3) { x, y -> x + y }  // 8
    val resultado2 = operacion(5, 3) { x, y -> x * y }  // 15
    
    println(resultado1)
    println(resultado2)
}

// forEach
numeros.forEach { println(it) }

// Función que recibe lambda con receptor
fun String.procesar(accion: String.() -> String): String {
    return this.accion()
}

val texto = "hola mundo"
val resultado = texto.procesar { 
    this.uppercase().replace(" ", "_") 
} // "HOLA_MUNDO"
```

## 10. Manejo de Excepciones

**Java:**
```java
public void leerArchivo(String ruta) throws IOException {
    try {
        BufferedReader reader = new BufferedReader(new FileReader(ruta));
        String linea = reader.readLine();
        reader.close();
    } catch (IOException e) {
        System.err.println("Error al leer archivo: " + e.getMessage());
        throw e;
    } finally {
        System.out.println("Operación completada");
    }
}
```

**Kotlin:**
```kotlin
// No hay checked exceptions en Kotlin
fun leerArchivo(ruta: String) {
    try {
        val lineas = File(ruta).readLines()
        println(lineas.first())
    } catch (e: Exception) {
        println("Error al leer archivo: ${e.message}")
    } finally {
        println("Operación completada")
    }
}

// try como expresión
fun dividir(a: Int, b: Int): Int? {
    return try {
        a / b
    } catch (e: ArithmeticException) {
        null
    }
}

// runCatching (más idiomático)
fun dividirSeguro(a: Int, b: Int): Result<Int> {
    return runCatching { a / b }
}

fun main() {
    val resultado = dividirSeguro(10, 0)
    resultado.fold(
        onSuccess = { println("Resultado: $it") },
        onFailure = { println("Error: ${it.message}") }
    )
}
```

## 11. Enum Classes

**Java:**
```java
public enum Direccion {
    NORTE, SUR, ESTE, OESTE;
    
    public Direccion opuesta() {
        switch (this) {
            case NORTE: return SUR;
            case SUR: return NORTE;
            case ESTE: return OESTE;
            case OESTE: return ESTE;
            default: throw new IllegalArgumentException();
        }
    }
}
```

**Kotlin:**
```kotlin
enum class Direccion {
    NORTE, SUR, ESTE, OESTE;
    
    fun opuesta(): Direccion = when (this) {
        NORTE -> SUR
        SUR -> NORTE
        ESTE -> OESTE
        OESTE -> ESTE
    }
}

// Enum con propiedades y métodos
enum class Color(val rgb: Int) {
    ROJO(0xFF0000),
    VERDE(0x00FF00),
    AZUL(0x0000FF);
    
    fun esRojo(): Boolean = this == ROJO
}

fun main() {
    val color = Color.ROJO
    println("Color: $color, RGB: ${color.rgb.toString(16)}")
    println("¿Es rojo? ${color.esRojo()}")
}
```

## 12. Sealed Classes

Útiles para representar jerarquías cerradas de clases:

```kotlin
// Resultado de una operación
sealed class Resultado
data class Exito(val data: String) : Resultado()
data class Error(val mensaje: String) : Resultado()
object Cargando : Resultado()

fun manejarResultado(resultado: Resultado) = when (resultado) {
    is Exito -> println("Datos: ${resultado.data}")
    is Error -> println("Error: ${resultado.mensaje}")
    is Cargando -> println("Cargando...")
    // No necesitas 'else' porque el compilador sabe que son todos los casos
}

fun main() {
    val resultados = listOf(
        Exito("Datos cargados"),
        Error("No se encontró el archivo"),
        Cargando
    )
    
    resultados.forEach { manejarResultado(it) }
}
```

## 13. Object y Companion Object

### Object (Singleton)

**Java:**
```java
public class BaseDatos {
    private static BaseDatos instancia;
    
    private BaseDatos() {}
    
    public static BaseDatos getInstancia() {
        if (instancia == null) {
            instancia = new BaseDatos();
        }
        return instancia;
    }
    
    public void conectar() {
        System.out.println("Conectando a la base de datos...");
    }
}
```

**Kotlin:**
```kotlin
// Singleton automático
object BaseDatos {
    fun conectar() {
        println("Conectando a la base de datos...")
    }
}

fun main() {
    BaseDatos.conectar()  // Se usa directamente
}
```

### Companion Object

**Java:**
```java
public class MiClase {
    public static final String CONSTANTE = "valor";
    
    public static void metodoEstatico() {
        System.out.println("Método estático");
    }
}
```

**Kotlin:**
```kotlin
class MiClase {
    companion object {
        const val CONSTANTE = "valor"
        
        fun metodoEstatico() {
            println("Método estático")
        }
    }
}

fun main() {
    println(MiClase.CONSTANTE)
    MiClase.metodoEstatico()
}
```

## 14. Scope Functions

Kotlin proporciona funciones especiales para trabajar con objetos de manera más fluida:

```kotlin
data class Persona(var nombre: String, var edad: Int)

fun main() {
    val persona = Persona("Ana", 25)
    
    // let - útil para null safety
    val resultado = persona.let { p ->
        println("Procesando: ${p.nombre}")
        p.nombre.length
    }
    
    // apply - configurar objetos
    val persona2 = Persona("", 0).apply {
        nombre = "Luis"
        edad = 30
    }
    
    // run - ejecutar bloque de código
    val mensaje = persona.run {
        edad += 1
        "Nuevo mensaje para $nombre de $edad años"
    }
    
    // also - acciones adicionales
    val persona3 = persona.also { p ->
        println("Creando persona: ${p.nombre}")
    }
    
    // with - no es función de extensión
    val descripcion = with(persona) {
        "$nombre tiene $edad años"
    }
    
    println(mensaje)
    println(descripcion)
}
```

## 15. Interoperabilidad con Java

Kotlin es 100% interoperable con Java:

**Archivo Java (Utils.java):**
```java
public class Utils {
    public static String formatear(String texto) {
        return texto.toUpperCase();
    }
    
    public static void main(String[] args) {
        // Usar código Kotlin desde Java
        String resultado = KotlinFileKt.funcionKotlin("hola");
        System.out.println(resultado);
    }
}
```

**Archivo Kotlin (KotlinFile.kt):**
```kotlin
// Esta función será accesible desde Java como KotlinFileKt.funcionKotlin()
fun funcionKotlin(texto: String): String {
    return "Kotlin dice: $texto"
}

fun main() {
    // Usar código Java desde Kotlin
    val resultado = Utils.formatear("hola mundo")
    println(resultado) // HOLA MUNDO
}
```

## 16. Conceptos Específicos para Android

### Activity en Kotlin

```kotlin
class MainActivity : AppCompatActivity() {
    
    private lateinit var boton: Button  // lateinit para inicialización tardía
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        // findViewById con cast automático
        boton = findViewById(R.id.mi_boton)
        
        // Lambda como listener
        boton.setOnClickListener { 
            mostrarMensaje("¡Botón presionado!")
        }
    }
    
    private fun mostrarMensaje(mensaje: String) {
        Toast.makeText(this, mensaje, Toast.LENGTH_SHORT).show()
    }
}
```

### View Binding

```kotlin
class MainActivity : AppCompatActivity() {
    
    private lateinit var binding: ActivityMainBinding
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        
        // Acceso directo a las vistas
        binding.miBoton.setOnClickListener {
            binding.miTexto.text = "¡Hola desde Kotlin!"
        }
    }
}
```

## 17. Mejores Prácticas para Estudiantes

### 1. Usa val cuando sea posible
```kotlin
// Preferible
val nombre = "Juan"
val numeros = listOf(1, 2, 3)

// Solo usa var cuando necesites cambiar el valor
var contador = 0
contador++
```

### 2. Aprovecha la inferencia de tipos
```kotlin
// No necesitas especificar el tipo si es obvio
val nombre = "Juan"           // String inferido
val edad = 25                 // Int inferido
val precio = 19.99           // Double inferido

// Especifica el tipo solo cuando sea necesario
val numero: Long = 123       // Necesario porque por defecto sería Int
```

### 3. Usa funciones de extensión cuando tenga sentido
```kotlin
fun String.esPalindromo(): Boolean {
    val limpio = this.lowercase().filter { it.isLetter() }
    return limpio == limpio.reversed()
}
```

### 4. Prefiere immutabilidad
```kotlin
// Mejor
val lista = listOf("a", "b", "c")
val nuevaLista = lista + "d"

// Evita cuando sea posible
val listaMutable = mutableListOf("a", "b", "c")
listaMutable.add("d")
```

### 5. Usa null safety
```kotlin
fun procesarTexto(texto: String?): Int {
    return texto?.length ?: 0  // Manejo seguro de null
}
```

## 18. Ejercicios Prácticos

### Ejercicio 1: Convertir clase Java a Kotlin
Convierte esta clase Java a Kotlin:

```java
public class Estudiante {
    private String nombre;
    private int edad;
    private List<Double> calificaciones;
    
    public Estudiante(String nombre, int edad) {
        this.nombre = nombre;
        this.edad = edad;
        this.calificaciones = new ArrayList<>();
    }
    
    public double calcularPromedio() {
        return calificaciones.stream()
                .mapToDouble(Double::doubleValue)
                .average()
                .orElse(0.0);
    }
}
```

**Solución:**
```kotlin
data class Estudiante(
    val nombre: String,
    val edad: Int,
    val calificaciones: MutableList<Double> = mutableListOf()
) {
    fun calcularPromedio(): Double {
        return if (calificaciones.isEmpty()) 0.0 
               else calificaciones.average()
    }
}
```

### Ejercicio 2: Sistema de gestión simple
Crea un sistema que gestione una lista de productos:

```kotlin
data class Producto(val nombre: String, val precio: Double, val stock: Int)

class GestorProductos {
    private val productos = mutableListOf<Producto>()
    
    fun agregar(producto: Producto) {
        productos.add(producto)
    }
    
    fun buscarPorNombre(nombre: String): Producto? {
        return productos.find { it.nombre.equals(nombre, ignoreCase = true) }
    }
    
    fun productosBaratos(precioMaximo: Double): List<Producto> {
        return productos.filter { it.precio <= precioMaximo }
    }
    
    fun stockTotal(): Int {
        return productos.sumOf { it.stock }
    }
}
```

## Conclusión

Kotlin moderniza muchos aspectos del desarrollo Java eliminando código repetitivo y añadiendo características poderosas como:

- **Null safety**: Elimina NullPointerException en tiempo de compilación
- **Data classes**: Reducen drásticamente el boilerplate
- **Extension functions**: Permiten añadir funcionalidad a clases existentes
- **Smart casts**: El compilador maneja automáticamente los casting seguros
- **Lambdas y funciones de alto orden**: Programación funcional integrada
- **Coroutines**: Programación asíncrona simplificada (tema avanzado)

La transición de Java a Kotlin es gradual y natural. Puedes empezar usando Kotlin como "Java mejorado" e ir adoptando gradualmente sus características más avanzadas conforme te sientas cómodo con el lenguaje.

## Recursos Adicionales

- [Documentación oficial de Kotlin](https://kotlinlang.org/docs/)
- [Kotlin Playground](https://play.kotlinlang.org/) - Para practicar online
- [Android Kotlin Fundamentals](https://developer.android.com/courses/kotlin-android-fundamentals/overview)
- [Kotlin Koans](https://kotlinlang.org/docs/koans.html) - Ejercicios interactivos