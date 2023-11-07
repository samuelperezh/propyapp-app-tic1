import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class PredictionData {
  int area;
  int rooms;
  int garages;
  String stratum;
  String propertyType;
  int baths;
  String neighbourhood;
  String city;

  PredictionData({
    required this.area,
    required this.rooms,
    required this.garages,
    required this.stratum,
    required this.propertyType,
    required this.baths,
    required this.neighbourhood,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
    'area': area,
    'rooms': rooms,
    'garages': garages,
    'stratum': stratum,
    'property_type': propertyType,
    'baths': baths,
    'neighbourhood': neighbourhood,
    'city': city,
  };
}

class PredictionResult {
  double price;

  PredictionResult({required this.price});

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(price: json['price']);
  }
}

class Api {
  static const String baseUrl = 'http://51.222.207.66:8000/predecir';

  static Future<PredictionResult> predict(PredictionData data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      return PredictionResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to predict price');
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> stratumOptions = ['Campestre', 'Estrato 0', 'Estrato 1', 'Estrato 2', 'Estrato 3', 'Estrato 4', 'Estrato 5', 'Estrato 6'];
  final List<String> propertyTypeOptions = ['Apartaestudio', 'Apartamento', 'Casa'];
  final List<String> neighbourhoodOptions = ['Calasanz', 'Los Colores', 'Laureles', 'San Diego', 'Boston', 'San Antonio de Prado', 'Los balsos no.2', 'San Lucas', 'Belén San Bernardo', 'El Poblado', 'La América', 'Conquistadores', 'Robledo', 'Centro administrativo', 'La Castellana', 'Centro', 'Loma del Indio', 'Estadio', 'Loma de los Bernal', 'Rodeo Alto', 'Simon bolivar', 'Santa Mónica', 'Los Balsos', 'Las Palmas', 'Aranjuez', 'La Candelaria', 'El Tesoro', 'Buenos Aires', 'El Campestre', 'Patio Bonito', 'Velodromo', 'Belén', 'La aguacatala', 'Guayabal', 'Belén Rosales', 'La Mota', 'La Pilarica', 'POBLADO', 'Loma de los Gonzalez', 'Castropol', 'La florida', 'Santa maria de los angeles', 'Ciudad del Río', 'Altos del poblado', 'San german', 'Urbanizacion doña maria robledo', 'San Javier', 'Urbanizacion vegas del poblado', 'Manila', 'La Calera', 'Prado', 'Milla de Oro'];
  final List<String> cityOptions = ['Medellín'];

  final PredictionData data = PredictionData(
    area: 0,
    rooms: 0,
    garages: 0,
    stratum: 'Estrato 0',
    propertyType: 'Casa',
    baths: 0,
    neighbourhood: 'Laureles',
    city: 'Medellín',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PropyApp',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PropyApp'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Area'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      data.area = int.parse(value);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Rooms'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      data.rooms = int.parse(value);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Garages'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      data.garages = int.parse(value);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Stratum'),
                DropdownButton<String>(
                  value: data.stratum,
                  onChanged: (value) {
                    setState(() {
                      data.stratum = value!;
                    });
                  },
                  items: stratumOptions.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                const Text('Property Type'),
                DropdownButton<String>(
                  value: data.propertyType,
                  onChanged: (value) {
                    setState(() {
                      data.propertyType = value!;
                    });
                  },
                  items: propertyTypeOptions.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                const Text('Baths'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      data.baths = int.parse(value);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Neighbourhood'),
                DropdownButton<String>(
                  value: data.neighbourhood,
                  onChanged: (value) {
                    setState(() {
                      data.neighbourhood = value!;
                    });
                  },
                  items: neighbourhoodOptions.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                const Text('City'),
                DropdownButton<String>(
                  value: data.city,
                  onChanged: (value) {
                    setState(() {
                      data.city = value!;
                    });
                  },
                  items: cityOptions.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    PredictionResult result = await Api.predict(data);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Prediction Result'),
                          content: Text('Price: ${result.price}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Predict'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}