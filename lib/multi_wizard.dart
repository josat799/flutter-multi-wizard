import 'package:flutter/material.dart';

class WizardStep {
  Key key;
  Widget child;
  bool showNext, showPrevious;
  final bool Function() nextFunction, previousFunction;

  WizardStep({
    this.nextFunction,
    this.previousFunction,
    this.child,
    this.key,
    this.showPrevious = true,
    this.showNext = true,
  });
}

class MultiWizard extends StatefulWidget {
  final Key key;
  final BoxDecoration decoration;
  final Function() finishFunction;
  final List<WizardStep> steps;
  ButtonStyle buttonStyle;
  TextStyle buttonTextStyle;
  Icon buttonIconForward, buttonIconPrevious, buttonIconFinish;

  MultiWizard({
    @required this.steps,
    this.key,
    this.finishFunction,
    this.decoration = const BoxDecoration(),
    this.buttonStyle,
    this.buttonTextStyle,
  }) {
    assert(steps != null);
  }

  MultiWizard.icon({
    this.key,
    this.decoration = const BoxDecoration(),
    this.finishFunction,
    this.steps,
    this.buttonIconForward = const Icon(Icons.arrow_forward),
    this.buttonIconPrevious = const Icon(Icons.arrow_back),
    this.buttonIconFinish = const Icon(Icons.check),

  }) {
    assert(steps != null);
  }

  @override
  _MultiWizardState createState() => _MultiWizardState();
}

class _MultiWizardState extends State<MultiWizard> {
  int currentStep = 0;

  _createIconButton(Direction direction, Icon icon) {
    return IconButton(
        icon: icon,
        onPressed: () => hasStep(direction) ? updateStep(direction) : null);
  }

  _createTextButton(Direction direction) {
    return TextButton(
        style: widget.buttonStyle,
        onPressed: () => hasStep(direction) ? updateStep(direction) : null,
        child: Text(direction == Direction.forward
            ? "Next"
            : direction == Direction.previous
                ? "Previous"
                : "Finish"));
  }

  Widget _createButton(Direction direction) {
    switch (direction) {
      case Direction.forward:
        if (widget.buttonIconForward != null) {
          return _createIconButton(direction, widget.buttonIconForward);
        } else {
          return _createTextButton(direction);
        }
        break;
      case Direction.previous:
        if (widget.buttonIconPrevious != null) {
          return _createIconButton(direction, widget.buttonIconPrevious);
        } else {
          return _createTextButton(direction);
        }
        break;
      case Direction.finish:
        if (widget.buttonIconFinish != null) {
          return _createIconButton(direction, widget.buttonIconFinish);
        } else {
          return _createTextButton(direction);
        }
        break;
    }
  }

  updateStep(Direction direction) {
    setState(() {
      switch (direction) {
        case Direction.forward:
          if (widget.steps[currentStep].nextFunction != null) {
            if (widget.steps[currentStep].nextFunction()) {
              currentStep++;
            }
          } else {
            currentStep++;
          }
          break;
        case Direction.previous:
          if (widget.steps[currentStep].previousFunction != null) {
            if (widget.steps[currentStep].previousFunction()) {
              currentStep--;
            }
          } else {
            currentStep--;
          }
          break;
        case Direction.finish:
          if (widget.finishFunction != null) {
            widget.finishFunction();
          } else {
            Navigator.pop(context);
          }
          break;
      }
    });
  }

  bool hasStep(Direction direction) {
    if (direction == Direction.finish) {
      return true;
    } else if (direction == Direction.forward &&
        currentStep + 1 < widget.steps.length) {
      return true;
    } else if (direction == Direction.previous && currentStep > 0) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: widget.steps[currentStep].child,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: widget.steps[currentStep].showPrevious
                  ? _createButton(Direction.previous)
                  : Container(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: currentStep == widget.steps.length - 1
                  ? _createButton(Direction.finish)
                  : widget.steps[currentStep].showNext
                      ? _createButton(Direction.forward)
                      : Container(),
            ),
          ),
        ],
      ),
    );
  }
}

enum Direction {
  forward,
  previous,
  finish,
}
