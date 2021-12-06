import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../pages/dashboard.dart';
import '../pages/registration_personal.dart';
import '../services/auth.dart';
import '../utils/colors.dart';
import '../utils/database.dart';
import '../utils/progress_dialog.dart';
import '../widgets/large_txt.dart';
import '../widgets/password_field.dart';
import '../widgets/simple_txt.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    AppLargeText(text: "Sign In with your Email"),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "email",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your Email", labelText: "Email", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    PasswordField(),
                    const SizedBox(height: 20.0),
                    TextButton(
                        onPressed: () => _login(context),
                        child: AppText(text: "Login", color: Colors.white, weight: FontWeight.bold),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        )),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(text: "Don't have an account?"),
                        InkWell(
                            onTap: () => Get.to(() => RegistrationPersonalPage()),
                            child: AppText(text: " Sign up", color: Colors.blue, weight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    TextButton(
                        onPressed: () => _loginWithGoogle(),
                        child: Text("Login with Google"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackground),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      log(_fbKey.currentState!.value.toString());
      Loader.show(context, text: "Logging In...");
      try {
        UserCredential credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _fbKey.currentState!.value["email"], password: _fbKey.currentState!.value["password"]);
        UserModel user = await Database.getTourist(credentials.user!.uid);
        Loader.hide();
        Get.off(() => DashboardPage());
        Fluttertoast.showToast(msg: "Logged in successfully.");
      } on FirebaseAuthException catch (exception) {
        Loader.hide();
        Get.dialog(AlertDialog(
          title: AppText(text: "Login"),
          content: AppText(text: "${exception.message}", size: 14.0),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () => Get.back(),
            )
          ],
        ));
      }
    }
  }

  void _loginWithGoogle() async {
    try{
      UserCredential user = await
      AuthService.signInWithGoogle();
      log('Logged in: ${user.user}');

    }on FirebaseAuthException catch(e){
      log('Auth Exception - $e');
      //show a dialog or toast

    }catch(e){
      log('Exception - $e');

    }
  }
}
