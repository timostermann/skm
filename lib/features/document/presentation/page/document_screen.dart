import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skm_services/components/sk_button.dart';
import 'package:skm_services/features/document/pdf.dart';
import 'package:skm_services/features/document/presentation/bloc/document_bloc.dart';
import 'package:skm_services/styles.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
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
            child: Row(
              children: [
                (state is DocumentsUploaded)
                    ? SizedBox(
                        height: 300,
                        width: 100,
                        child: ListView.builder(
                            itemCount: state.files.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 50,
                                width: 100,
                                child: Center(
                                    child: Image.file(state.files[index])),
                              );
                            }),
                      )
                    : Container(
                        child: Text("Keine Bilder"),
                      ),
                SkButton(
                  onTap: () async {
                    final pdfFile = await Pdf.generatePDF(
                        pdfWidgets.Container(child: pdfWidgets.Text("Text")));

                    Pdf.openFile(pdfFile);
                  },
                  child: Text("PDF"),
                ),
                SkButton(
                  onTap: () async {
                    final picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 20);
                    if (image != null) {
                      final File file = File(image.path);
                      if (state is DocumentsUploaded) {
                        context.read<DocumentBloc>().add(UpdateDocumentsEvent(
                            files: [...state.files, file]));
                        print(state.files.length);
                      } else {
                        context
                            .read<DocumentBloc>()
                            .add(UpdateDocumentsEvent(files: [file]));
                      }
                    }
                  },
                  child: Text("Bilder"),
                ),
                SkButton(
                  onTap: () async {
                    final picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 20);
                    if (image != null) {
                      final File file = File(image.path);
                      if (state is DocumentsUploaded) {
                        context.read<DocumentBloc>().add(UpdateDocumentsEvent(
                            files: [...state.files, file]));
                        print(state.files.length);
                      } else {
                        context
                            .read<DocumentBloc>()
                            .add(UpdateDocumentsEvent(files: [file]));
                      }
                    }
                  },
                  child: Text("Bilder aus Kamera"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
