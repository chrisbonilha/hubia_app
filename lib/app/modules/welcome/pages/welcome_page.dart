import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Column(children: [
            Image(
              image: AssetImage('assets/images/icons/logo_marca.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            )
          ]),
        )
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/icons/logo_marca.png'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: const Text("CADASTRAR"),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pushNamed("/login"),
            child: const Text("LOGIN"),
          )
        ],
      ),
    );
  }
}
