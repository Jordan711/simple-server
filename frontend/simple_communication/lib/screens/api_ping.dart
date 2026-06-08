import 'package:flutter/material.dart';

class APIPing extends StatefulWidget {
  const APIPing({super.key});

  @override
  State<APIPing> createState() => _APIPingState();
}

class _APIPingState extends State<APIPing> {
  final _formKey = GlobalKey<FormState>();
  final _ipController = TextEditingController();
  final _endpointController = TextEditingController();

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
                  return null;
                },
              ),

              SizedBox(height: 25.0),

              TextFormField(
                controller: _endpointController,
                decoration: const InputDecoration(labelText: "Endpoint"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),

              SizedBox(height: 25.0),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Field 1: ${_ipController.text}');
                    print('Field 2: ${_endpointController.text}');
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
