part of 'customer_bloc.dart';

@immutable
abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final Customer customer;

  CustomerLoaded({required this.customer});
}
