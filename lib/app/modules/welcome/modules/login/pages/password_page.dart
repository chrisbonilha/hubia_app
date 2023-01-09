import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/app/modules/welcome/modules/login/bloc/login_bloc.dart';
import 'package:hubia_menu_app/app/utils/validators/password_validator.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(25, 42, 25, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tudo certo!',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Qual sua senha de acesso ao App?',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          enabled: state.runtimeType != Loading,
                          decoration: InputDecoration(
                            label: Text("Senha"),
                            errorText: state.runtimeType == LoginError
                                ? "Usuário ou senha inválidos"
                                : null,
                          ),
                          validator: PasswordValidator.validate,
                          onSaved: (pass) {
                            context
                                .read<LoginBloc>()
                                .add(PasswordSubmited(pass!));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: state.runtimeType != Loading
                    ? () {
                        context.read<LoginBloc>().add(FormValidated());
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      }
                    : null,
                child: Text("Avançar"),
              ),
            ],
          ),
        );
      },
    );
  }
}
