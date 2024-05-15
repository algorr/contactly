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

final class FilteredState extends ServiceState {
  final List<User>? filteredUsers;

  const FilteredState({required this.filteredUsers});

  @override
  List<Object> get props => [];
}

final class FetchContactsFailure extends ServiceState {}

final class DeletedUserSuccess extends ServiceState {}

final class LoadingState extends ServiceState {}

final class AddedContactSuccess extends ServiceState {
  final User? contact;

  const AddedContactSuccess({required this.contact});

  @override
  List<Object> get props => [];
}

final class UpdatedContactSuccess extends ServiceState {
  const UpdatedContactSuccess();

  @override
  List<Object> get props => [];
}
