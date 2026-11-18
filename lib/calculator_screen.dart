import 'package:flutter/material.dart';

// The calculator screen. It is stateful because it holds the input values and result.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

// The state for CalculatorScreen. Holds controllers, result, and the UI logic.
class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controllers read the user's input from the two text fields.
  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();

  // result holds the calculation output as a double so result.toString() always
  // shows the decimal (e.g. "15.0", "25.0", "100.0", "4.0").
  double result = 0.0;

  // calcError holds a validation or division-by-zero message when one occurs.
  String? calcError;

  String operationLabel = 'Enter two numbers';

  // Performs the selected operation on the two numbers entered by the user.
  // .text retrieves the input as text; double.tryParse() converts text to a number
  // and returns null when conversion fails; switch selects the operation;
  // setState() tells Flutter to rebuild the interface with the updated values;
  // return stops the function when the input is invalid.
  void calculate(String operation) {
    final first = double.tryParse(firstNumberController.text.trim());
    final second = double.tryParse(secondNumberController.text.trim());

    if (first == null || second == null || !first.isFinite || !second.isFinite) {
      setState(() {
        calcError = 'Invalid input';
        result = 0.0;
        operationLabel = 'Please enter two valid numbers';
      });
      return;
    }

    if (operation == '÷' && second == 0) {
      setState(() {
        calcError = 'Cannot divide by zero';
        result = 0.0;
        operationLabel = 'Please change the second number';
      });
      return;
    }

    double answer;
    switch (operation) {
      case '+':
        answer = first + second;
        break;
      case '-':
        answer = first - second;
        break;
      case '×':
        answer = first * second;
        break;
      case '÷':
        answer = first / second;
        break;
      default:
        return;
    }

    setState(() {
      result = answer;
      calcError = null;
      operationLabel = '$first $operation $second';
    });
  }

  // Clears both input fields and resets the result and operation label.
  void clearCalculator() {
    firstNumberController.clear();
    secondNumberController.clear();
    setState(() {
      result = 0.0;
      calcError = null;
      operationLabel = 'Enter two numbers';
    });
  }

  // dispose() releases the controllers when the calculator screen is permanently removed.
  @override
  void dispose() {
    firstNumberController.dispose();
    secondNumberController.dispose();
    super.dispose();
  }

  // Formats a result double so the decimal always shows.
  // On Flutter web, double.toString() drops ".0" for whole numbers (e.g. 15.0 -> "15").
  // Force one decimal place for whole numbers so 15 shows as 15.0, while fractions
  // like 2.5 keep full precision via plain toString().
  String formatResult(double value) {
    if (value.isFinite && value == value.truncateToDouble() && value.abs() < 1e15) {
      return value.toStringAsFixed(1);
    }
    return value.toString();
  }

  // Builds the calculator UI: two input fields, four operation buttons, a result box, and a Clear button.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.calculate, size: 64, color: Colors.indigo),
            const SizedBox(height: 12),
            const Text(
              'BASIC CALCULATOR',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: firstNumberController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'First Number',
                hintText: 'Enter the first number',
                prefixIcon: Icon(Icons.looks_one),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: secondNumberController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'Second Number',
                hintText: 'Enter the second number',
                prefixIcon: Icon(Icons.looks_two),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text('−', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => calculate('×'),
                  child: const Text('×', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => calculate('÷'),
                  child: const Text('÷', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.indigo),
              ),
              child: Column(
                children: [
                  Text(operationLabel, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  const Text(
                    'RESULT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    calcError ?? formatResult(result),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: clearCalculator,
              icon: const Icon(Icons.refresh),
              label: const Text('Clear'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Results are doubles shown with a decimal: 20 and 5 give add 25.0, subtract
// 15.0, multiply 100.0, divide 4.0. Division by zero shows 'Cannot divide by
// zero' instead of crashing. Empty/invalid input shows an error message.
