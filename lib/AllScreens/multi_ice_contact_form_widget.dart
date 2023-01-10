import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app_apm/AllScreens/configMaps.dart';
import 'package:rider_app_apm/AllScreens/mainscreen.dart';
import 'package:rider_app_apm/main.dart';
import 'addICE_contacts.dart';
import 'ice_contact_model.dart';

class MultiContactFormWidget extends StatefulWidget {
  static const String idScreen = "Add Ice Contacts";

  @override
  State<StatefulWidget> createState() {
    return _MultiContactFormWidgetState();
  }
}

class _MultiContactFormWidgetState extends State<MultiContactFormWidget> {
  List<ContactFormItemWidget> contactForms = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ICE Contacts"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            onSave();

          },
          child: Text("Save"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: () {
          onAdd();
        },
      ),
      body: contactForms.isNotEmpty
          ? ListView.builder(
          itemCount: contactForms.length,
          itemBuilder: (_, index) {
            return contactForms[index];
          })
          : Center(
          child: Text("Tap on + to Add Contact, atleast 4 ICEs")),
    );
  }


  onSave() {
    bool allValid = true;

    //If any form validation function returns false means all forms are not valid
    contactForms
        .forEach((element) => allValid = (allValid && element.isValidated()));
    if(contactForms.length < 4) {
      displayToastMessage("please enter ${4-contactForms.length} more contacts", context);
    }
    else if (allValid) {
      firebaseUser = FirebaseAuth.instance.currentUser;
      userRef.child(firebaseUser!.uid).update({
        "ICE contacts": contactForms
      });
      Navigator.pushNamedAndRemoveUntil(context,
          MainScreen.idScreen, (route) => false);
    }
    else {
      debugPrint("Form is Not Valid");
    }
  }
  //Delete specific form
  onRemove(ContactModel contact) {
    setState(() {
      int index = contactForms
          .indexWhere((element) => element.contactModel?.id == contact.id);

      if (contactForms != null) contactForms.removeAt(index);
    });
  }


  onAdd() {
    setState(() {
      ContactModel _contactModel = ContactModel(id: contactForms.length, phone_number: '', relationship: '', name: '');
      contactForms.add(ContactFormItemWidget(
        index: contactForms.length,
        contactModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }

  void displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}