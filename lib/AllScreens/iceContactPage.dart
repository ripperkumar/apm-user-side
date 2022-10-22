import 'package:flutter/material.dart';
import 'user.dart';
import 'user_dialog.dart';

class IceContacts extends StatefulWidget {
  const IceContacts({Key? key}) : super(key: key);
  static const String idScreen = "Ice contact page";

  @override
  _IceContactsState createState() => _IceContactsState();
}

class _IceContactsState extends State<IceContacts> {

  List<User> userList =[];

  @override
  Widget build(BuildContext context) {
    void addUserData(User user){
      setState(() {
        userList.add(user);
      });
    }

    void showUserDialog(){
      showDialog(context: context, builder: (_){
        return AlertDialog(
          content: AddUserDialog(addUserData),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showUserDialog,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Relationship of the user'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height*0.75,
        child: ListView.builder(itemBuilder: (ctx,index){
          return Card(
            margin: EdgeInsets.all(4),
            elevation: 8,
            child: ListTile(
              title: Text(userList[index].name,style: TextStyle(
                fontSize: 22,
                color: Colors.black54,
                fontWeight: FontWeight.w400,

              ),),
              subtitle: Text(userList[index].relation,style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w400,

              ),),
              trailing: Text(userList[index].phoneNo,style: TextStyle(
                fontSize: 18,
                color: Colors.black26,
                fontWeight: FontWeight.w400,

              ),),
            ),);
        },itemCount: userList.length,),
      ),
    );
  }
}


