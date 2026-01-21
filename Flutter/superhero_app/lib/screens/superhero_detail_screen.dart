// 1. Importamos los paquetes necesarios
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository/repository.dart';

// 2. Cambiamos a StatefulWidget porque necesitamos cargar datos asincrónicos
class SuperheroDetailScreen extends StatefulWidget {
  // 3. Recibimos el superhéroe básico para obtener su ID
  final SuperHero superhero;

  // 4. Constructor que requiere el superhéroe como parámetro
  const SuperheroDetailScreen({super.key, required this.superhero});

  @override
  State<SuperheroDetailScreen> createState() => _SuperheroDetailScreenState();
}

class _SuperheroDetailScreenState extends State<SuperheroDetailScreen> {
  // 5. Declaramos variables para manejar el estado
  late Future<SuperHeroDetailResponse?> _superheroDetailFuture;
  final Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    // 6. Al iniciar, cargamos los detalles del superhéroe usando su ID
    _superheroDetailFuture = repository.getSuperHeroDetail(widget.superhero.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 7. AppBar con el nombre del superhéroe básico mientras carga
      appBar: AppBar(title: Text(widget.superhero.name)),
      // 8. FutureBuilder para manejar la carga asíncrona de datos
      body: FutureBuilder<SuperHeroDetailResponse?>(
        future: _superheroDetailFuture,
        builder: (context, snapshot) {
          // 9. Mostramos indicador de carga mientras esperamos la respuesta
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // 10. Manejamos el caso de error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Error al cargar los detalles del superhéroe'),
                ],
              ),
            );
          }

          // 11. Verificamos que tengamos datos
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No se encontraron detalles'));
          }

          // 12. Obtenemos el objeto con todos los detalles
          final superheroDetail = snapshot.data!;

          // 13. Construimos la UI con todos los detalles
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 14. Imagen del superhéroe con Hero animation
                Hero(
                  tag: 'superhero-${widget.superhero.id}',
                  child: CachedNetworkImage(
                    imageUrl: superheroDetail.image.url,
                    height: 400,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 400,
                      color: Colors.grey[300],
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 400,
                      color: Colors.grey[300],
                      child: Icon(Icons.error, size: 50),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 15. Nombre completo del superhéroe
                      Text(
                        superheroDetail.name,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),

                      // 16. Nombre real si existe
                      if (superheroDetail.biography.fullName.isNotEmpty)
                        Text(
                          'Nombre real: ${superheroDetail.biography.fullName}',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      SizedBox(height: 24),

                      // 17. Card con estadísticas de poder (Powerstats)
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estadísticas de Poder',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              _buildPowerStat(
                                context,
                                'Inteligencia',
                                superheroDetail.powerstats.intelligence,
                              ),
                              _buildPowerStat(
                                context,
                                'Fuerza',
                                superheroDetail.powerstats.strength,
                              ),
                              _buildPowerStat(
                                context,
                                'Velocidad',
                                superheroDetail.powerstats.speed,
                              ),
                              _buildPowerStat(
                                context,
                                'Durabilidad',
                                superheroDetail.powerstats.durability,
                              ),
                              _buildPowerStat(
                                context,
                                'Poder',
                                superheroDetail.powerstats.power,
                              ),
                              _buildPowerStat(
                                context,
                                'Combate',
                                superheroDetail.powerstats.combat,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // 18. Card con biografía
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Biografía',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              _buildDetailRow(
                                context,
                                icon: Icons.face,
                                label: 'Alter Egos',
                                value: superheroDetail.biography.alterEgos,
                              ),
                              Divider(),
                              _buildDetailRow(
                                context,
                                icon: Icons.location_city,
                                label: 'Lugar de nacimiento',
                                value: superheroDetail.biography.placeOfBirth,
                              ),
                              Divider(),
                              _buildDetailRow(
                                context,
                                icon: Icons.calendar_today,
                                label: 'Primera aparición',
                                value:
                                    superheroDetail.biography.firstAppearance,
                              ),
                              Divider(),
                              _buildDetailRow(
                                context,
                                icon: Icons.people,
                                label: 'Afiliaciones',
                                value: superheroDetail
                                    .connections
                                    .groupAffiliation,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // 19. Card con apariencia física
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apariencia',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 12),
                              _buildDetailRow(
                                context,
                                icon: Icons.accessibility,
                                label: 'Género',
                                value: superheroDetail.appearance.gender,
                              ),
                              Divider(),
                              _buildDetailRow(
                                context,
                                icon: Icons.height,
                                label: 'Altura',
                                value: superheroDetail.appearance.height.join(
                                  ', ',
                                ),
                              ),
                              Divider(),
                              _buildDetailRow(
                                context,
                                icon: Icons.monitor_weight,
                                label: 'Peso',
                                value: superheroDetail.appearance.weight.join(
                                  ', ',
                                ),
                              ),
                              Divider(),
                              _buildDetailRow(
                                context,
                                icon: Icons.color_lens,
                                label: 'Color de ojos',
                                value: superheroDetail.appearance.eyeColor,
                              ),
                              Divider(),
                              _buildDetailRow(
                                context,
                                icon: Icons.face_retouching_natural,
                                label: 'Color de pelo',
                                value: superheroDetail.appearance.hairColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 20. Widget para mostrar estadísticas con barra de progreso
  Widget _buildPowerStat(BuildContext context, String label, String value) {
    // 21. Convertimos el valor a número, si es "null" usamos 0
    final numValue = int.tryParse(value) ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
              Text(value, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          SizedBox(height: 4),
          // 22. Barra de progreso visual para la estadística
          LinearProgressIndicator(
            value: numValue / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              numValue > 70
                  ? Colors.green
                  : numValue > 40
                  ? Colors.orange
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // 23. Widget auxiliar reutilizado del código anterior
  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
