// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class BottomNav extends ConsumerWidget {
//   final PageController pctrl;
//   final List<Icon> items;
//   const BottomNav({Key? key, required this.pctrl, required this.items})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return CurvedNavigationBar(
//         index: pctrl.initialPage,
//         color: Colors.black,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         onTap: (i) {
//           pctrl.jumpToPage(i);
//         },
//         items: items);
//   }
// }
