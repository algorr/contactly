import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/features/model/user.dart';
import 'package:contactly/features/view/home/widgets/clickable_row.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../resources/index.dart';

class DeleteSheetColumn extends StatelessWidget {
  const DeleteSheetColumn({
    super.key,
    required this.size,
    required this.user,
  });

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: size.height * .03,
            left: size.width * .03,
            right: size.width * .03,
          ),
          child: CustomText(
              text: AppStrings.deleteSheetTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ColorManager.red)),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .01,
              left: size.width * .03,
              right: size.width * .03),
          child: ClickableRow(
            onTap: () async {
              Navigator.pop(context);
              await context
                  .read<ServiceCubit>()
                  .deleteUser(user.id!, context, size);
            },
            style: Theme.of(context).textTheme.bodyLarge!,
            title: 'Yes',
            size: size,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .01,
              left: size.width * .03,
              right: size.width * .03),
          child: ClickableRow(
            onTap: () {
              Navigator.pop(context);
            },
            title: 'No',
            size: size,
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
        ),
      ],
    );
  }
}
