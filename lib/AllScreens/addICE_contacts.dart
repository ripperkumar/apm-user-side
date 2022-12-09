import 'package:flutter/material.dart';
import 'contact_model.dart';

class ContactFormItemWidget extends StatefulWidget {
  ContactFormItemWidget(
      {Key? key, this.contactModel, this.onRemove, this.index})
      : super(key: key);

  final index;
  ContactModel? contactModel;
  final Function? onRemove;
  final state = _ContactFormItemWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();

  bool isValidated() => state.validate();
}

class _ContactFormItemWidgetState extends State<ContactFormItemWidget> {
  final formKey = GlobalKey<FormState>();
  String relation = 'Father';
  var relationOptions = [
    'Father',
    'Mother',
    'Brother',
    'Sister',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contact - ${widget.index+1}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.redAccent),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //Clear All forms Data
                                widget.contactModel!.name = "";
                                widget.contactModel!.relationship = "";
                                widget.contactModel!.phone_number = "";
                                widget._nameController.clear();

                                widget._phonenumberController.clear();
                              });
                            },
                            child: Text(
                              "Clear",
                              style: TextStyle(color: Colors.redAccent),
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove!(),
                            child: Text(
                              "Remove",
                              style: TextStyle(color: Colors.redAccent),
                            )),
                      ],
                    ),
                  ],
                ),
                // TextFormField(
                //   controller: widget._relationshipController,
                //   onChanged: (value) => widget.contactModel!.phone_number = value,
                //   onSaved: (value) => widget.contactModel!.name = value,
                //   validator: (value) =>
                //   value!.length > 3 ? null : "Number is Not Valid",
                //   decoration: InputDecoration(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 12),
                //     border: OutlineInputBorder(),
                //     hintText: "Enter Number",
                //     labelText: "relationship",
                //   ),
                // ),
                DropdownButton(
                  isExpanded: true,
                  value: relation,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: relationOptions.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),


                  onChanged: (String? newValue) {
                    setState(() {
                      relation = newValue!;
                      widget.contactModel!.relationship=newValue;
                    });
                  },

                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: widget._nameController,
                  // initialValue: widget.contactModel.name,
                  onChanged: (value) => widget.contactModel!.name = value,
                  onSaved: (value) => widget.contactModel!.name = value,
                  validator: (value) => value!.length > 3 ? null : "Enter Name",
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                    labelText: "Name",
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                TextFormField(
                  controller: widget._phonenumberController,
                  onChanged: (value) => widget.contactModel!.phone_number = value,
                  onSaved: (value) => widget.contactModel!.phone_number = value,
                  validator: (value)=>value!.length>9?null:"Phone number is not valid",
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter phone number",
                    labelText: "phone number",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    //Validate Form Fields
    bool validate = formKey.currentState!.validate();
    if (validate) formKey.currentState!.save();
    return validate;
  }
}