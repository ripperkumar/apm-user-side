import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rider_app_apm/AllScreens/searchScreen.dart';
import 'package:rider_app_apm/AllWidgets/divider.dart';
import 'package:rider_app_apm/AllWidgets/progressDialog.dart';
import 'package:rider_app_apm/Assistants/assistantMethods.dart';
import 'package:rider_app_apm/dataHandler/appData.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String idScreen = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  late GoogleMapController newGoogleMapController;

  List<LatLng> pLineCoordinates=[]  ;
  Set<Polyline>polyLineSet={};

  Position? currentPosition;

  var geoLocator = Geolocator();
  double bottomPaddingofmap = 0;
  Set<Marker> markerSet={};
  Set<Circle> circlesSet={};

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
       new CameraPosition(target: latLatPosition, zoom: 14);

    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("your adress is :::::::" + address);
  }






  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: const Text('Main screen'),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 165.0,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Profile Name",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const DividerWidget(),
              const SizedBox(
                height: 12.0,
              ),
              //Drawer Body Controller
              const ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "visit Profile",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingofmap),
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polyLineSet,
            markers: markerSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingofmap = 300.0;
              });
              locatePosition();
            },
          ),

          //HamburgerButton for Drawer
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                scaffoldkey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ], // BoxShadow
              ), // BoxDecoration
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6.0),
                    const Text(
                      "Need Help",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    const Text(
                      "Where to?",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () async{
                        var res= await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));

                        if(res=="obtainedDirection")
                          {
                            await getPlaceDirection();
                          }
                        },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ], // BoxShadow
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Search Nearby Hospital"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.home,
                    //       color: Colors.grey,
                    //     ),
                    //     const SizedBox(
                    //       width: 12.0,
                    //     ),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           Provider.of<AppData>(context).pickUpLocation!=null
                    //               ? Provider.of<AppData>(context)
                    //                   .pickUpLocation!
                    //                   .placeName.toString()
                    //               : "Add Home",
                    //         ),
                    //
                    //         const SizedBox(
                    //           height: 4.0,
                    //         ),
                    //         const Text(
                    //           "your living address",
                    //           style: TextStyle(
                    //               color: Colors.black54, fontSize: 12.0),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    // const DividerWidget(),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.work,
                    //       color: Colors.grey,
                    //     ),
                    //     const SizedBox(
                    //       width: 12.0,
                    //     ),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: const [
                    //         Text("Add Work"),
                    //         SizedBox(
                    //           height: 4.0,
                    //         ),
                    //         Text(
                    //           "your Office address",
                    //           style: TextStyle(
                    //               color: Colors.black54, fontSize: 12.0),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async
  {
    var initialPos=Provider.of<AppData>(context,listen: false).pickUpLocation;
    var finalPos=Provider.of<AppData>(context,listen: false).dropOffLocation;
    var pickUpLatLng= LatLng(initialPos!.latitude!,initialPos.longitude!);
    var dropOffLatLng=  LatLng(finalPos!.latitude!, finalPos.longitude!);

    showDialog(context: context, builder: (BuildContext context)=>ProgressDialog(message: "please Wait..."),);
    var details=await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng,dropOffLatLng);

    Navigator.pop(context);
    print("this is Encoded Point :: ");
    print(details?.encodedPoints);
    // polyLineSet.clear();
    PolylinePoints polylinePoints=PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult=polylinePoints.decodePolyline(details!.encodedPoints.toString());

    pLineCoordinates.clear();

    if(decodedPolyLinePointsResult.isNotEmpty)
      {
        decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
          pLineCoordinates.add(LatLng(pointLatLng.latitude,pointLatLng.longitude));
        });
      }

    polyLineSet.clear();
    setState(() {
      Polyline polyline=Polyline(
        color: Colors.red,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,

      );

      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if(pickUpLatLng.latitude>dropOffLatLng.latitude&&pickUpLatLng.longitude>dropOffLatLng.longitude)
      {
        latLngBounds=LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
      }
    else if(pickUpLatLng.longitude>dropOffLatLng.longitude)
    {
      latLngBounds=LatLngBounds(southwest: LatLng(pickUpLatLng.latitude,dropOffLatLng.longitude), northeast:LatLng(dropOffLatLng.latitude,pickUpLatLng.longitude));
    }

    else if(pickUpLatLng.latitude>dropOffLatLng.latitude)
      {
        latLngBounds=LatLngBounds(southwest: LatLng(dropOffLatLng.latitude,pickUpLatLng.longitude), northeast:LatLng(pickUpLatLng.latitude,dropOffLatLng.longitude) );
      }
    else{
      latLngBounds=LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }
    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
    Marker pickUpLocMarker=Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: initialPos.placeName,snippet: "my Location"),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId"),
    );
    Marker dropOffLocMarker=Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: finalPos.placeName,snippet: "Hospital Location"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffId"),
    );
    setState(() {
      markerSet.add(pickUpLocMarker);
      markerSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle= Circle(
      fillColor: Colors.deepOrange,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor:Colors.deepOrangeAccent,
      circleId: CircleId("pickUpId")
    );
    Circle dropOffLocCircle= Circle(
        fillColor: Colors.greenAccent,
        center: pickUpLatLng,
        radius: 12,
        strokeWidth: 4,
        strokeColor:Colors.green,
        circleId: CircleId("dropOffId")
    );
    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });

  }

}
