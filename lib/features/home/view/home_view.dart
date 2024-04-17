import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/app_bar.dart';
import '../../../core/constants/pngs.dart';
import '../../salah/controllers/salah_controller.dart';
import '../widgets/grid.dart';
import '../widgets/meter.dart';
import '../widgets/salah_timer.dart';

class HomeView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    ref.read(salahProvider.notifier).getPrayerTimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(salahProvider.notifier).getPrayerTimes();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Pngs.arabicBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                needBackButton: false,
                title: 'Al-Tasheel',
              ),
              const Meter(),
              const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Grid(),
              ),
              const SalahTimer(),
            ],
          ),
        ),
      ),
    );
  }
}
