import 'package:barometer_of_imaan/core/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import '../../../features/home/view/settings_screen.dart';
import '../../../features/home/widgets/top_sheet.dart';
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

  Future<void> _showTopModal(BuildContext context) async {
    await showTopModalSheet(
      context,
      const DummyModal(),
      backgroundColor: Colors.white,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnglish = ref.watch(languageIsEnglishProvider);

    return SafeArea(
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (needBackButton)
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Card(
                  color: Palette.liteGrey,
                  surfaceTintColor: Palette.liteGrey,
                  child: IconButton(
                    onPressed: onBackPressed ??
                        () {
                          Navigator.of(context).pop();
                        },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Palette.grey,
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(null),
                  ),
                ),
              ),
            !needBackButton
                ? IconButton(
                    onPressed: () => _showTopModal(context),
                    icon: const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  )
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(SettingsScreen.route());
                },
                child: const Card(
                  color: Palette.liteGrey,
                  surfaceTintColor: Palette.liteGrey,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.menu,
                      color: Palette.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
