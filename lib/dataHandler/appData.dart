import 'package:flutter/cupertino.dart';
import 'package:rider_app_apm/Models/address.dart';

class AppData extends ChangeNotifier{
  Address? pickUpLocation;


  void updatePickLocationAddress(Address pickUpAddress)
{
  pickUpLocation=pickUpAddress;
  notifyListeners();
}
}