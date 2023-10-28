import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/tenant.dart';

part 'tenant_upate_event.dart';
part 'tenant_upate_state.dart';

class TenantUpateBloc extends Bloc<TenantUpateEvent, TenantUpateState> {
  TenantUpateBloc()
      : super(TenantUpateInitial(Tenant(0, '0', '0', '0', '0', '0'))) {
    on<SetTenantUpateEvent>((event, emit) {
      emit(TenantUpateInitial(event.myTenant));
    });
    on<GetTenantUpateEvent>((event, emit) {
      emit(state);
    });
  }
}
