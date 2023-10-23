import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';

class MyAnimSearchBar extends StatefulWidget {
  const MyAnimSearchBar({
    Key? key,
    this.width = 250,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Ara...",
    this.height = 50,
    this.textInputAction = TextInputAction.done,
    this.animationDurationInMilli = 375,
    this.rtl = false,
    this.autoFocus = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
    this.boxShadow = true,
    this.inputFormatters,
    this.text = '',
    required this.onChanged,
  }) : super(key: key);

  final double width;
  final double height;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final TextInputAction textInputAction;
  final String? text;
  final ValueChanged<String> onChanged;

  @override
  State<MyAnimSearchBar> createState() => _MyAnimSearchBarState();
}

final textController = TextEditingController();
int toggle = 0;
String textFieldValue = '';

class _MyAnimSearchBarState extends State<MyAnimSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive.of(context);
    return Container(
      height: resp.hp(5),
      alignment:
          widget.rtl ? Alignment.centerRight : const Alignment(-1.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: widget.height,
        width: (toggle == 0) ? resp.wp(11) : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: borderRadiusMedium,
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 6.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: paddingAll / 2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: borderRadiusMedium,
                  ),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _animController.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _animController,
                    child: GestureDetector(
                      onTap: () {
                        if (textController.text.isEmpty) {
                        } else {
                          textController.clear();
                        }
                        try {
                          if (textFieldValue == '') {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });

                            _animController.reverse();
                          }

                          textController.clear();
                          textFieldValue = '';

                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                          }
                        } catch (e) {
                          Text(e.toString());
                        }
                      },
                      child: widget.suffixIcon ??
                          Icon(
                            Icons.close,
                            size: iconSmall,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: paddingLeft,
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    controller: textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    textInputAction: widget.textInputAction,
                    cursorRadius: radiusLow,
                    cursorWidth: 2.0,
                    onChanged: widget.onChanged,
                    onEditingComplete: () {
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },
                    style: widget.style ??
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    cursorColor: Theme.of(context).colorScheme.primary,
                    decoration: InputDecoration(
                      contentPadding: paddingBot,
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.helpText,
                      labelStyle: fontSFProMedium16,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: borderRadiusMedium,
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: borderRadiusMedium,
              child: IconButton(
                splashRadius: 19.0,
                icon: widget.prefixIcon != null
                    ? toggle == 1
                        ? Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).colorScheme.primary,
                            size: iconSmall,
                          )
                        : widget.prefixIcon!
                    : Icon(
                        toggle == 1 ? Icons.arrow_back_ios : Icons.search,
                        color: Theme.of(context).colorScheme.primary,
                        size: iconSmall,
                      ),
                onPressed: () {
                  setState(
                    () {
                      if (toggle == 0) {
                        toggle = 1;
                        setState(() {
                          if (widget.autoFocus) {
                            FocusScope.of(context).requestFocus(focusNode);
                          }
                        });

                        _animController.forward();
                      } else {
                        toggle = 0;

                        setState(() {
                          if (widget.autoFocus) unfocusKeyboard();
                        });
                        _animController.reverse();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
