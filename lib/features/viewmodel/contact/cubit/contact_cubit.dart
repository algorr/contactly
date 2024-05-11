import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../view/home/mixin/add_photo_mixin.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> with AddPhotoMixin {
  ContactCubit() : super(ContactInitial());
  final ImagePicker imagePicker = ImagePicker();

  Future<void> homeAddContactPhoto(
    BuildContext context,
    Size size,
  ) async {
    final image = await homeAddPhotoBottomSheet(context, size, imagePicker);
    if (image != null) {
      emit(PhotoAddedSuccess(image));
    }
  }
}
