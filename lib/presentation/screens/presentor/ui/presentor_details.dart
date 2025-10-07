part of 'presentor_screen.dart';

class PresentorDetails extends StatefulWidget {
  final PresentorScreenState parent;

  const PresentorDetails({super.key, required this.parent});

  @override
  State<PresentorDetails> createState() => PresentorDetailsState();
}

class PresentorDetailsState extends State<PresentorDetails> {
  late PresentorScreenState parent;
  int currentSlide = 0;
  double fontSize = 18;
  List<String> stanzas = [];
  List<Widget> slides = [];
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    parent = widget.parent;
    focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final size = MediaQuery.of(context).size;
        setState(() {
          fontSize = calcFontSize(
            height: size.height,
            content: parent.song.content,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void setSlideByNumber(int slide) {
    setState(() {
      currentSlide = getSlideByNumber(slide, parent.hasChorus, slides.length);
    });
  }

  void setSlideByLetter(String slide) {
    setState(() {
      currentSlide = getSlideByLetter(slide, parent.hasChorus, slides.length);
    });
  }

  void setPreviousSlide() {
    if (currentSlide != 0) {
      setState(() => currentSlide = currentSlide - 1);
    }
  }

  void setNextSlide() {
    if (currentSlide < slides.length) {
      setState(() => currentSlide = currentSlide + 1);
    }
  }

  void resizeFont(bool decrease) {
    final newFontSize = decrease ? fontSize - 2.0 : fontSize + 2.0;
    final constrainedFontSize = newFontSize.clamp(12.0, 72.0);

    if (constrainedFontSize != fontSize) {
      setState(() {
        fontSize = constrainedFontSize;
        if (stanzas.isNotEmpty) {
          slides = presentorWidgets(
            parent.songTitle,
            parent.songBook,
            fontSize,
            stanzas,
          );
        }
      });

      focusNode.requestFocus();
    }
  }

  void _buildSlides(List<String> newStanzas) {
    if (newStanzas.isNotEmpty) {
      slides = presentorWidgets(
        parent.songTitle,
        parent.songBook,
        fontSize,
        newStanzas,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<PresentorBloc>(),
      builder: (context, state) {
        if (state is PresentorLoadedState) {
          if (state.stanzas.isNotEmpty || slides.isEmpty) {
            stanzas = state.stanzas;
            _buildSlides(state.stanzas);
          }

          var presentation = state.stanzas.isNotEmpty
              ? PresentorSlide(
                  key: ValueKey(currentSlide),
                  index: currentSlide,
                  songbook: parent.songBook,
                  tabs: state.tabs,
                  slides: slides,
                  indicatorWidth: MediaQuery.of(context).size.height * 0.08156,
                )
              : SizedBox();

          return Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
              SingleActivator(LogicalKeyboardKey.arrowUp): PreviousIntent(),
              SingleActivator(LogicalKeyboardKey.arrowLeft): PreviousIntent(),
              SingleActivator(LogicalKeyboardKey.arrowDown): NextIntent(),
              SingleActivator(LogicalKeyboardKey.arrowRight): NextIntent(),
              SingleActivator(LogicalKeyboardKey.minus): SmallerFontIntent(),
              SingleActivator(LogicalKeyboardKey.equal): BiggerFontIntent(),
              SingleActivator(LogicalKeyboardKey.digit1): SlideNumberIntent(1),
              SingleActivator(LogicalKeyboardKey.digit2): SlideNumberIntent(2),
              SingleActivator(LogicalKeyboardKey.digit3): SlideNumberIntent(3),
              SingleActivator(LogicalKeyboardKey.digit4): SlideNumberIntent(4),
              SingleActivator(LogicalKeyboardKey.digit5): SlideNumberIntent(5),
              SingleActivator(LogicalKeyboardKey.digit6): SlideNumberIntent(6),
              SingleActivator(LogicalKeyboardKey.digit7): SlideNumberIntent(7),
              SingleActivator(LogicalKeyboardKey.numpad1): SlideNumberIntent(1),
              SingleActivator(LogicalKeyboardKey.numpad2): SlideNumberIntent(2),
              SingleActivator(LogicalKeyboardKey.numpad3): SlideNumberIntent(3),
              SingleActivator(LogicalKeyboardKey.numpad4): SlideNumberIntent(4),
              SingleActivator(LogicalKeyboardKey.numpad5): SlideNumberIntent(5),
              SingleActivator(LogicalKeyboardKey.numpad6): SlideNumberIntent(6),
              SingleActivator(LogicalKeyboardKey.numpad7): SlideNumberIntent(7),
              CharacterActivator('c'): SlideLetterIntent('C'),
              CharacterActivator('l'): SlideLetterIntent('L'),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                CloseIntent: CallbackAction<CloseIntent>(
                  onInvoke: (intent) => Navigator.pop(context, true),
                ),
                PreviousIntent: CallbackAction<PreviousIntent>(
                  onInvoke: (intent) => setPreviousSlide(),
                ),
                NextIntent: CallbackAction<NextIntent>(
                  onInvoke: (intent) => setNextSlide(),
                ),
                SlideNumberIntent: CallbackAction<SlideNumberIntent>(
                  onInvoke: (intent) => setSlideByNumber(intent.slideNumber),
                ),
                SlideLetterIntent: CallbackAction<SlideLetterIntent>(
                  onInvoke: (intent) => setSlideByLetter(intent.letter),
                ),
                BiggerFontIntent: CallbackAction<BiggerFontIntent>(
                  onInvoke: (intent) => resizeFont(false),
                ),
                SmallerFontIntent: CallbackAction<SmallerFontIntent>(
                  onInvoke: (intent) => resizeFont(true),
                ),
              },
              child: Focus(
                autofocus: true,
                onKeyEvent: (node, event) => KeyEventResult.ignored,
                child: presentation,
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
