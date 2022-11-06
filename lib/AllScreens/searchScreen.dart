import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app_apm/AllScreens/configMaps.dart';
import 'package:rider_app_apm/AllWidgets/divider.dart';
import 'package:rider_app_apm/AllWidgets/progressDialog.dart';
import 'package:rider_app_apm/Assistants/requestAssistant.dart';
import 'package:rider_app_apm/Models/address.dart';
import 'package:rider_app_apm/Models/placePrediction.dart';

import '../dataHandler/appData.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickupTextEditingCntroller=TextEditingController();
  TextEditingController dropoffTextEditingCntroller=TextEditingController();
  List<PlacePredictions> placePredictionList=[];
  @override
  Widget build(BuildContext context) {
    String placeAddress=Provider.of<AppData>(context).pickUpLocation?.placeName ?? "";
    pickupTextEditingCntroller.text=placeAddress;
    return Scaffold(
      body: SingleChildScrollView (
        child: Column(
          children: [
            Container(
              height: 215.0,
                decoration: BoxDecoration(
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(

                      color:Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ]

                ),
              child: Padding(
                padding: EdgeInsets.only(left: 25.0,top: 30.0,right: 25.0,bottom: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 5.0,),
                    Stack(
                      children: [
                        GestureDetector(

                            child: Icon(Icons.arrow_back),
                          onTap: (){
                              Navigator.pop(context);
                          },
                        ),
                        Center(
                          child: Text("Hospital to drop off",style: TextStyle(fontSize: 18.0,),),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0,),
                    Row(
                      children: [
                        Image.asset("images/pickicon.png",height: 16.0,width: 16.0,),
                        SizedBox(width: 18.0,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          child: TextField(
                            controller: pickupTextEditingCntroller,
                            decoration: InputDecoration(
                              hintText: "Pickup Location",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0),
                            ),
                          ),
                          padding:EdgeInsets.all(3.0) ,
                        ),
                      ))
                      ],

                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Image.asset("images/desticon.png",height: 16.0,width: 16.0,),
                        SizedBox(width: 18.0,),
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            child: TextField(
                              onChanged: (val){ findPlace(val);},
                              controller: dropoffTextEditingCntroller,

                              decoration: InputDecoration(
                                hintText: "Nearby Hospital",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0),
                              ),
                            ),
                            padding:EdgeInsets.all(3.0) ,
                          ),
                        ))
                      ],

                    ),
                  ],
                ),
              ),
            ),
            //title for predictions
            SizedBox(height: 8.0,),
            (placePredictionList.length>0)?
                Padding(padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                child: ListView.separated(
                  padding:EdgeInsets.all(0.0) ,
                  itemBuilder: (context,index){
                    return PredictionTile(placePredictions: placePredictionList[index],);
                  },
                  separatorBuilder: (BuildContext context,int index)=>DividerWidget(),
                  itemCount: placePredictionList.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                ),
                ):Container(),
          ],
        ),
      ),
    );
  }
  void findPlace(String placeName) async{
    if(placeName.length>1)
      {
        String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:in";
        var res= await RequestAssistant.getRequest(autoCompleteUrl);
        if(res=="failed")
          {
            return;
          }
        if(res["status"]=="OK")
          {
            var predictions =res["predictions"];
            var placeList=(predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();
          setState(() {
            placePredictionList=placeList;
          });
          }
      }
  }

}


class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  PredictionTile({Key? key,required this.placePredictions}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: (){
        getPlaceAddressDetails(placePredictions.place_id.toString(),context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(width: 14.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0,),
                      Text(placePredictions.main_text.toString(),overflow:TextOverflow.ellipsis, style:TextStyle(fontSize: 16.0),),
                      SizedBox(height: 2.0,),
                      Text(placePredictions.secondary_text.toString(),overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0,color: Colors.grey),),
                      SizedBox(height: 8.0,),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0,),
          ],
        ),
      ),
    );
  }
  void getPlaceAddressDetails(String placeId,context) async
  {
    showDialog(context: context, builder: (BuildContext context)=>ProgressDialog(message: "Setting Dropoff, please wait..."));
    String placeDetailsUrl="https://maps.googleapis.com/maps/api/place/details/json?&place_id=$placeId&key=$mapKey";
    var res= await RequestAssistant.getRequest(placeDetailsUrl);

    Navigator.pop(context);
    if(res=="failed")
      {
        return;
      }
    if(res["status"]=="OK")
      {
        Address address=Address();
        address.placeName=res["result"]["name"];
        address.placeId=placeId;
        address.latitude=res["result"]["geometry"]["lat"];
        address.longitude=res["result"]["geometry"]["lng"];
        address.latitude = res["result"]["geometry"]["location"]["lat"];
        address.longitude = res["result"]["geometry"]["location"]["lng"];
        Provider.of<AppData>(context,listen: false).updateDropOffLocationAddress(address);
        print("this is Dropoff Location :: ");
        print(address.placeName);
        Navigator.pop(context,"obtainedDirection");
      }
  }
}

