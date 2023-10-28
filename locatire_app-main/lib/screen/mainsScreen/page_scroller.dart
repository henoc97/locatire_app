import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locataireapp/API_engine/link_property_tenant.dart/query_property_tenant_by_tenant_id.dart';
import 'package:locataireapp/service/bloc/tenant_upate_bloc.dart';
import 'package:locataireapp/service/bloc/update_picture_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../API_engine/property_engine/query_property_by_id.dart';
import '../../colors/colorsrepertory.dart';
import '../../model/property.dart';
import '../../model/property_tenant.dart';
import '../../model/tenant.dart';
import 'itemsScreens/calendar.dart';
import 'itemsScreens/history.dart';
import 'itemsScreens/notiification_page.dart';
import 'itemsScreens/paiement.dart';
import 'itemsScreens/profil_page.dart';
import 'itemsScreens/support_client.dart';

class PageScroller extends StatefulWidget {
  const PageScroller({super.key, required this.myTenant});

  final Tenant myTenant;

  @override
  State<PageScroller> createState() => _PageScrollerState();
}

class _PageScrollerState extends State<PageScroller> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<String> itemNames = [
    "Notifications",
    "Calendrier de paiement",
    "Historique de paiement",
    "Support clientel",
    "Paiement"
  ];
  List<String> itemsDescription = [
    "Notifications et envoie des rappels du paiement de loyer",
    "Dates d'échéance des paiements de loyer",
    "Détail sur tous les paiements de loyer passés",
    "En cas de questions ou de problèmes, contactez nous",
    "Procédure de paiement par flooz ou TMoney"
  ];

  int _index = 2;

  PropertyTenant? _myPropertyTenant;
  PropertyTenant? get myPropertyTenant => _myPropertyTenant;
  set myPropertyTenant(PropertyTenant? value) {
    setState(() {
      _myPropertyTenant = value;
    });
  }

  Property? _myProperty;
  Property? get myProperty => _myProperty;
  set myProperty(Property? value) {
    setState(() {
      _myProperty = value;
    });
  }

  bool _showDrawer = false;
  bool get showDrawer => _showDrawer;
  set showDrawer(bool value) {
    setState(() {
      _showDrawer = value;
    });
  }

  @override
  void initState() {
    super.initState();
    setMyPropertyTenant();
  }

  void setMyPropertyTenant() async {
    print("tenantID : ${widget.myTenant.tenantID}");
    myPropertyTenant =
        await queryPropertyTenantByTenantID(widget.myTenant.tenantID);
    print("myPropertyTenant : ${myPropertyTenant?.propertyID}");
    if (myPropertyTenant != null) {
      print("myPropertyTenant!.propertyID : ${myPropertyTenant!.propertyID}");
      myProperty =
          await queryPropertyByID(myPropertyTenant!.propertyID.toString());
      print("myProperty : $myProperty");
    } else {
      myPropertyTenant =
          await queryPropertyTenantByTenantID(widget.myTenant.tenantID);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;

    return Scaffold(
      backgroundColor: clr["white"],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: clr["white"]!,
        color: clr["blackBlue"]!,
        buttonBackgroundColor: clr["blue"],
        index: _index,
        height: 40.h,
        animationCurve: Curves.fastOutSlowIn,
        items: <Widget>[
          FaIcon(
            Icons.notification_important,
            color: clr["white"],
          ),
          FaIcon(
            FontAwesomeIcons.solidCalendarDays,
            color: clr["white"],
          ),
          FaIcon(
            FontAwesomeIcons.clockRotateLeft,
            color: clr["white"],
          ),
          Icon(
            Icons.contact_support,
            color: clr["white"],
          ),
          Icon(
            FontAwesomeIcons.moneyBill,
            color: clr["white"],
          ),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            _index = index;
          });
        },
      ),
      body: SafeArea(
        child: BlocBuilder<UpdatePictureBloc, UpdatePictureState>(
          builder: (context, state) {
            return BlocBuilder<TenantUpateBloc, TenantUpateState>(
              builder: (context, stateTenantUpate) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDrawer = !showDrawer;
                                },
                                icon: const Icon(Icons.more_vert_outlined),
                              ),
                              Text(
                                itemNames[_index],
                                style: TextStyle(
                                    fontFamily: "Pacificoo",
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              ProfilPage(
                                                ourTenant: widget.myTenant,
                                              )));
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/avatar/${state.pic}.jpg")),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: size.height * .03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: size.width * .9,
                                  child: Text(
                                    itemsDescription[_index],
                                    style: TextStyle(
                                      fontFamily: "EBGaramond",
                                      fontSize: 16.sp,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                            child: _index == 1
                                ? Calendar(
                                    myTenant: widget.myTenant,
                                  )
                                : _index == 2
                                    ? History(
                                        myTenant: widget.myTenant,
                                        myProperty: myProperty ??
                                            Property(0, "0", "0", "0"),
                                      )
                                    : _index == 3
                                        ? SupportClient(
                                            myTenant: widget.myTenant)
                                        : _index == 4
                                            ? Paiement(
                                                myTenant: widget.myTenant,
                                                myProperty: myProperty ??
                                                    Property(0, "0", "0", "0"),
                                              )
                                            : NotificationPage(
                                                myTenant: widget.myTenant,
                                              )),
                      ],
                    ),
                    showDrawer
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 50),
                            child: Card(
                              color: Colors.white,
                              child: SizedBox(
                                height: size.height * .2,
                                width: size.width * .5,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            openFileManager();
                                            print("ok");
                                          },
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.receipt,
                                                color: clr["blue"],
                                              ),
                                              Text(
                                                "    Tous mes reçus",
                                                style: TextStyle(
                                                  fontFamily: "EBGaramond",
                                                  fontSize: 16.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            sendEmail();
                                          },
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.phone,
                                                color: clr["blue"],
                                              ),
                                              Text(
                                                "    Contactez nous",
                                                style: TextStyle(
                                                  fontFamily: "EBGaramond",
                                                  fontSize: 16.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            myApplaunchURL(
                                                "https://drive.google.com/drive/u/0/my-drive");
                                          },
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.share,
                                                color: clr["blue"],
                                              ),
                                              Text(
                                                "    Mis à jours",
                                                style: TextStyle(
                                                  fontFamily: "EBGaramond",
                                                  fontSize: 16.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Fonction pour ouvrir un lien URL
  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'amaviganhenoc@gmail.com',
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        print('Impossible d\'ouvrir l\'application de messagerie.');
      }
    } catch (e) {
      print("e : $e");
    }
  }

  void openFileManager() {
    try {
      final platform = Theme.of(context).platform;
      try {
        if (platform == TargetPlatform.android) {
          // Intent pour ouvrir le gestionnaire de fichiers sur Android
          try {
            const MethodChannel('open_file')
                .invokeMethod('open_file', {'path': '/'});
          } catch (e) {
            print("e : $e");
          }
        }
      } catch (e) {
        print("e1 : $e");
      }
    } catch (e) {
      print("e2 : $e");
    }
  }

  //

  // Fonction pour ouvrir un lien URL
  myApplaunchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }

  Future<void> openDirectory() async {
    final directoryPath =
        '/storage/emulated/0/Android/data/com.example.locataireapp/files/pppppoooiiiuuuu1'; // Le chemin du répertoire que vous souhaitez ouvrir

    try {
      if (await Directory(directoryPath).exists()) {
        final result = await OpenFile.open(directoryPath);

        if (result.type == ResultType.done) {
          print('Directory opened successfully');
        } else {
          print('Error opening directory: ${result.message}');
        }
      } else {
        print('Directory does not exist');
      }
    } catch (e) {
      print(e);
    }
  }
}
