import 'package:contactly/features/view/home/widgets/add_photo_sheet_column.dart';
import 'package:flutter/material.dart';

class BottomSheetTabView extends StatefulWidget {
  const BottomSheetTabView({super.key, required this.size});
  final Size size;

  @override
  State<BottomSheetTabView> createState() => _BottomSheetTabViewState();
}

class _BottomSheetTabViewState extends State<BottomSheetTabView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AddPhotoSheetColumn(
      size: widget.size,
    );
  }
}
