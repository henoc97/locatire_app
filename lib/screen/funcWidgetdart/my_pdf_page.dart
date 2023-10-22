import 'dart:convert';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../colors/colorsrepertory.dart';
import '../../model/property.dart';
import '../../model/received.dart';
import '../../model/tenant.dart';
import '../../myfunctions/current_date.dart';

class MyPdfPage extends StatefulWidget {
  const MyPdfPage({super.key, this.received, this.myTenant, this.myProperty});

  final Received? received;
  final Tenant? myTenant;
  final Property? myProperty;

  @override
  State<MyPdfPage> createState() => _MyPdfPageState();
}

class _MyPdfPageState extends State<MyPdfPage> {

  String _localFile = '';
  String get localFile => _localFile;
  set localFile(String value) {
    setState(() {
      _localFile = value;
    });
  }

  @override
  void initState() {
    super.initState();
    generateAndSavePDF();
  }
  @override
  Widget build(BuildContext context) {
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Scaffold(
      body: localFile == ''? Center(child: CircularProgressIndicator(color: clr["blue"],)) : PDFView(
        filePath: localFile,
        enableSwipe: true,
        swipeHorizontal: true,
      ),

    );
  }
  

Future<pw.Font> loadCustomFont() async {

  final fontData = await rootBundle.load("assets/fonts/HelveticaNeueLight.ttf");
final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  return ttf;
}

Future<void> generateAndSavePDF() async {
  final pdf = pw.Document();

final ByteData data = await rootBundle.load('assets/photo/sign1.jpeg');
final Uint8List bytes = data.buffer.asUint8List();

  var size = MediaQuery.of(context).size;
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Container(
          //margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: size.height*.9,
          decoration: pw.BoxDecoration(
            color: PdfColors.white,//clr['blue']?.withOpacity(0.5),
              border: pw.Border.all(
                  color: PdfColors.black, width: 1, style: pw.BorderStyle.solid),
              borderRadius: pw.BorderRadius.circular(5)),
          child: pw.Stack(

            children: [
              pw.Center(
                child: pw.Transform.rotate(
                            angle: 70 * 3.141592653589793 / 180,
                            child: pw.Text(
                              "QUITTANCE DE LOYER",
                              style: pw.TextStyle(
                                  fontSize: 42.sp,
                                  font: pw.Font.helveticaBold(),
                                  color:  PdfColors.blueGrey200),
                            ),
                          ),
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4.0),
                      child: pw.Text("QUITTANCE DE LOYER", style: pw.TextStyle(color:const PdfColor(0.08, 0.56, 0.65, 0.8),
                              fontSize: 22.sp,
                              fontWeight: pw.FontWeight.bold,
                              font: pw.Font.helvetica()                            ),),
                    )
                  ],),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        
                        pw.SizedBox(
                          width: size.width*.35,
                          child: pw.RichText(
                              text: pw.TextSpan(
                                  //style: pw.DefaultTextStyle.of(context).style,
                                  children: [
                                pw.TextSpan(
                                    text: "Reçu N° :  ",
                                    style: pw.TextStyle(
                                      fontSize: 14.sp,
                                      font: pw.Font.helvetica()   
                                    )),
                                pw.TextSpan(
                                    text: "${widget.myProperty!.propertyID + widget.myTenant!.tenantID}" ,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 14.sp,
                                      font: pw.Font.helvetica()   
                                    ))
                              ])),
                        )
                      ],
                    ),
                  ),
                
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right : 20.0, left: 20.0, bottom: 3, top: 3),
                      child: pw.Column(children: [
                        pw.SizedBox(width: size.width*.45,
                          child: pw.Text("Propiétaire : ",style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14.sp,
                              font: pw.Font.helvetica(),
                              color:const PdfColor(0.08, 0.56, 0.65, 0.8),
                                            )),
                        ),
                        pw.SizedBox(width: size.width*.45, child: pw.Text("Nom : ANAGO ",style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.sp,
                              font: pw.Font.helvetica()   
                              //color: clr["blue"],
                                            ))),
                        pw.SizedBox(width: size.width*.45, child: pw.Text("Prénoms : Séna",style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.sp,
                              font: pw.Font.helvetica()   
                              //color: clr["blue"],
                                            ))),
                        pw.SizedBox(width: size.width*.45, child: pw.Text("Tel : 00000000 / 00000000   ",style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.sp,
                              font: pw.Font.helvetica()   
                              //color: clr["blue"],
                                            ))),
                
                      ],),
                    ),
                
                    pw.Container(height: size.height*.1, width: 2, color: PdfColors.grey),
                
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5.0),
                      child: pw.Column(children: [
                        pw.SizedBox(width: size.width*.45,
                          child: pw.Text("Locataire : ",style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14.sp,
                              color: const PdfColor(0.08, 0.56, 0.65, 0.8),
                              font: pw.Font.helvetica()   
                                            )),
                        ),
                        pw.SizedBox(width: size.width*.45, child: pw.Text("Nom : ${widget.myTenant!.tenantName}",
                        style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.sp,
                              font: pw.Font.helvetica()   
                              //color: clr["blue"],
                              
                                            ))),
                        pw.SizedBox(width: size.width*.45, child: pw.Text("Prénoms : ${widget.myTenant!.tenantLastName}",
                        style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.sp,
                              font: pw.Font.helvetica()   
                              //color: clr["blue"],
                                            ))),
                        pw.SizedBox(width: size.width*.45, child: pw.Text("Tel :${widget.myTenant!.tenantContact1} / ${widget.myTenant!.tenantContact2}",
                        style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13.sp,
                              font: pw.Font.helvetica()   
                              //color: clr["blue"],
                            
                                            ))),
                
                      ],),
                    ),
                  ],),
                  
                
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Container(
                      decoration: pw.BoxDecoration(border: pw.Border.all(color:const PdfColor(0.08, 0.56, 0.65, 0.8) )),
                      
                      child: pw.RichText(
                              text: pw.TextSpan(
                                  //style: pw.DefaultTextStyle.of(context).style,
                                  children: [
                                    pw.TextSpan(
                                        text: "  Quittance de loyer du mois de : ",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                    pw.TextSpan(
                                        text: "${widget.received!.monthPayed}   ",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                    
                                    
                                  ]),
                            ),
                    ),
                  ),
                  
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.SizedBox(width: size.width,
                          child: pw.Column(
                            children: [
                              pw.RichText(
                                  text: pw.TextSpan(
                                      //style: pw.DefaultTextStyle.of(context).style,
                                      children: [
                                    pw.TextSpan(
                                        text: "Je soussigné Mr : ",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                        pw.TextSpan(
                                        text:
                                            " ANAGO Séna, ",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                    pw.TextSpan(
                                        text:
                                            " agissant en tant que bailleur du logement à l'adresse suivante : ",
                                        style: pw.TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                        pw.TextSpan(
                                        text:
                                            "${widget.myProperty!.propertyAddress} ",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                        pw.TextSpan(
                                        text:
                                            ", déclare avoir reçu de la part de Mr/Mme",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                        pw.TextSpan(
                                        text:
                                            " ${widget.myTenant!.tenantName} ${widget.myTenant!.tenantLastName}",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica(),   
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                        pw.TextSpan(
                                        text:
                                            " la somme de",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica()   
                                        )),
                                        pw.TextSpan(
                                        text:
                                            "  ${widget.received!.sumPayed}  francs cfa",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                          font: pw.Font.helvetica(),   
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                        pw.TextSpan(
                                        text:
                                            " le ",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                        )),
                
                                        pw.TextSpan(
                                        text:
                                            " ${widget.received!.dateReceived}",
                                        style: pw.TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: pw.FontWeight.bold,
                                          font: pw.Font.helvetica()   
                                        )),
                                  ])),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.RichText(
                            text: pw.TextSpan(
                                //style: pw.DefaultTextStyle.of(context).style,
                                children: [
                              pw.TextSpan(
                                  text: "Fait à Lomé, TOGO, le : ",
                                  style: pw.TextStyle(
                                    fontSize: 14.sp,
                                    font: pw.Font.helvetica()   
                                  )),
                              pw.TextSpan(
                                  text:
                                      "${formatDate(DateTime.now())[0]}/${formatDate(DateTime.now())[1]}/${formatDate(DateTime.now())[2]}",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 14.sp,
                                    font: pw.Font.helvetica()   
                                  ))
                            ])),
                      ],
                    ),
                  ),
                
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20.0),
                    child: pw.Text("Le locataire doit conserver cette preuve de paiement pendant toute la durée du contrat de bail qui le lie au bailleur.",
                    style: pw.TextStyle(
                      color :  const PdfColor(0.08, 0.56, 0.65, 0.8),
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14.sp,
                      font: pw.Font.helvetica()   
                                  )
                    ),
                  ),
          
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20.0),
                    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text("Signature :",style: pw.TextStyle(
                    
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14.sp,
                      font: pw.Font.helvetica()   
                                  )),
                      ],
                    ),
                  ),
                  
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [pw.Padding(
                      padding:  const pw.EdgeInsets.all(10.0),
                      child: pw.Image(pw.MemoryImage(bytes),width: 125, height: 100),
                    ),
                      
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(15.0),
                        child: pw.Transform.rotate(
                          angle: 40 * 3.141592653589793 / 180,
                          child: pw.Text(
                            "payé".toUpperCase(),
                            style: pw.TextStyle(
                              
                                fontSize: 30.sp,
                                font: pw.Font.helveticaBold(),
                                color: const PdfColor(1,0,0,1)),
                          ),
                        ),
                      )
                    ],
                  ),
                  
                ],
              ),
            ],
          ),
        );
        
        
        
        /*pw.Center(
          child: pw.Text(
            "Bonjour, je suis a l' ecole14 ",
            //String.fromCharCodes(encodedText),
            style: pw.TextStyle(font: pw.Font.helvetica(),),
            
          ),
        );*/
      },
    ),
  );

