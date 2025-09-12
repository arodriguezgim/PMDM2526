# Manual de Kotlin para Programadores Java

## Introducción

Kotlin es un lenguaje de programación moderno, totalmente interoperable con Java, que simplifica muchos aspectos del desarrollo. Si ya conoces Java, aprender Kotlin será más sencillo, ya que ambos se ejecutan en la JVM y comparten muchos conceptos fundamentales.

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

## 19. Corrutinas (Programación Asíncrona)

Las corrutinas son una característica avanzada de Kotlin que simplifica la programación asíncrona:

### Conceptos Básicos

**Java (usando Thread):**
```java
// Operación en hilo separado
new Thread(() -> {
    try {
        Thread.sleep(1000);
        System.out.println("Operación completada");
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
}).start();
```

**Kotlin (con corrutinas):**
```kotlin
import kotlinx.coroutines.*

fun main() = runBlocking {
    launch {
        delay(1000L)  // No bloquea el hilo
        println("Operación completada")
    }
    println("Hola")
}
```

### Suspend Functions

```kotlin
suspend fun operacionLenta(): String {
    delay(2000)  // Simula operación lenta
    return "Datos cargados"
}

suspend fun otraOperacion(): String {
    delay(1000)
    return "Otra operación completada"
}

fun main() = runBlocking {
    // Ejecutar secuencialmente
    val tiempo1 = System.currentTimeMillis()
    val resultado1 = operacionLenta()
    val resultado2 = otraOperacion()
    println("Secuencial: ${System.currentTimeMillis() - tiempo1}ms")
    
    // Ejecutar concurrentemente
    val tiempo2 = System.currentTimeMillis()
    val deferred1 = async { operacionLenta() }
    val deferred2 = async { otraOperacion() }
    
    val resultadoA = deferred1.await()
    val resultadoB = deferred2.await()
    println("Concurrente: ${System.currentTimeMillis() - tiempo2}ms")
}
```

### Corrutinas en Android

```kotlin
class MainActivity : AppCompatActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Corrutina que se ejecuta en el ciclo de vida de la Activity
        lifecycleScope.launch {
            try {
                binding.progressBar.visibility = View.VISIBLE
                
                // Operación en hilo de fondo
                val datos = withContext(Dispatchers.IO) {
                    // Simular llamada a API
                    delay(2000)
                    "Datos de la API"
                }
                
                // Actualizar UI en hilo principal
                binding.texto.text = datos
                
            } catch (e: Exception) {
                binding.texto.text = "Error: ${e.message}"
            } finally {
                binding.progressBar.visibility = View.GONE
            }
        }
    }
}
```

## 20. Programación Funcional en Kotlin

Kotlin soporta paradigmas de programación funcional:

### Funciones de Alto Orden Avanzadas

```kotlin
// Función que devuelve función
fun crearMultiplicador(factor: Int): (Int) -> Int {
    return { numero -> numero * factor }
}

// Función que recibe función como parámetro
fun aplicarOperacion(numeros: List<Int>, operacion: (Int) -> Int): List<Int> {
    return numeros.map(operacion)
}

fun main() {
    val numeros = listOf(1, 2, 3, 4, 5)
    
    val multiplicarPor3 = crearMultiplicador(3)
    val resultado = aplicarOperacion(numeros, multiplicarPor3)
    println(resultado) // [3, 6, 9, 12, 15]
    
    // También con lambda directamente
    val cuadrados = aplicarOperacion(numeros) { it * it }
    println(cuadrados) // [1, 4, 9, 16, 25]
}
```

### Operaciones Funcionales Útiles

```kotlin
data class Empleado(val nombre: String, val edad: Int, val salario: Double, val departamento: String)

fun main() {
    val empleados = listOf(
        Empleado("Ana", 28, 50000.0, "IT"),
        Empleado("Luis", 35, 60000.0, "IT"),
        Empleado("María", 32, 55000.0, "HR"),
        Empleado("Carlos", 29, 52000.0, "IT"),
        Empleado("Laura", 41, 70000.0, "HR")
    )
    
    // Filtrar empleados de IT
    val empleadosIT = empleados.filter { it.departamento == "IT" }
    
    // Mapear a solo nombres
    val nombres = empleados.map { it.nombre }
    
    // Encontrar empleado con mayor salario
    val mejorPagado = empleados.maxByOrNull { it.salario }
    
    // Agrupar por departamento
    val porDepartamento = empleados.groupBy { it.departamento }
    
    // Calcular salario promedio
    val salarioPromedio = empleados.map { it.salario }.average()
    
    // Reducir - salario total
    val salarioTotal = empleados.map { it.salario }.reduce { acc, salario -> acc + salario }
    
    // Fold - con valor inicial
    val salarioTotalConBonus = empleados.fold(10000.0) { acc, empleado -> acc + empleado.salario }
    
    // Operaciones encadenadas
    val resultado = empleados
        .filter { it.edad < 35 }
        .filter { it.departamento == "IT" }
        .map { it.nombre }
        .sorted()
    
    println("Empleados IT jóvenes: $resultado")
    println("Mejor pagado: ${mejorPagado?.nombre}")
    println("Salario promedio: $salarioPromedio")
}
```

