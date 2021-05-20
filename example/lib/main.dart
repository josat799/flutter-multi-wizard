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

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String name = "";

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          height: 500,
          child: MultiWizard(
            steps: [
              WizardStep(
                showPrevious: false, // Removes the previous button
                nextFunction: () => print('You pressed the next button'),
                child: Container(
                  height: double.infinity,
                  child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ClipRect(
                        child: Image.network(
                            "https://i0.wp.com/www.logoworks.com/blog/wp-content/uploads/2014/03/fruit-vegetable-logos-templates-logo-designs-037.png?w=325&ssl=1"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome to the most amazing app ever!",
                      ),
                      Text("Created By josat799"),
                    ],
                  ),
                ),
              ),
              WizardStep(
                child: Center(
                  child: Form(
                    key: _key,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(hintText: 'Your name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must have a name!';
                        } else if (value.length < 2) {
                          return 'Your name must be atleast 2 charachters long!';
                        }
                      },
                      onSaved: (value) {
                        name = value!;
                      },
                    ),
                  ),
                ),
              ),
            ],
            finishFunction: () {
              if (_key.currentState!.validate()) {
                _key.currentState!.save();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Welcome $name!'),
                  duration: Duration(seconds: 5),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
