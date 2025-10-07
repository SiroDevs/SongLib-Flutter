part of '../presentor_screen.dart';

class PresentorSlide extends StatefulWidget {
  final int? index;
  final double? indicatorWidth;
  final IndicatorSide? indicatorSide;
  final List<Tab>? tabs;
  final List<Widget>? slides;
  final String? songbook;
  final TextDirection? direction;

  const PresentorSlide({
    super.key,
    required this.index,
    required this.tabs,
    required this.slides,
    required this.songbook,
    this.indicatorWidth = 3,
    this.indicatorSide,
    this.direction = TextDirection.ltr,
  }) : assert(
         tabs != null && slides != null && tabs.length == slides.length,
       );

  @override
  State<PresentorSlide> createState() => _PresentorSlideState();
}

class _PresentorSlideState extends State<PresentorSlide>
    with TickerProviderStateMixin {
  late PrefRepository _prefRepo;
  bool slideVertical = false;

  int? selectedIndex;
  bool? changePageByTapView;
  AnimationController? animationController;
  Animation<double?>? animation;
  Animation<RelativeRect?>? rectAnimation;

  PageController? pageController = PageController();
  List<AnimationController?>? animationControllers = [];

  @override
  void didUpdateWidget(covariant PresentorSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index && widget.index != null) {
      selectedIndex = widget.index!;
      changePageByTapView = true;
      selectTab(selectedIndex!);
      pageController!.animateToPage(
        selectedIndex!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    _prefRepo = getIt<PrefRepository>();
    slideVertical = _prefRepo.getPrefBool(
      PrefConstants.slideVerticalKey,
      defaultValue: true,
    );

    selectedIndex = widget.index;
    for (int? i = 0; i! < widget.tabs!.length; i++) {
      animationControllers!.add(
        AnimationController(
          duration: const Duration(milliseconds: 400),
          vsync: this,
        ),
      );
    }
    selectTab(widget.index!);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController!.jumpToPage(widget.index!);
      setState(() {});
    });
  }

  @override
  void dispose() {
    for (final controller in animationControllers!) {
      controller!.dispose();
    }
    pageController!.dispose();
    super.dispose();
  }

  void selectTab(int index) {
    selectedIndex = index;
    for (final AnimationController? animController in animationControllers!) {
      animController!.reset();
    }
    animationControllers![index]!.forward();
  }

  @override
  Widget build(BuildContext context) {
    var pageView = PageView.builder(
      scrollDirection: slideVertical ? Axis.vertical : Axis.horizontal,
      controller: pageController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.slides!.length,
      onPageChanged: (index) {
        setState(() {
          if (changePageByTapView == false || changePageByTapView == null) {
            selectTab(index);
          }
          if (selectedIndex == index) {
            changePageByTapView = null;
          }
        });
      },
      itemBuilder: (context, index) => widget.slides![index],
    );
    var slideContainer = SlideContainer(
      tabs: widget.tabs!,
      selectedIndex: selectedIndex!,
      direction: widget.direction!,
      indicatorSide: widget.indicatorSide,
      indicatorWidth: widget.indicatorWidth!,
      animationControllers: animationControllers!,
      onTabSelected: (index) {
        changePageByTapView = true;
        selectTab(index);
        pageController!.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );

    return Directionality(
      textDirection: widget.direction!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [pageView.expanded(), slideContainer, SizedBox(height: 10)],
      ),
    );
  }
}
