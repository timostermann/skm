import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skm_services/components/sk_button.dart';
import 'package:skm_services/features/document/pdf.dart';
import 'package:skm_services/features/document/presentation/bloc/document_bloc.dart';
import 'package:skm_services/styles.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

class DocumentScreen extends StatefulWidget {
  final CustomPainter? painter;

  const DocumentScreen({Key? key, this.painter}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState(painter: painter);
}

class _DocumentScreenState extends State<DocumentScreen> {
  final picker = ImagePicker();
  final CustomPainter? painter;
  bool pdfCreated = false;

  _DocumentScreenState({required this.painter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        print(state.cache.screenshot);
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: SkColors.main700,
            centerTitle: true,
            title: SvgPicture.asset(
              'assets/icons/logo_white_small.svg',
              height: 35,
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  SkColors.main700,
                  SkColors.main600,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.6, 1],
              ),
            ),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 32,
                            left: 12,
                          ),
                          child: Text(
                            "Bilder",
                            style: TextStyle(
                              color: SkColors.main300,
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 12,
                          ),
                          child: Text(
                            "Fügen Sie nun optional noch Bilder der Einbausituation hinzu.",
                            style: TextStyle(
                              color: SkColors.main300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 40,
                            left: 12,
                          ),
                          child: Text(
                            "Anschließend können Sie ihr Aufmaß als PDF-Dokument exportieren.",
                            style: TextStyle(
                              color: SkColors.main300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: SkColors.main400,
                              border: Border.all(
                                color: SkColors.accent600,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            constraints:
                                BoxConstraints(minHeight: 300, minWidth: 2000),
                            child: (state is NoDocumentsUploaded)
                                ? Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.hide_image,
                                            size: 40,
                                          ),
                                        ),
                                        Text("Keine Bilder hinzugefügt"),
                                      ],
                                    ),
                                  )
                                : (state is DocumentsUploaded)
                                    ? Expanded(
                                        flex: 10,
                                        child: Wrap(
                                            alignment:
                                                WrapAlignment.spaceEvenly,
                                            children: state.files
                                                .map(
                                                  (file) => Container(
                                                    child: Image.file(file),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    height: 250,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                  ),
                                                )
                                                .toList()
                                                .cast<Widget>()),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: SkColors.accent600,
                                        ),
                                      ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SkButton(
                              onTap: () async {
                                if (state is! DocumentsLoading) {
                                  context
                                      .read<DocumentBloc>()
                                      .add(ToggleLoadingEvent());
                                  final List<XFile>? images = await picker
                                      .pickMultiImage(imageQuality: 10);
                                  context
                                      .read<DocumentBloc>()
                                      .add(ToggleLoadingEvent());
                                  if (images != null) {
                                    final List<File> files = images
                                        .map((image) => File(image.path))
                                        .toList();
                                    if (state is DocumentsUploaded) {
                                      context.read<DocumentBloc>().add(
                                              UpdateDocumentsEvent(files: [
                                            ...state.files,
                                            ...files
                                          ]));
                                      print(state.files.length);
                                    } else {
                                      context.read<DocumentBloc>().add(
                                          UpdateDocumentsEvent(files: files));
                                    }
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.collections,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: Text(
                                        "Bilder hinzufügen",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: SkButton(
                                onTap: () async {
                                  if (state is! DocumentsLoading) {
                                    context
                                        .read<DocumentBloc>()
                                        .add(ToggleLoadingEvent());
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 10);
                                    context
                                        .read<DocumentBloc>()
                                        .add(ToggleLoadingEvent());
                                    if (image != null) {
                                      final File file = File(image.path);
                                      if (state is DocumentsUploaded) {
                                        context.read<DocumentBloc>().add(
                                            UpdateDocumentsEvent(
                                                files: [...state.files, file]));
                                      } else {
                                        context.read<DocumentBloc>().add(
                                            UpdateDocumentsEvent(
                                                files: [file]));
                                      }
                                    }
                                  }
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: Text(
                                          "Bild aufnehmen",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  SkButton(
                                  onTap: () async {
                                    final pdfFile = await Pdf.generatePDF(
                                        [
                                          pdfWidgets.Column(
                                            children: [
                                              pdfWidgets.Padding(
                                                padding: const pdfWidgets
                                                    .EdgeInsets.only(bottom: 24),
                                                child: pdfWidgets.Row(
                                                  children: [
                                                    pdfWidgets.Text(
                                                      "Kundendaten",
                                                      style: pdfWidgets.TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text("Vorname: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text("Nachname: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text(
                                                    "Straße & Hausnummer: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text("PLZ: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text("Ort: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text(
                                                    "Telefonnummer: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text("E-Mail: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Row(children: [
                                                pdfWidgets.Text("Kundenummer: "),
                                                pdfWidgets.Text(getCustomerValue(
                                                    state.cache.customer
                                                        .firstName)),
                                              ]),
                                              pdfWidgets.Padding(
                                                padding: const pdfWidgets
                                                        .EdgeInsets.symmetric(
                                                    vertical: 24),
                                                child: pdfWidgets.Row(
                                                  children: [
                                                    pdfWidgets.Text(
                                                      "Bilder",
                                                      style: pdfWidgets.TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              pdfWidgets.Wrap(
                                                  alignment: pdfWidgets
                                                      .WrapAlignment.spaceEvenly,
                                                  children: state.cache.files
                                                      .map(
                                                        (file) =>
                                                            pdfWidgets.Container(
                                                          child: pdfWidgets.Image(
                                                              pdfWidgets
                                                                  .MemoryImage(file
                                                                      .readAsBytesSync())),
                                                          padding: const pdfWidgets
                                                              .EdgeInsets.all(8),
                                                          height: 250,
                                                          width: 200,
                                                          decoration: pdfWidgets
                                                              .BoxDecoration(
                                                            borderRadius: pdfWidgets
                                                                    .BorderRadius
                                                                .circular(5.0),
                                                          ),
                                                        ),
                                                      )
                                                      .toList()
                                                      .cast<pdfWidgets.Widget>()),
                                              pdfWidgets.Padding(
                                                padding: const pdfWidgets
                                                        .EdgeInsets.symmetric(
                                                    vertical: 24),
                                                child: pdfWidgets.Row(
                                                  children: [
                                                    pdfWidgets.Text(
                                                      "Skizze",
                                                      style: pdfWidgets.TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              pdfWidgets.Image(
                                                  pdfWidgets.MemoryImage(
                                                      state.cache.screenshot!),
                                                  height: 500),
                                            ],
                                          )
                                        ],
                                        (state.cache.customer.firstName ??
                                                "vorname") +
                                            "_" +
                                            (state.cache.customer.lastName ??
                                                "nachname") +
                                            "_" +
                                            (state.cache.customer.id ?? "id"));
                              
                                    Pdf.openFile(pdfFile);
                                    setState(() {
                                      pdfCreated = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Text(
                                            "PDF-Export",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pdfCreated ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                                  child: SkButton(
                                    onTap: () {
                                      Phoenix.rebirth(context);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Icon(
                                            Icons.cached,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Text(
                                              "Neu starten",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ) : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String getCustomerValue(String? field) {
  if (field != null && field.trim() != "") {
    return field;
  } else {
    return "k. A.";
  }
}
