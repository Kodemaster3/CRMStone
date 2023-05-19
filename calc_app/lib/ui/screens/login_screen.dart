import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  late TextEditingController _mail;
  late TextEditingController _password;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _mail = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _mail.dispose();
    _password.dispose();
    super.dispose();
  }

  void _sendField() {
    setState(() {});
    // todo: need implement bloc
    // BlocProvider.of<LoginBloc>(context).add(LoginEvent(
    //   name: _mail.text,
    //   description: _password.text,
    // ));
    scaffoldMessage(context, _mail.text);
  }

  void scaffoldMessage(BuildContext context, String mail) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("request by $mail")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Field email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: _validatorEmailString,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _mail.text = value,
                  decoration: const InputDecoration(
                    hintText: 'Write email address',
                    helperText: 'email',
                    icon: Icon(Icons.email_outlined),
                  ),
                ),
              ),

              ///Field password
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: _validatorPasswordString,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  onChanged: (value) => _mail.text = value,
                  decoration:  InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        _toggle();
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                    hintText: 'Write password address',
                    helperText: 'password',
                    icon: const Icon(Icons.password),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.brown,
                      backgroundColor: Colors.black12,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendField();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatorEmailString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.length < 4) {
      return 'Please write correct email';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Format email must be \'example@domain.com\'';
    }

    return null;
  }

  String? _validatorPasswordString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.length < 8) {
      return 'Please write must have minimum 8 symbols';
    }

    return null;
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
