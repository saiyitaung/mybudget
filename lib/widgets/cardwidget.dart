import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  const CardWidget(
      {Key? key,
      required this.title,
      required this.amount,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(.8),
                color.withOpacity(.3),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.5,
              color: color.withOpacity(0.2),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontFamily: 'Itim', fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(builder: ((context, ref, child) {
                      return Text(
                        currencySymbols[
                            ref.watch(currencyChangeNotifier).currency]!,
                        style:
                            const TextStyle(fontSize: 22, fontFamily: 'meriendaone'),
                      );
                    })),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "$amount",
                      style: const TextStyle(fontFamily: 'meriendaone', fontSize: 22),
                    ),
                    const SizedBox(width: 4,),
                    Consumer(builder: (context, ref, child) {
                      final currency=ref.watch(currencyChangeNotifier).currency.name;
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          currency == "mmk" ?  currency.toUpperCase() :currency[0].toUpperCase() +currency.substring(1),
                          style: const TextStyle(fontSize: 11,fontStyle: FontStyle.italic,fontFamily: 'itim'),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
