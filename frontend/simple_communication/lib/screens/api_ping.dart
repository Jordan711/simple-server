import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIPing extends StatefulWidget {
  const APIPing({super.key});

  @override
  State<APIPing> createState() => _APIPingState();
}

class _APIPingState extends State<APIPing> {
  final _formKey = GlobalKey<FormState>();
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  final _endpointController = TextEditingController();

  final ipRegex = RegExp(
    r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _ipController,
                decoration: const InputDecoration(labelText: "Server IP"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid ip";
                  }

                  if (!ipRegex.hasMatch(value)) {
                    return 'Enter a valid IP format (e.g., 192.168.1.1)';
                  }
                  return null;
                },
              ),

              SizedBox(height: 25.0),

              TextFormField(
                controller: _portController,
                decoration: const InputDecoration(labelText: "Server Port"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid port";
                  }
                  final parsedPort = num.tryParse(value);
                  if (parsedPort == null) {
                    return "Invalid port number";
                  }
                  return null;
                },
              ),

              SizedBox(height: 25.0),

              TextFormField(
                controller: _endpointController,
                decoration: const InputDecoration(labelText: "Endpoint"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter endpoint';
                  }
                  return null;
                },
              ),

              SizedBox(height: 25.0),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final targetIp = _ipController.text.trim();
                    final portNumber = _portController.text.trim();
                    final endpoint = _endpointController.text.trim();

                    final url = Uri.parse(
                      'http://$targetIp:$portNumber/api/$endpoint',
                    );
                    try {
                      print('Sending request to: $url');

                      // 4. Send the POST request to your backend
                      final response = await http.get(url);

                      // 5. Handle the response status from simple-server
                      if (response.statusCode == 200) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response.body),
                            backgroundColor: const Color.fromARGB(255, 0, 94, 3), // Optional styling
                            duration: Duration(
                              seconds: 2,
                            ), // How long it stays on screen
                          ),
                        );
                      } else {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response.statusCode.toString()),
                            backgroundColor: const Color.fromARGB(255, 125, 125, 0), // Optional styling
                            duration: Duration(
                              seconds: 2,
                            ), // How long it stays on screen
                          ),
                        );
                      }
                    } catch (error) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                          backgroundColor: Colors.red, // Optional styling
                          duration: Duration(
                            seconds: 2,
                          ), // How long it stays on screen
                        ),
                      );
                    }
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
