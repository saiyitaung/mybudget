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
            child: Image.asset('img/applogo.png',)
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
                  TableRow(children: [Padding(padding: EdgeInsets.only(right: 10),child:Text("version",textAlign: TextAlign.end,)), Text("1.2")]),
                  TableRow(children: [
                    Padding(padding: EdgeInsets.only(right: 10),child:Text("developer",textAlign: TextAlign.end,),),
                    Text("saiyitaung@gmail.com")
                  ]),
                  TableRow(children: [
                    Padding(padding: EdgeInsets.only(right: 10),child:Text("detail",textAlign: TextAlign.end,),),
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
