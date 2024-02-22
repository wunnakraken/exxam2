import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Input and Validation',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student Information Form'),
        ),
        body: const StudentForm(),
      ),
    );
  }
}

class StudentForm extends StatefulWidget {
  const StudentForm({super.key});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String? _validateID(String? value) {
    final isNum = RegExp(r'^\d{11}$');
    if (isNum.hasMatch(value!)) {
      if (value.toString().isEmpty) {
        return 'ID cannot be empty';
      }
      if (value.toString().length != 11) {
        return 'ID must be 11 characters long';
      }
      return null;
    } else {
      return 'ID must be a number';
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentInfoPage(
            name: _nameController.text,
            id: _idController.text,
            email: _emailController.text,
          ),
        ),
      );
    }
  }

  /*
  _submitForm() {
    if (_formKey.currentState!.validate()) {
      // print('ID: ${_idController.text}');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Student Information'),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text('Name: ${_nameController.text}'),
                  Text('ID: ${_idController.text}'),
                  Text('Email: ${_emailController.text}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Enter your Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _idController,
              validator: _validateID,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter your Student ID",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Plese enter Email';
                } else {
                  final isEmail = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                  if (isEmail.hasMatch(value)) {
                    return null;
                  } else {
                    return "Email Format Incorrect";
                  }
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Enter your Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentInfoPage extends StatelessWidget {
  const StudentInfoPage(
      {super.key, required this.name, required this.id, required this.email});

  final String name;
  final String id;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Colors.blue[100],
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[100],
              ),
              height: 200,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name : $name', style: const TextStyle(fontSize: 20)),
                  Text('ID : $id', style: const TextStyle(fontSize: 20)),
                  Text('Email : $email', style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