try {
    // Enregistrez le PDF sur l'appareil
    final output = await getDownloadsDirectory();
    final file = File("${output!.path}/${widget.myProperty!.propertyAddress}_${widget.myTenant!.tenantName}_${widget.received!.receivedID}.pdf");
    if (!file.existsSync()) {
      await file.writeAsBytes(await pdf.save());
    }
    
    
    /*if (await Permission.storage.request().isGranted) {
    
  } else {
    print("Permission de stockage refusée");
  }*/
  final newDirectory = Directory("/storage/emulated/0/je");
    if (!newDirectory.existsSync()) {
      try {
        newDirectory.createSync(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    // Vérifiez si le fichier a été correctement sauvegardé
    if (await file.exists()) {
      print("Fichier PDF sauvegardé avec succès : ${file.path}");
      localFile = file.path;
    } else {
      print("Erreur lors de la sauvegarde du fichier PDF.");
    }
  } catch (e) {
    print("Erreur lors de la création ou de la sauvegarde du fichier PDF : $e");
  }
/*
  final appDocDir = await getApplicationDocumentsDirectory();
  final file = File('${appDocDir.path}/example.pdf');
  await file.writeAsBytes(await pdf.save());
  print('Chemin du fichier PDF : ${file.path}');

  await OpenFile.open(file.path);*/
}

}
