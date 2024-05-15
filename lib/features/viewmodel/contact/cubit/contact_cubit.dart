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

  /// The function `pickImageWithCamera` captures an image using the device's camera and returns the file
  /// path of the captured image.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter in the `pickImageWithCamera` function is of type
  /// `BuildContext`. It is typically used in Flutter to access information about the widget tree and to
  /// navigate between different screens or widgets. In this function, the `context` parameter is likely
  /// being used to read a service cub
  ///
  /// Returns:
  ///   The function `pickImageWithCamera` returns a `Future<String?>`.
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

  /// The function `pickImageWithGallery` allows the user to pick an image from the gallery and returns
  /// the image path if successful.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter in the `pickImageWithGallery` function is of
  /// type `BuildContext`. It is used to access information about the location in the widget tree where
  /// the function is being called, such as the theme, media query data, and ancestor widgets. In this
  /// function, the `context
  ///
  /// Returns:
  ///   The function `pickImageWithGallery` returns a `Future<String?>`.
  Future<String?> pickImageWithGallery(BuildContext context) async {
    try {
      imagePath = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      if (imagePath != null) {
        emit(PhotoAddedSuccess(imagePath!.path));

        if (context.mounted) {
          context.read<ServiceCubit>().imagePath = imagePath!.path;
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
