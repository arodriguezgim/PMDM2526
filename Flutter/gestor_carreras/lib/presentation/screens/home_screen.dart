import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import '../../services/bluetooth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MyBluetoothService _bluetoothService = MyBluetoothService();
  String sensorData = "Esperando...";
  bool isScanning = false;
  bool isConnected = false;
  List<ScanResult> scanResults = [];
  List<StreamSubscription> subscriptions = [];
  final Map<int, bool> _lastSensorStates = {};
  final Map<int, DateTime> _lastSensorActivated = {};

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    await _bluetoothService.initBluetooth();
    _listenToScanResults();
  }

  void _listenToScanResults() {
    FlutterBluePlus.scanResults.listen(
      (results) {
        setState(() {
          scanResults = results;
        });
        for (final result in results) {
          final deviceName = result.device.name.isEmpty
              ? result.device.id.toString()
              : result.device.name;
          if (deviceName.contains('HMSoft')) {
            _connectToDevice(result.device);
            break;
          }
        }
      },
      onError: (error) {
        print("Error escaneando: $error");
      },
    );

    FlutterBluePlus.isScanning.listen((scanning) {
      setState(() {
        isScanning = scanning;
      });
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await _bluetoothService.connectToDevice(device);
      setState(() {
        isConnected = true;
      });
      _setupNotifications(device);
    } catch (e) {
      setState(() {
        isConnected = false;
      });
    }
  }

  void _setupNotifications(BluetoothDevice device) async {
    try {
      final services = await device.discoverServices();
      for (final service in services) {
        for (final characteristic in service.characteristics) {
          if (!characteristic.properties.notify) continue;
          await characteristic.setNotifyValue(true);
          final subscription = characteristic.onValueReceived.listen((value) {
            final sensorEvent = _bluetoothService.parseSensorEvent(value, _lastSensorStates, _lastSensorActivated);
            if (sensorEvent != null) {
              setState(() {
                sensorData = sensorEvent;
              });
              print(sensorEvent);
            }
          });
          subscriptions.add(subscription);
        }
      }
    } catch (e) {
      print("Error configurando notificaciones: $e");
    }
  }

  Future<void> _disconnectDevice() async {
    await _bluetoothService.disconnectDevice();
    setState(() {
      isConnected = false;
      sensorData = "Esperando...";
    });
  }

  @override
  void dispose() {
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
    subscriptions.clear();
    _bluetoothService.stopScan();
    _disconnectDevice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cuentavueltas - 4 Carriles')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Datos del sensor:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(
              sensorData,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isConnected ? Colors.green[100] : Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    isConnected ? 'Conectado' : 'Desconectado',
                    style: TextStyle(
                      fontSize: 18,
                      color: isConnected ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_bluetoothService.connectedDevice != null)
                    Text(
                      'Dispositivo: ${_bluetoothService.connectedDevice!.name}',
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (isScanning)
              const CircularProgressIndicator()
            else
              Text(
                'Dispositivos encontrados: ${scanResults.length}',
                style: const TextStyle(fontSize: 14),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isConnected ? _disconnectDevice : () => _bluetoothService.startScan(),
              child: Text(isConnected ? 'Desconectar' : 'Escanear'),
            ),
          ],
        ),
      ),
    );
  }
}