part of 'tenant_upate_bloc.dart';

@immutable
sealed class TenantUpateEvent {}

class SetTenantUpateEvent extends TenantUpateEvent {
  final Tenant myTenant;
  SetTenantUpateEvent(this.myTenant);
}

class GetTenantUpateEvent extends TenantUpateEvent {}
