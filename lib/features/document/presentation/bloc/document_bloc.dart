import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skm_services/models/cache.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final Cache cache;

  DocumentBloc(this.cache)
      : super(cache.files.isEmpty
            ? NoDocumentsUploaded(cache: cache)
            : DocumentsUploaded(files: cache.files, cache: cache)) {
    on<DocumentEvent>((event, emit) {
      if (event is UpdateDocumentsEvent) {
        cache.files = event.files;
        emit(DocumentsUploaded(files: event.files, cache: cache));
      }

      if (event is ToggleLoadingEvent) {
        if (state is DocumentsLoading) {
          emit(DocumentsUploaded(files: cache.files, cache: cache));
        } else {
          emit(DocumentsLoading(cache: cache));
        }
      }
    });
  }
}