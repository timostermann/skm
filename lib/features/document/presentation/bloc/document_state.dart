part of 'document_bloc.dart';

@immutable
abstract class DocumentState {
  final Cache cache;

  DocumentState(this.cache);
}

class NoDocumentsUploaded extends DocumentState {
  final Cache cache;

  NoDocumentsUploaded({required this.cache}): super(cache);
}

class DocumentsUploaded extends DocumentState {
  final List<File> files;
  final Cache cache;

  DocumentsUploaded({required this.files, required this.cache}): super(cache);
}

class DocumentsLoading extends DocumentState {
  final Cache cache;

  DocumentsLoading({required this.cache}): super(cache);
}
