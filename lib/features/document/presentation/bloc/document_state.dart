part of 'document_bloc.dart';

@immutable
abstract class DocumentState {}

class NoDocumentsUploaded extends DocumentState {
}

class DocumentsUploaded extends DocumentState {
  final List<File> files;

  DocumentsUploaded({required this.files});
}