import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

/// Servicio para manejar la lógica de Bluetooth BLE.
/// Proporciona métodos para inicializar Bluetooth, escanear dispositivos,
/// conectar, desconectar y parsear datos de sensores.
class MyBluetoothService {
  BluetoothDevice? connectedDevice;
  List<StreamSubscription> subscriptions = [];
  bool servicesDiscovered = false;

  /// Inicializa Bluetooth y comienza el escaneo si está disponible.
  /// Verifica si Bluetooth está disponible y lanza el escaneo.
  Future<void> initBluetooth() async {
    try {
      if (await FlutterBluePlus.isAvailable == false) {
        print("Bluetooth no disponible en este dispositivo");
        return;
      }
      await startScan();
    } catch (e) {
      print("Error inicializando Bluetooth: $e");
    }
  }

  /// Inicia el escaneo de dispositivos BLE por 10 segundos.
  /// Escucha resultados y busca específicamente dispositivos con 'HMSoft' en el nombre.
  Future<void> startScan() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    } catch (e) {
      print("Error iniciando escaneo: $e");
    }
  }

  /// Conecta a un dispositivo BLE específico.
  /// Establece la conexión y marca como conectado.
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(
        timeout: const Duration(seconds: 10),
        license: License.free,
      );
      connectedDevice = device;
      servicesDiscovered = false;
      await discoverServices(device);
    } catch (e) {
      print("Error al conectar: $e");
      rethrow;
    }
  }

  /// Descubre servicios y características del dispositivo conectado.
  /// Habilita notificaciones para características que las soportan.
  Future<void> discoverServices(BluetoothDevice device) async {
    if (servicesDiscovered) return;

    try {
      final services = await device.discoverServices();
      for (final service in services) {
        for (final characteristic in service.characteristics) {
          if (!characteristic.properties.notify) continue;
          try {
            await characteristic.setNotifyValue(true);
            // Nota: Las subscripciones se manejan en el screen para actualizar UI
          } catch (e) {
            print("Error habilitando notificaciones: $e");
          }
        }
      }
      servicesDiscovered = true;
    } catch (e) {
      print("Error descubriendo servicios: $e");
    }
  }

  /// Parsea los datos recibidos del sensor en eventos legibles.
  /// Maneja estados de sensores con cooldown para evitar duplicados.
  String? parseSensorEvent(List<int> value, Map<int, bool> lastSensorStates, Map<int, DateTime> lastSensorActivated) {
    final raw = String.fromCharCodes(value).trim();
    if (raw.isEmpty) return null;

    final normalized = raw.replaceAll(RegExp(r'[^01,; ]'), '');
    final tokens = normalized
        .split(RegExp(r'[,; ]+'))
        .where((token) => token.isNotEmpty)
        .toList();

    List<String>? bits;
    if (tokens.length == 4 && tokens.every((token) => token == '0' || token == '1')) {
      bits = tokens;
    } else if (RegExp(r'^[01]{4}$').hasMatch(raw)) {
      bits = raw.split('');
    }

    if (bits != null) {
      final events = <String>[];
      final now = DateTime.now();
      for (var i = 0; i < bits.length; i++) {
        final current = bits[i] == '1';
        final previous = lastSensorStates[i] ?? false;
        final lastActivated = lastSensorActivated[i];
        final cooldownPassed = lastActivated == null || now.difference(lastActivated) >= const Duration(seconds: 2);

        if (current && !previous && cooldownPassed) {
          events.add('Paso sensor ${i + 1}');
          lastSensorActivated[i] = now;
        }
        lastSensorStates[i] = current;
      }
      if (events.isNotEmpty) return events.join(' | ');
      return null;
    }

    return 'Sensor: $raw';
  }

  /// Desconecta del dispositivo conectado y limpia subscripciones.
  Future<void> disconnectDevice() async {
    try {
      for (var subscription in subscriptions) {
        subscription.cancel();
      }
      subscriptions.clear();
      if (connectedDevice != null) {
        await connectedDevice!.disconnect();
        connectedDevice = null;
        servicesDiscovered = false;
        print("Desconectado");
      }
    } catch (e) {
      print("Error desconectando: $e");
    }
  }

  /// Detiene el escaneo de Bluetooth.
  void stopScan() {
    FlutterBluePlus.stopScan();
  }
}