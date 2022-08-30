import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final List<String> autoCompleteText;
  final TextInputType type;
  final TextEditingController ctl;
  const InputTextWidget(
      {Key? key, required this.label, required this.type, required this.ctl,required this.autoCompleteText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(right: 5),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: ctl,
                    keyboardType: type,
                    decoration: InputDecoration(                        
                        labelText: label,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
                noItemsFoundBuilder: (context) {
                  return SizedBox();
                },
                loadingBuilder: (c) {
                  return SizedBox();
                },
                suggestionsCallback: (str) {
                  List<String> matches = <String>[];
                  for(final e in autoCompleteText){
                    matches.add(e);
                  }

                  matches.retainWhere(
                      (s) => s.toLowerCase().contains(str.toLowerCase()));
                  return matches;
                  // return autoCompleteText;
                },
                onSuggestionSelected: (dynamic selectedSugget) {
                  ctl.text=selectedSugget.toString();                  
                },
                itemBuilder: (context, dynamic suggest) {
                  return ListTile(
                    title: Text(suggest),
                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                  );
                },
              ),
            );
    // return TextField(
    //   controller: ctl,
    //   keyboardType: type,
    //    style: TextStyle(color: Colors.white70),
    //   decoration: InputDecoration(
    //     labelText: label,
    //     labelStyle: TextStyle(color: Colors.white54),        
    //     hintStyle: TextStyle(color: Colors.white60),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // );
  }
}
