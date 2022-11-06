import 'package:flutter/cupertino.dart';
import 'package:rider_app_apm/Models/address.dart';

class AppData extends ChangeNotifier{
  Address? pickUpLocation,dropOffLocation;


  void updatePickLocationAddress(Address pickUpAddress)
{
  pickUpLocation=pickUpAddress;
  notifyListeners();
}

  void updateDropOffLocationAddress(Address dropOffAddress)
  {
    dropOffLocation=dropOffAddress;
    notifyListeners();
  }
}