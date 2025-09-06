import 'package:flutter/material.dart';
import 'package:notes/helpers/ui_helper.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;

  const NoteCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: UIHelper.cardRadius),
      child: Padding(
        padding: UIHelper.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: UIHelper.noteTitleStyle),
            UIHelper.verticalSpace8,
            Text(content, style: UIHelper.noteContentStyle),
          ],
        ),
      ),
    );
  }
}
