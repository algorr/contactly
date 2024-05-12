import 'package:flutter/widgets.dart';

class ContactListItemText extends StatelessWidget {
  const ContactListItemText(
      {super.key, required this.text, required this.style});
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
