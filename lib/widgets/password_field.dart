import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordField extends StatefulWidget {
  final String name;
  final String hintText;
  final String labelText;

  const PasswordField({
    this.name = "password",
    this.hintText = "Enter your password",
    this.labelText = "Password",
    Key? key}) : super(key: key);




  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name,
      obscureText: obscureText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          border: OutlineInputBorder(),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(40.0),
              onTap: () => setState(() => obscureText = !obscureText),
              child: Icon(
                obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          )),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context),
        FormBuilderValidators.minLength(context, 8, errorText: "Password must be at least 8 characters."),
      ]),
    );

  }
}
