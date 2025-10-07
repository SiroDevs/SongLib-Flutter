part of '../step1_screen.dart';

class Step1Fab extends StatefulWidget {
  final Step1ScreenState parent;
  const Step1Fab({super.key, required this.parent});

  @override
  State<Step1Fab> createState() => Step1FabState();
}

class Step1FabState extends State<Step1Fab> {
  late Step1ScreenState parent;
  late AppLocalizations l10n;
  late Step1Bloc bloc;

  Future<void> areYouDoneDialog() async {
    if (parent.booksSelected.isNotEmpty) {
      var result = await FlutterPlatformAlert.showCustomAlert(
        windowTitle: l10n.doneSelecting,
        text: l10n.doneSelectingBody,
        iconPath: AppAssets.iconApp,
        iconStyle: IconStyle.information,
        neutralButtonTitle: l10n.cancel.toUpperCase(),
        positiveButtonTitle: l10n.proceed.toUpperCase(),
      );
      if (result == CustomButton.positiveButton) {
        bloc.add(SaveBooks('', parent.booksSelected));
      }
    } else {
      await FlutterPlatformAlert.showCustomAlert(
        windowTitle: l10n.noSelection,
        text: l10n.noSelectionBody,
        iconPath: AppAssets.iconApp,
        iconStyle: IconStyle.warning,
        neutralButtonTitle: l10n.okay.toUpperCase(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    parent = widget.parent;
    bloc = context.read<Step1Bloc>();
    l10n = AppLocalizations.of(context)!;

    return BlocBuilder<Step1Bloc, Step1State>(
      builder: (context, state) {
        return state.maybeWhen(
          progress: () => const SizedBox.shrink(),
          failure: (feedback) => const SizedBox.shrink(),
          orElse: () => FloatingActionButton.extended(
            // backgroundColor: ThemeColors.bgColorPrimary3(context),
            onPressed: () => areYouDoneDialog(),
            label: Text(
              l10n.proceed.toUpperCase(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            icon: Icon(Icons.check, color: Colors.white),
          ),
        );
      },
    );
  }
}
