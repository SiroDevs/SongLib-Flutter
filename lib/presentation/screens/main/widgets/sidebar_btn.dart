part of '../main_screen.dart';

class SidebarBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;
  final double iconSize;
  final bool compact;
  final bool transparent;
  final double height;
  final PageType pageType;
  final bool dottedBorder;

  const SidebarBtn(
    this.icon,
    this.label, {
    super.key,
    this.onPressed,
    this.isSelected = false,
    this.iconSize = 26,
    this.compact = false,
    this.transparent = true,
    this.height = 60,
    this.pageType = PageType.search,
    this.dottedBorder = false,
  });

  @override
  SidebarBtnState createState() => SidebarBtnState();
}

class SidebarBtnState extends State<SidebarBtn> {
  @override
  Widget build(BuildContext context) {
    TextStyle btnStyle = TextStyles.buttonTextStyle;
    Widget btnContents = Row(
      mainAxisAlignment:
          widget.compact ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        if (!widget.compact) const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            widget.icon,
            size: widget.iconSize - 4.0,
            color: widget.isSelected ? Colors.white : Colors.black,
          ),
        ),
        if (!widget.compact) ...{
          const SizedBox(width: 20),
          Text(widget.label.toUpperCase(), style: btnStyle).flexible()
        }
      ],
    )
        .opacity(widget.isSelected ? 1 : .8, animate: true)
        .animate(.3.seconds, Curves.easeOut);

    return RawMaterialButton(
      textStyle: TextStyles.buttonTextStyle.bold
          .size(20)
          .textColor(widget.isSelected ? Colors.white : Colors.black),
      fillColor: widget.isSelected ? ThemeColors.primary : Colors.transparent,
      highlightColor: Colors.white.withValues(alpha: .1),
      focusElevation: 0,
      hoverColor: ThemeColors.primary,
      hoverElevation: 1,
      highlightElevation: 0,
      elevation: 0,
      padding: EdgeInsets.zero,
      onPressed: widget.onPressed,
      child: btnContents,
    );
  }
}
