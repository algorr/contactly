import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../view/home/mixin/add_photo_mixin.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> with AddPhotoMixin {
  ContactCubit() : super(ContactInitial());

  final ImagePicker imagePicker = ImagePicker();
  XFile? imagePath;
  bool isEditPressed = false;

  void changeEditPressed() {
    isEditPressed = !isEditPressed;
    emit(ChangedEditPressed(isEditPressed));
  }

  Future<String?> pickImageWithCamera(BuildContext context) async {
    try {
      imagePath = await imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);

      if (imagePath != null) {
        emit(PhotoAddedSuccess(imagePath!.path));
        context.read<ServiceCubit>().imagePath = imagePath!.path;
        return imagePath?.path;
      }
      emit(PhotoAddedFailure());
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> pickImageWithGallery(BuildContext context) async {
    try {
      imagePath = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      if (imagePath != null) {
        emit(PhotoAddedSuccess(imagePath!.path));

        if (context.mounted) {
          context.read<ServiceCubit>().imagePath = imagePath!.path;
          print('PHOTO : ${context.read<ServiceCubit>().imagePath}');
        }
        return imagePath?.path;
      }
      emit(PhotoAddedFailure());
      return null;
    } catch (e) {
      return null;
    }
  }
}
