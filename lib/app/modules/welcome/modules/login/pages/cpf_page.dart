import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubia_menu_app/app/modules/welcome/modules/login/bloc/login_bloc.dart';
import 'package:hubia_menu_app/app/utils/validators/cpf_validator.dart';

class CpfPage extends StatefulWidget {
  CpfPage({Key? key}) : super(key: key);

  @override
  State<CpfPage> createState() => _CpfPageState();
}

class _CpfPageState extends State<CpfPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = MaskedTextController(mask: '000.000.000-00');

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is HasCpf) Navigator.of(context).pushNamed("/password");
      },
      child: Form(
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
                        'Vamos Precisar de alguns dados',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Fala pra gente seu CPF',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Qual o seu CPF"),
                        ),
                        validator: CpfValidator.validate,
                        controller: controller,
                        onSaved: (cpf) =>
                            context.read<LoginBloc>().add(CpfSubmited(cpf!)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(FormValidated());
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: Text("Avançar"),
            ),
          ],
        ),
      ),
    );
  }
}
