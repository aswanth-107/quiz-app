import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/provider_file.dart';
import 'package:quiz_app/question_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<FunctionsProvider>(
      builder: (context, functionProvdr, child) => Scaffold(
        body: Container(
          child: Form(
            key: functionProvdr.formKey,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                HexColor('#FF671F').withOpacity(.6),
                HexColor('#	FFFFFF'),
                HexColor(
                  '#046A38',
                ).withOpacity(.6)
              ])),
              child: SizedBox(
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.8,
                          height: size.height * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.black,
                                  child: functionProvdr.imageBytes != null
                                      ? ClipOval(
                                          child: Image.memory(
                                            functionProvdr.imageBytes!,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        )
                                      : Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey.shade400,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.black),
                                ),
                                onPressed: () =>
                                    functionProvdr.getImage(context),
                                child: const Text(
                                  'Add Photo',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              if (functionProvdr.showPhotoError &&
                                  functionProvdr.imageBytes == null)
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Photo is Required',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 50),
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text('Enter Your Name'),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: functionProvdr.nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 225, 222, 222),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length <= 2) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (functionProvdr.formKey.currentState!
                                        .validate()) {
                                      if (functionProvdr.imageBytes != null) {
                                        functionProvdr.showPhotoError = false;
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const QuestionPage(),
                                          ),
                                          (route) => false,
                                        );
                                      } else {
                                        functionProvdr.showPhotoError = true;
                                        functionProvdr.notifyListeners();
                                      }
                                    }
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.black),
                                  ),
                                  child: const Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
