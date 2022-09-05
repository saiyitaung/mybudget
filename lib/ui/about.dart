import 'package:flutter/material.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: Column(
        children: [
          Container(
            height: 200,
            alignment: Alignment.center,
            child: const Icon(
              Icons.info_outline_rounded,
              size: 170,
              color: Colors.teal,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "MyBudget",
              style: TextStyle(fontSize: 30, fontFamily: 'Itim'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                children: const [
                  TableRow(children: [Text("version"), Text("1.0")]),
                  TableRow(children: [
                    Text("developer"),
                    Text("saiyitaung@gmail.com")
                  ]),
                  TableRow(children: [
                    Text("detail"),
                    Text("personal budget recording app. just for fun")
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
