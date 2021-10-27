part of 'document_bloc.dart';

@immutable
abstract class DocumentEvent {}

class UpdateDocumentsEvent extends DocumentEvent {
  final List<File> files;

  UpdateDocumentsEvent({required this.files});
}
