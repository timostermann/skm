import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skm_services/src/data/models/cache.dart';
import 'package:skm_services/src/data/models/customer.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final Cache cache;

  CustomerBloc(this.cache) : super(CustomerInitial()) {
    on<CustomerEvent>((event, emit) async {
      if (event is CustomerUpdateFields) {
        cache.customer = event.customer;
        print(cache.customer.firstName);
        emit(CustomerLoaded(customer: event.customer));
      }
    });
  }
}
