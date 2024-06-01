import 'package:flutter/material.dart';

class ConfirmationDialog {
  static void showConfirmationDialog(BuildContext context, { required Function onConfirm }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Are you sure you want to DECLINE the order?',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'When you press the button, the operation will be cancelled',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.green),
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onConfirm();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Text('Yes'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
