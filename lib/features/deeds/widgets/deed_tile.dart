import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/deed.dart';
import '../../initialization/controllers/language_controller.dart';
import '../controllers/deeds_controller.dart';

class DeedTile extends ConsumerStatefulWidget {
  final Deed deed;
  const DeedTile({
    super.key,
    required this.deed,
  });

  @override
  ConsumerState<DeedTile> createState() => _DeedTileState();
}

class _DeedTileState extends ConsumerState<DeedTile> {
  @override
  Widget build(BuildContext context) {
    final isEnglish = ref.watch(languageIsEnglishProvider);
    ref.watch(deedsProvider);
    // final languageIsEnglish = ref.watch(languageIsEnglishProvider);
    return Card(
      child: ListTile(
        leading: CupertinoCheckbox(
          value: ref.watch(deedsProvider.notifier).getIsDoneStatus(widget.deed),
          onChanged: (value) {
            ref.read(deedsProvider.notifier).markAsDone(widget.deed, value!);
          },
        ),
        title: Text(!isEnglish ? widget.deed.titleBn : widget.deed.titleEn),
        // trailing: CircleAvatar(
        //   radius: 12,
        //   child: Padding(
        //     padding: const EdgeInsets.all(1.0),
        //     child: CircleAvatar(
        //       child: Text(
        //         widget.deed.id.toString(),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