### Secuencias (Lazy Evaluation)

```kotlin
fun main() {
    val numeros = (1..1_000_000).asSequence()
        .filter { it % 2 == 0 }
        .map { it * 2 }
        .take(10)
        .toList()  // Solo aquí se ejecutan las operaciones
    
    println(numeros) // [4, 8, 12, 16, 20, 24, 28, 32, 36, 40]
}
```

## 21. Generics

### Generics Básicos

**Java:**
```java
public class Caja<T> {
    private T contenido;
    
    public void poner(T item) {
        this.contenido = item;
    }
    
    public T obtener() {
        return contenido;
    }
}
```

**Kotlin:**
```kotlin
class Caja<T> {
    private var contenido: T? = null
    
    fun poner(item: T) {
        contenido = item
    }
    
    fun obtener(): T? = contenido
}

fun main() {
    val cajaString = Caja<String>()
    cajaString.poner("Hola")
    println(cajaString.obtener())
    
    val cajaInt = Caja<Int>()
    cajaInt.poner(42)
    println(cajaInt.obtener())
}
```

### Varianza (in/out)

```kotlin
// Covarianza (out) - solo puede producir T, no consumir
interface Productor<out T> {
    fun producir(): T
}

// Contravarianza (in) - solo puede consumir T, no producir
interface Consumidor<in T> {
    fun consumir(item: T)
}

// Ejemplo práctico
class ListaProductor<T>(private val lista: List<T>) : Productor<T> {
    override fun producir(): T = lista.random()
}

class ListaConsumidor<T>(private val lista: MutableList<T>) : Consumidor<T> {
    override fun consumir(item: T) {
        lista.add(item)
    }
}

fun main() {
    // Gracias a la covarianza, esto es válido
    val productorString: Productor<String> = ListaProductor(listOf("a", "b"))
    val productorAny: Productor<Any> = productorString  // String es subtipo de Any
    
    // Gracias a la contravarianza, esto es válido
    val consumidorAny: Consumidor<Any> = ListaConsumidor(mutableListOf<Any>())
    val consumidorString: Consumidor<String> = consumidorAny  // Puede consumir String
}
```

### Reified Generics

```kotlin
// Problema en Java: no puedes acceder al tipo T en runtime
inline fun <reified T> esInstanciaDe(obj: Any): Boolean {
    return obj is T  // Solo funciona con reified
}

inline fun <reified T> crearLista(): List<T> {
    return when (T::class) {
        String::class -> listOf("a", "b", "c") as List<T>
        Int::class -> listOf(1, 2, 3) as List<T>
        else -> emptyList()
    }
}

fun main() {
    println(esInstanciaDe<String>("Hola"))  // true
    println(esInstanciaDe<Int>("Hola"))     // false
    
    val strings: List<String> = crearLista()
    val ints: List<Int> = crearLista()
}
```

## 22. Delegación

### Delegación de Clases

```kotlin
interface Volador {
    fun volar()
}

interface Nadador {
    fun nadar()
}

class Pajaro : Volador {
    override fun volar() = println("Volando con alas")
}

class Pez : Nadador {
    override fun nadar() = println("Nadando con aletas")
}

// Delegación - SuperAnimal delega comportamientos
class SuperAnimal(
    volador: Volador,
    nadador: Nadador
) : Volador by volador, Nadador by nadador {
    
    fun hacerTodo() {
        volar()
        nadar()
    }
}

fun main() {
    val superAnimal = SuperAnimal(Pajaro(), Pez())
    superAnimal.hacerTodo()
}
```

### Delegación de Propiedades

