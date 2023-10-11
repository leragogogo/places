import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/widgets/deleting_background.dart';
import 'package:places/ui/screen/widgets/parts_of_card.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';

class VisitingSightCard extends StatelessWidget {
  final Place sight;
  final VoidCallback deleteFromList;
  final Text lowerText;
  final Widget leftIcon;
  final VoidCallback leftIconOnPressed;

  const VisitingSightCard({
    required this.sight,
    required this.deleteFromList,
    required this.lowerText,
    required this.leftIcon,
    required this.leftIconOnPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Dismissible(
        key: key!,
        onDismissed: (direction) {
          deleteFromList();
        },
        background: const DeletingBackgroud(),
        child: Container(
          width: double.infinity,
          height: 192,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            color: theme.primaryColor,
          ),
          child: Stack(
            children: [
              UpperPart(sight),
              Positioned(
                top: 96,
                left: 16,
                child: LowerPart(
                  sight,
                  lowerText,
                ),
              ),
              Positioned.fill(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, _, __) {
                          return SightDetailsScreen(sight);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 500),
                      ));
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      onPressed: leftIconOnPressed,
                      child: leftIcon,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      onPressed: deleteFromList,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
