import 'package:flutter/material.dart';
import '../../core/services/geoloctor_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _LocationPageState();
}

class _LocationPageState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();

  double? distance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geolocator Example")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locationMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await getLocation();
                    setState(() {});
                  },
                  child: const Text("Get My Location"),
                ),
                const Divider(),
                const SizedBox(height: 20),
                TextFormField(
                  controller: c1,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Enter Longitude",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter valid number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: c2,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Enter Latitude",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter valid number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  distance == null
                      ? "Distance is"
                      : "Distance is ${distance!.toStringAsFixed(2)} m",
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      double lat = double.parse(c2.text);
                      double long = double.parse(c1.text);
                      double result = await calculateDistance(
                        targetLat: lat,
                        targetLong: long,
                      );
                      setState(() {
                        distance = result;
                      });
                    }
                  },
                  child: const Text("Calculate Distance"),
                ),
                Divider(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    startTracking((position) {
                      setState(() {
                        locationMessage =
                            "Live: \nLat: ${position.latitude}\n"
                            "Lng: ${position.longitude}\n"
                            "Speed: ${position.speed.toStringAsFixed(2)} m/s\n"
                            "Direction: ${position.heading.toStringAsFixed(2)}°";
                      });
                    });
                  },
                  child: const Text("Start Live Tracking"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: stopTracking,
                  child: const Text("Stop Tracking"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}