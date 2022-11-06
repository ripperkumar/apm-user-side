
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider_app_apm/Models/directDetails.dart';
import 'package:rider_app_apm/dataHandler/appData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rider_app_apm/AllScreens/configMaps.dart';
import 'package:rider_app_apm/Assistants/requestAssistant.dart';
import 'package:rider_app_apm/Models/address.dart';
class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position,context) async{
    String placeAddress = "";
    var st1,st2,st3,st4;
    String url ="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";


    var response = await RequestAssistant.getRequest(url);
    if(response!="failed")
      {
        // placeAddress=response["results"][0]["address_components"];
        st1=response["results"][0]["address_components"][2]["long_name"];
        st2=response["results"][0]["address_components"][3]["long_name"];
        st3=response["results"][0]["address_components"][5]["long_name"];
        st4=response["results"][0]["address_components"][6]["long_name"];
        // 3FGX+FHC, Acharya Dr Sarvepalli Radhakrishnan Rd, Thammenahalli Village, Bengaluru, Karnataka 560090, India


        placeAddress= st1 + " "+st2 +" "+ st3 + " "+st4;
        Address userPickUpAddress = new Address();
        userPickUpAddress.longitude=position.longitude;
        userPickUpAddress.latitude=position.latitude;
        userPickUpAddress.placeName=placeAddress;
        Provider.of<AppData>(context,listen: false).updatePickLocationAddress(userPickUpAddress);

      }
    return placeAddress;
  }
  static Future<DirectionDetails?> obtainPlaceDirectionDetails(LatLng initialPosition,LatLng finalPosition) async
  {
    String directionUrl="https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res=await RequestAssistant.getRequest(directionUrl);
    if(res=="failed")
      {
        return null;
      }
    DirectionDetails directionDetails=DirectionDetails();
    directionDetails.encodedPoints=res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText=res["routes"][0]["legs"][0]["distance"]["text"];

    directionDetails.distanceValue=res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText=res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue=res["routes"][0]["legs"][0]["duration"]["value"];
    return directionDetails;
  }
}