```kotlin
import kotlin.properties.Delegates

class Usuario {
    // Lazy initialization
    val datosCompletos: String by lazy {
        println("Calculando datos completos...")
        "Datos muy complejos de calcular"
    }
    
    // Observable
    var nombre: String by Delegates.observable("inicial") { property, oldValue, newValue ->
        println("$oldValue -> $newValue")
    }
    
    // Veto - no permite cambios inválidos
    var edad: Int by Delegates.vetoable(0) { property, oldValue, newValue ->
        newValue >= 0  // Solo permite edades positivas
    }
    
    // Map delegate
    val propiedades = mutableMapOf<String, Any>()
    var email: String by propiedades
    var telefono: String by propiedades
}

fun main() {
    val usuario = Usuario()
    
    // Solo se calcula la primera vez que se accede
    println(usuario.datosCompletos)
    println(usuario.datosCompletos)  // No se recalcula
    
    // Observable
    usuario.nombre = "Ana"    // inicial -> Ana
    usuario.nombre = "Luis"   // Ana -> Luis
    
    // Vetoable
    usuario.edad = 25         // OK
    usuario.edad = -5         // Se rechaza, mantiene 25
    println("Edad: ${usuario.edad}")
    
    // Map delegate
    usuario.email = "ana@email.com"
    usuario.telefono = "123456789"
    println(usuario.propiedades)  // {email=ana@email.com, telefono=123456789}
}
```

### Custom Property Delegate

```kotlin
import kotlin.reflect.KProperty

class LoggedProperty<T>(initialValue: T) {
    private var value = initialValue
    
    operator fun getValue(thisRef: Any?, property: KProperty<*>): T {
        println("Leyendo propiedad ${property.name}: $value")
        return value
    }
    
    operator fun setValue(thisRef: Any?, property: KProperty<*>, value: T) {
        println("Escribiendo propiedad ${property.name}: $value")
        this.value = value
    }
}

class Ejemplo {
    var propiedad: String by LoggedProperty("inicial")
}

fun main() {
    val ejemplo = Ejemplo()
    println(ejemplo.propiedad)  // Log: Leyendo...
    ejemplo.propiedad = "nuevo" // Log: Escribiendo...
    println(ejemplo.propiedad)  // Log: Leyendo...
}
```

## 23. DSL (Domain Specific Language)

Kotlin permite crear DSLs elegantes:

```kotlin
// HTML DSL
class HTML {
    private val content = StringBuilder()
    
    fun head(block: Head.() -> Unit) {
        content.append("<head>")
        Head().block()
        content.append("</head>")
    }
    
    fun body(block: Body.() -> Unit) {
        content.append("<body>")
        val body = Body()
        body.block()
        content.append(body.content)
        content.append("</body>")
    }
    
    override fun toString() = "<html>$content</html>"
}

class Head {
    fun title(text: String) {
        // Agregar título
    }
}

class Body {
    val content = StringBuilder()
    
    fun h1(text: String) {
        content.append("<h1>$text</h1>")
    }
    
    fun p(text: String) {
        content.append("<p>$text</p>")
    }
    
    fun div(cssClass: String = "", block: Body.() -> Unit) {
        content.append("<div class='$cssClass'>")
        val div = Body()
        div.block()
        content.append(div.content)
        content.append("</div>")
    }
}

fun html(block: HTML.() -> Unit): HTML {
    val html = HTML()
    html.block()
    return html
}

fun main() {
    val webpage = html {
        head {
            title("Mi Página")
        }
        body {
            h1("Bienvenido")
            p("Este es un párrafo creado con DSL")
            div("container") {
                p("Contenido dentro del div")
            }
        }
    }
    
    println(webpage)
}
```

## 24. Testing en Kotlin

### Unit Tests Básicos

```kotlin
import org.junit.Test
import org.junit.Assert.*

class CalculadoraTest {
    
    private val calculadora = Calculadora()
    
    @Test
    fun `suma dos números positivos`() {
        val resultado = calculadora.sumar(2, 3)
        assertEquals(5, resultado)
    }
    
    @Test
    fun `división por cero lanza excepción`() {
        assertThrows(ArithmeticException::class.java) {
            calculadora.dividir(10, 0)
        }
    }
    
    @Test
    fun `lista contiene elementos esperados`() {
        val lista = listOf("a", "b", "c")
        assertThat(lista, hasItems("a", "c"))
        assertThat(lista.size, `is`(3))
    }
}
```

### Mocking con MockK

