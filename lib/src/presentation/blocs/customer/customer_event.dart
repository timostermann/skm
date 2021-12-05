part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {}

class CustomerUpdateFields extends CustomerEvent {
  final Customer customer;

  CustomerUpdateFields(this.customer);
}
