part of 'contact_cubit.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

final class ContactInitial extends ContactState {}

final class PhotoAddedFailure extends ContactState {}

final class PhotoAddedSuccess extends ContactState {
  final String photoUrl;

  const PhotoAddedSuccess(this.photoUrl);

  @override
  List<Object> get props => [photoUrl];
}

final class ChangedEditPressed extends ContactState {
  bool isEditPressed;

  ChangedEditPressed(this.isEditPressed);

  @override
  List<Object> get props => [isEditPressed];

  get editPressed => isEditPressed;
}
