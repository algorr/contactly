import 'package:contactly/core/extensions/string_capitalize.dart';
import 'package:contactly/features/view/home/widgets/contact_list_item_text.dart';
import 'package:flutter/material.dart';

mixin ContactListTextMixin {
  ContactListItemText nameAndLastName(
      BuildContext context, String? name, String? lastName) {
    return ContactListItemText(
        text: name != null || lastName != null
            ? '${name?.capitalize()} $lastName'
            : '',
        style: Theme.of(context).textTheme.titleMedium!);
  }
}
