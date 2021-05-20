import 'package:flutter/material.dart';
import 'package:multi_wizard/multi_wizard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Example(),
    );
  }
}

class Example extends StatelessWidget {
  final List<WizardStep> _demoSteps1 = [
    WizardStep(
      child: Center(
        child: Text('Welcome to the app!'),
      ),
    ),
    WizardStep(
        child: Center(
      child: Text('This is all!'),
    )),
  ];

  final List<WizardStep> _demoSteps2 = [
    WizardStep(
      child: Center(
        child: Text("Hello"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Example 1'),
            MultiWizard(
              steps: _demoSteps1,
            ),
            Text('Example 2'),
            MultiWizard(
              steps: _demoSteps2,
            ),
          ],
        ),
      ),
    );
  }
}
