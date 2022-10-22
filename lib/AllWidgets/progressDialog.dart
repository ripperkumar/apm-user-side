import 'package:flutter/material.dart';
class ProgressDialog extends StatelessWidget {
  String message='Please Wait';
  ProgressDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child:Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
              SizedBox(width: 16.0,),
              Text(message,
              style:TextStyle(color:Colors.black,fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