```kotlin
import io.mockk.*
import org.junit.Test
import org.junit.Assert.*

interface RepositorioUsuario {
    fun obtenerUsuario(id: Int): Usuario?
    fun guardarUsuario(usuario: Usuario)
}

class ServicioUsuario(private val repositorio: RepositorioUsuario) {
    fun procesarUsuario(id: Int): String {
        val usuario = repositorio.obtenerUsuario(id)
        return usuario?.let { "Usuario: ${it.nombre}" } ?: "Usuario no encontrado"
    }
}

class ServicioUsuarioTest {
    
    @Test
    fun `procesar usuario existente`() {
        // Arrange
        val mockRepo = mockk<RepositorioUsuario>()
        val usuario = Usuario("Ana", 25)
        every { mockRepo.obtenerUsuario(1) } returns usuario
        
        val servicio = ServicioUsuario(mockRepo)
        
        // Act
        val resultado = servicio.procesarUsuario(1)
        
        // Assert
        assertEquals("Usuario: Ana", resultado)
        verify { mockRepo.obtenerUsuario(1) }
    }
    
    @Test
    fun `procesar usuario inexistente`() {
        val mockRepo = mockk<RepositorioUsuario>()
        every { mockRepo.obtenerUsuario(999) } returns null
        
        val servicio = ServicioUsuario(mockRepo)
        val resultado = servicio.procesarUsuario(999)
        
        assertEquals("Usuario no encontrado", resultado)
    }
}
```

## 25. Arquitectura y Patrones en Android

### MVVM con Kotlin

```kotlin
// Model
data class Usuario(val id: Int, val nombre: String, val email: String)

// Repository
class UsuarioRepository {
    suspend fun obtenerUsuarios(): List<Usuario> {
        // Simular llamada a API
        delay(1000)
        return listOf(
            Usuario(1, "Ana", "ana@email.com"),
            Usuario(2, "Luis", "luis@email.com")
        )
    }
}

// ViewModel
class UsuarioViewModel : ViewModel() {
    private val repository = UsuarioRepository()
    
    private val _usuarios = MutableLiveData<List<Usuario>>()
    val usuarios: LiveData<List<Usuario>> = _usuarios
    
    private val _loading = MutableLiveData<Boolean>()
    val loading: LiveData<Boolean> = _loading
    
    fun cargarUsuarios() {
        viewModelScope.launch {
            _loading.value = true
            try {
                val usuarios = repository.obtenerUsuarios()
                _usuarios.value = usuarios
            } catch (e: Exception) {
                // Manejar error
            } finally {
                _loading.value = false
            }
        }
    }
}

// View (Activity/Fragment)
class MainActivity : AppCompatActivity() {
    private lateinit var viewModel: UsuarioViewModel
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        viewModel = ViewModelProvider(this)[UsuarioViewModel::class.java]
        
        viewModel.usuarios.observe(this) { usuarios ->
            // Actualizar UI con la lista de usuarios
            actualizarLista(usuarios)
        }
        
        viewModel.loading.observe(this) { loading ->
            binding.progressBar.visibility = if (loading) View.VISIBLE else View.GONE
        }
        
        viewModel.cargarUsuarios()
    }
    
    private fun actualizarLista(usuarios: List<Usuario>) {
        // Actualizar RecyclerView, etc.
    }
}
```

### Repository Pattern

```kotlin
// Interface del repository
interface UsuarioRepository {
    suspend fun obtenerUsuarios(): Result<List<Usuario>>
    suspend fun obtenerUsuario(id: Int): Result<Usuario>
    suspend fun crearUsuario(usuario: Usuario): Result<Usuario>
}

// Implementación
class UsuarioRepositoryImpl(
    private val apiService: UsuarioApiService,
    private val dao: UsuarioDao
) : UsuarioRepository {
    
    override suspend fun obtenerUsuarios(): Result<List<Usuario>> {
        return try {
            // Primero intentar desde la API
            val usuarios = apiService.obtenerUsuarios()
            
            // Guardar en cache local
            dao.insertarTodos(usuarios)
            
            Result.success(usuarios)
        } catch (e: Exception) {
            // Si falla la API, usar cache
            try {
                val usuariosCache = dao.obtenerTodos()
                Result.success(usuariosCache)
            } catch (cacheError: Exception) {
                Result.failure(e)
            }
        }
    }
    
    override suspend fun obtenerUsuario(id: Int): Result<Usuario> {
        return runCatching {
            val usuario = dao.obtenerPorId(id) 
                ?: apiService.obtenerUsuario(id).also { dao.insertar(it) }
            usuario
        }
    }
    
    override suspend fun crearUsuario(usuario: Usuario): Result<Usuario> {
        return runCatching {
            val nuevoUsuario = apiService.crearUsuario(usuario)
            dao.insertar(nuevoUsuario)
            nuevoUsuario
        }
    }
}
```

