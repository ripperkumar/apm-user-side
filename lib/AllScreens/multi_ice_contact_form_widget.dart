import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contact_form_item_widget.dart';
import 'contact_model.dart';

class MultiContactFormWidget extends StatefulWidget {
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
          : Center(child: Text("Tap on + to Add Contact, atleast 4 ICEs")),
    );
  }

  onSave() {
    bool allValid = true;
    if(contactForms.length<4)
      {
        print("atleast 4 contacts are required");
      }
    else{
      contactForms
          .forEach((element) => allValid = (allValid && element.isValidated()));

      if (allValid) {
        List<String?> names =
        contactForms.map((e) => e.contactModel!.name).toList();
        debugPrint("$names");
      } else {
        debugPrint("Form is Not Valid");
      }
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
}