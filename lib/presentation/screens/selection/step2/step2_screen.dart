import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_util.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../blocs/step2/step2_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigator/route_names.dart';
import '../../../widgets/progress/custom_snackbar.dart';
import 'widgets/step2_widgets.dart';

class Step2Screen extends StatefulWidget {
  const Step2Screen({super.key});

  @override
  State<Step2Screen> createState() => Step2ScreenState();
}

class Step2ScreenState extends State<Step2Screen> {
  String selectedBooks = "";
  List<String> bookNos = [];

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final double radius = isDesktop ? size.height / 2.5 : size.width / 2.5;

    return BlocProvider(
      create: (context) => Step2Bloc()..add(FetchSongs()),
      child: BlocConsumer<Step2Bloc, Step2State>(
        listener: (context, state) {
          if (state is Step2FetchedState) {
            context.read<Step2Bloc>().add(SaveSongs(state.songs));
          } else if (state is Step2FailureState) {
            CustomSnackbar.show(
              context,
              feedbackMessage(state.feedback, l10n),
            );
          } else if (state is Step2SavedState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.main,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state.maybeWhen(
              orElse: () => SizedBox(),
              progress: () => const WaveProgress(),
              saving: (progress, feedback) => Stack(
                children: [
                  BackgroundProgress(size: size, progress: progress),
                  ForegroundProgress(
                    progress: progress,
                    radius: radius,
                    feedback: feedback,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
