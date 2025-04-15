import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  double result = 0;
  TextEditingController textEditingController = TextEditingController();
  String? errorText;

  void convert() {
    final text = textEditingController.text.trim();

    if (text.isEmpty) {
      setState(() => errorText = 'Amount can\'t be empty');
      return;
    }

    final value = double.tryParse(text);
    if (value == null) {
      setState(() => errorText = 'Please enter a valid number');
      return;
    }

    setState(() {
      errorText = null;
      result = value * 122.23;
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.brown, width: 2),
      borderRadius: BorderRadius.circular(40),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Currency Converter",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            shadowColor: Colors.brown.shade200,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('USD ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown)),
                      Icon(Icons.arrow_forward, color: Colors.brown),
                      Text(' BDT', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: textEditingController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorText: errorText,
                      errorBorder: border,
                      focusedErrorBorder: border,
                      labelText: "Amount",
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 23, 5, 5)),
                      hintText: "Enter amount",
                      prefixIcon: const Icon(Icons.monetization_on),
                      prefixIconColor: const Color.fromARGB(255, 13, 12, 12),
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: convert,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: const Color.fromARGB(255, 110, 18, 18),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Convert"),
                  ),
                  const SizedBox(height: 20),
                  if (result > 0)
                    Text(
                      'BDT ${result.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
