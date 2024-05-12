part of 'service_cubit.dart';

sealed class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

final class ServiceInitial extends ServiceState {}

final class FetchContactsSuccess extends ServiceState {
  final List<User>? contactList;

  const FetchContactsSuccess({required this.contactList});

  @override
  List<Object> get props => [];
}

final class FetchContactsFailure extends ServiceState {}

final class DeletedUserSuccess extends ServiceState {}

final class LoadingState extends ServiceState {}

final class AddedContactSuccess extends ServiceState {}
