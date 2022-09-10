import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        "Delete",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Are you sure?",
        textAlign: TextAlign.center,
      ),
      actions: [
        Container(
          child: Row(
            
            children: [
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