## 26. Mejores Prácticas Avanzadas

### 1. Manejo de Errores con Result y runCatching

```kotlin
sealed class ApiResult<T> {
    data class Success<T>(val data: T) : ApiResult<T>()
    data class Error<T>(val exception: Throwable) : ApiResult<T>()
    data class Loading<T>(val message: String = "Cargando...") : ApiResult<T>()
}

class ApiService {
    suspend fun obtenerDatos(): ApiResult<String> {
        return try {
            ApiResult.Loading("Obteniendo datos...")
            delay(1000)
            // Simular posible error
            if (Math.random() < 0.3) throw Exception("Error de red")
            ApiResult.Success("Datos obtenidos exitosamente")
        } catch (e: Exception) {
            ApiResult.Error(e)
        }
    }
}

// Uso
class ViewModel {
    fun cargarDatos() {
        viewModelScope.launch {
            when (val resultado = apiService.obtenerDatos()) {
                is ApiResult.Loading -> mostrarCarga()
                is ApiResult.Success -> mostrarDatos(resultado.data)
                is ApiResult.Error -> mostrarError(resultado.exception.message)
            }
        }
    }
}
```

### 2. Builders con DSL

```kotlin
class ConfiguracionApp {
    var tema: String = "claro"
    var idioma: String = "es"
    var notificacionesActivas: Boolean = true
    var nivelLog: String = "INFO"
    
    fun base(block: ConfiguracionBase.() -> Unit) {
        ConfiguracionBase().apply(block)
    }
    
    class ConfiguracionBase {
        fun configurarCache(tamaño: Int, duracion: Long) {
            // Configurar cache
        }
        
        fun configurarRed(timeout: Long, reintentos: Int) {
            // Configurar red
        }
    }
}

fun configurarApp(block: ConfiguracionApp.() -> Unit): ConfiguracionApp {
    return ConfiguracionApp().apply(block)
}

// Uso
val config = configurarApp {
    tema = "oscuro"
    idioma = "en"
    notificacionesActivas = false
    
    base {
        configurarCache(tamaño = 50, duracion = 3600)
        configurarRed(timeout = 30000, reintentos = 3)
    }
}
```

### 3. Extension Functions para Android

```kotlin
// Extensions útiles para Android
fun Context.mostrarToast(mensaje: String, duracion: Int = Toast.LENGTH_SHORT) {
    Toast.makeText(this, mensaje, duracion).show()
}

fun View.visible() {
    visibility = View.VISIBLE
}

fun View.invisible() {
    visibility = View.INVISIBLE
}

fun View.gone() {
    visibility = View.GONE
}

fun EditText.textoLimpio(): String {
    return text.toString().trim()
}

fun Fragment.hideKeyboard() {
    view?.let { activity?.hideKeyboard(it) }
}

fun Activity.hideKeyboard(view: View) {
    val inputMethodManager = getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
    inputMethodManager.hideSoftInputFromWindow(view.windowToken, 0)
}

// Uso en Activity/Fragment
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        binding.boton.setOnClickListener {
            val texto = binding.editText.textoLimpio()
            if (texto.isNotEmpty()) {
                mostrarToast("Texto ingresado: $texto")
                binding.progressBar.visible()
                hideKeyboard(it)
            }
        }
    }
}
```

## 27. Ejercicios Finales Integradores

### Ejercicio 1: Sistema de Biblioteca

