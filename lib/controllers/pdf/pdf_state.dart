part of 'pdf_cubit.dart';

@immutable
abstract class PDFState {}

class PDFInitial extends PDFState {}

class PDFSuccess extends PDFState {}

class PDFFailure extends PDFState {
  final String? errMessager;

  PDFFailure({this.errMessager});
}
