part of 'tenant_upate_bloc.dart';

@immutable
sealed class TenantUpateState {
  final Tenant myTenant;
  const TenantUpateState(this.myTenant);
}

final class TenantUpateInitial extends TenantUpateState {
  const TenantUpateInitial(super.isUpdate);
}
