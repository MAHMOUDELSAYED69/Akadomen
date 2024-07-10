part of 'invoice_cubit.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class Incremet extends InvoiceState {}

class Decrement extends InvoiceState {}

class InvoiceSuccess extends InvoiceState {}

class InvoiceFailure extends InvoiceState {}