```kotlin
data class Libro(
    val isbn: String,
    val titulo: String,
    val autor: String,
    val disponible: Boolean = true
)

data class Usuario(
    val id: Int,
    val nombre: String,
    val email: String,
    val librosPrestados: MutableList<String> = mutableListOf()
)

class Biblioteca {
    private val libros = mutableMapOf<String, Libro>()
    private val usuarios = mutableMapOf<Int, Usuario>()
    
    fun agregarLibro(libro: Libro) {
        libros[libro.isbn] = libro
    }
    
    fun registrarUsuario(usuario: Usuario) {
        usuarios[usuario.id] = usuario
    }
    
    fun prestarLibro(userId: Int, isbn: String): Result<String> {
        return runCatching {
            val usuario = usuarios[userId] ?: throw Exception("Usuario no encontrado")
            val libro = libros[isbn] ?: throw Exception("Libro no encontrado")
            
            if (!libro.disponible) throw Exception("Libro no disponible")
            if (usuario.librosPrestados.size >= 3) throw Exception("Límite de libros alcanzado")
            
            libros[isbn] = libro.copy(disponible = false)
            usuario.librosPrestados.add(isbn)
            
            "Libro '${libro.titulo}' prestado exitosamente a ${usuario.nombre}"
        }
    }
    
    fun devolverLibro(userId: Int, isbn: String): Result<String> {
        return runCatching {
            val usuario = usuarios[userId] ?: throw Exception("Usuario no encontrado")
            val libro = libros[isbn] ?: throw Exception("Libro no encontrado")
            
            if (!usuario.librosPrestados.contains(isbn)) {
                throw Exception("El usuario no tiene prestado este libro")
            }
            
            libros[isbn] = libro.copy(disponible = true)
            usuario.librosPrestados.remove(isbn)
            
            "Libro '${libro.titulo}' devuelto exitosamente"
        }
    }
    
    fun buscarLibros(criterio: (Libro) -> Boolean): List<Libro> {
        return libros.values.filter(criterio)
    }
}

// Uso
fun main() {
    val biblioteca = Biblioteca()
    
    // Agregar libros
    biblioteca.agregarLibro(Libro("123", "Kotlin en Acción", "Dmitry Jemerov"))
    biblioteca.agregarLibro(Libro("456", "Clean Code", "Robert Martin"))
    
    // Registrar usuario
    biblioteca.registrarUsuario(Usuario(1, "Ana García", "ana@email.com"))
    
    // Prestar libro
    biblioteca.prestarLibro(1, "123").fold(
        onSuccess = { println(it) },
        onFailure = { println("Error: ${it.message}") }
    )
    
    // Buscar libros disponibles
    val disponibles = biblioteca.buscarLibros { it.disponible }
    println("Libros disponibles: ${disponibles.map { it.titulo }}")
}
```

### Ejercicio 2: Sistema de Tareas con DSL

```kotlin
enum class Prioridad { BAJA, MEDIA, ALTA, CRITICA }
enum class Estado { PENDIENTE, EN_PROGRESO, COMPLETADA }

data class Tarea(
    val id: Int,
    val titulo: String,
    val descripcion: String,
    val prioridad: Prioridad,
    var estado: Estado = Estado.PENDIENTE,
    val fechaCreacion: Long = System.currentTimeMillis()
)

class GestorTareas {
    private val tareas = mutableListOf<Tarea>()
    private var siguienteId = 1
    
    fun crear(titulo: String, block: TareaBuilder.() -> Unit): Tarea {
        val builder = TareaBuilder(siguienteId++, titulo)
        builder.block()
        val tarea = builder.build()
        tareas.add(tarea)
        return tarea
    }
    
    fun filtrar(criterio: (Tarea) -> Boolean): List<Tarea> {
        return tareas.filter(criterio)
    }
    
    fun ordenarPor(selector: (Tarea) -> Comparable<*>): List<Tarea> {
        return tareas.sortedBy(selector)
    }
}

class TareaBuilder(private val id: Int, private val titulo: String) {
    var descripcion: String = ""
    var prioridad: Prioridad = Prioridad.MEDIA
    
    fun build() = Tarea(id, titulo, descripcion, prioridad)
}

// DSL para consultas
class ConsultaTareas(private val gestor: GestorTareas) {
    infix fun con(prioridad: Prioridad): List<Tarea> {
        return gestor.filtrar { it.prioridad == prioridad }
    }
    
    infix fun en(estado: Estado): List<Tarea> {
        return gestor.filtrar { it.estado == estado }
    }
    
    fun completadas(): List<Tarea> = gestor.filtrar { it.estado == Estado.COMPLETADA }
    fun pendientes(): List<Tarea> = gestor.filtrar { it.estado == Estado.PENDIENTE }
}

// Extensions
val GestorTareas.consultar: ConsultaTareas
    get() = ConsultaTareas(this)

// Uso
fun main() {
    val gestor = GestorTareas()
    
    // Crear tareas con DSL
    gestor.crear("Implementar login") {
        descripcion = "Crear pantalla de login con validaciones"
        prioridad = Prioridad.ALTA
    }
    
    gestor.crear("Escribir tests") {
        descripcion = "Tests unitarios para el módulo de usuarios"
        prioridad = Prioridad.MEDIA