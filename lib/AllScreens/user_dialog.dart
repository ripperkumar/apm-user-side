import 'package:flutter/material.dart';

import 'user.dart';
class AddUserDialog extends StatefulWidget {
  final Function(User) addUser;


  AddUserDialog(this.addUser);

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {

  @override
  Widget build(BuildContext context) {
    Widget buildTextField(String hint,TextEditingController controller){

      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),

            ),
          ),
          controller: controller,
        ),
      );

    }

    var relationController =TextEditingController();
    var nameController =TextEditingController();
    var phoneNoController =TextEditingController();
    return Container(
      padding:EdgeInsets.all(8),
      height: 350,
      width: 400,
      child:SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black,
              ),
            ),

            buildTextField('relation', relationController),
            buildTextField('name', nameController),
            buildTextField('phoneNo', phoneNoController),
            ElevatedButton(onPressed: (){
              final user = User(relationController.text,nameController.text,phoneNoController.text);
              widget.addUser(user);
              Navigator.of(context).pop;
            }, child: Text('Add relation'),),

          ],
        ),
      ),
    );
  }
}