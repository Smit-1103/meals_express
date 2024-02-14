import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const ConfettiButton({
    Key? key,
    required this.isFavorite,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ConfettiButtonState createState() => _ConfettiButtonState();
}

class _ConfettiButtonState extends State<ConfettiButton>
    with TickerProviderStateMixin {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _playConfettiAnimation() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            widget.onPressed();
            _playConfettiAnimation();
          },
          icon: Stack(
            children: [
              Icon(
                widget.isFavorite ? Icons.star : Icons.star_border,
                size: 25.0,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    emissionFrequency: 0.05,
                    numberOfParticles: 10,
                    maxBlastForce: 5, // Adjust the blast force as needed
                    colors: widget.isFavorite
                        ? [
                            Theme.of(context).colorScheme.primary,
                            Colors.yellow,
                          ]
                        : [
                            Colors.grey,
                            Colors.black,
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
