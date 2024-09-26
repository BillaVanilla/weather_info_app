import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String cityName = ""; // Storage for city name
  String temperature = "--"; // Placeholder for temperature
  String weatherCondition = "--"; // Placeholder for condition
  List<Map<String, String>> Seven_day_forecast = [];

  // Function to simulate fetching weather
  void _getWeather() {
  List<String> conditions = ['Sunny', 'Cloudy', 'Rainy', 'Snowy']; // List of all possible weather effects
  int randomTemp = Random().nextInt(16) + 15; // Functions to randomly generate value between 15-30
  String randomCondition = conditions[Random().nextInt(conditions.length)]; //Randomly picks weather effects from list
  setState(() {
      temperature = "$randomTemp degrees Celcius";
      weatherCondition = randomCondition;
    });
  }

  void _getForecast() {
  List<String> conditions = ['Sunny', 'Cloudy', 'Rainy', 'Snowy']; // List of all possible weather effects
  List<Map<String, String>> newForecast = List.generate(7, (index) {
  int randomTemp = Random().nextInt(16) + 15; // Functions to randomly generate value between 15-30
  String randomCondition = conditions[Random().nextInt(conditions.length)]; //Randomly picks weather effects from list
  return{
  'Day': 'Day ${index + 1}',
  'Current Temperature': "$randomTemp°C",
  'Weather Condition': randomCondition
    };
  });

  setState(() {
      Seven_day_forecast = newForecast;
    });
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(widget.title),
      ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    // Input field for the city name
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
    onChanged: (text) {
    setState(() {
    cityName = text;
    });
    },
    decoration: const InputDecoration(
    labelText: 'Enter name for the city',
    border: OutlineInputBorder(),
        ),
      ),
    ),
      const SizedBox(height: 20),
          // Weather Button location
      
      ElevatedButton(
      child: const Text('Get Weather'),
          style: ElevatedButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
              onPressed: _getWeather,
            ),
          const SizedBox(height: 20), // Display city name
      ElevatedButton(
                child: const Text('Get 7-day Forecast'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: cityName.isEmpty ? null : _getForecast,
              ),
              if (Seven_day_forecast.isNotEmpty) ...[
                const Text(
                  "7-Day Weather Forecast",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                for (var day in Seven_day_forecast)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "${day['day']}: ${day['temperature']}, ${day['condition']}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
              ],
        Text(
              cityName.isNotEmpty ? "Weather in $cityName" : "Enter a city to get weather report",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            //  Shows the current temperature

       Text(
              "Temperature: $temperature",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Shows the current weather condition
        Text(
              "Condition: $weatherCondition",
              style: const TextStyle(fontSize: 18),
            ),
          const SizedBox(height: 20),
            // Displays counter
        const Text(
              'You have pushed the button this many times:',
            ),
        Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
