import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/initialization/controllers/language_controller.dart';

// ignore: must_be_immutable
class CustomAppBar extends ConsumerWidget {
  final String title;
  final bool needBackButton;
  Function()? onBackPressed;

  CustomAppBar({
    super.key,
    required this.title,
    this.needBackButton = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnglish = ref.watch(languageIsEnglishProvider);

    return SafeArea(
      child: SizedBox(
        height: 65,
        child: Row(
          children: [
            if (needBackButton)
              IconButton(
                onPressed: onBackPressed ??
                    () {
                      Navigator.of(context).pop();
                    },
                icon: const Icon(Icons.arrow_back_ios),
              )
            else
              const SizedBox(width: 48), // Adjust width as needed

            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(languageIsEnglishProvider.notifier)
                      .toggleLanguage(!isEnglish);
                },
                child: const Icon(Icons.language),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
