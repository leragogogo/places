import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/widgets/parts_of_card.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';

class SightCard extends StatelessWidget {
  final Place place;
  final VoidCallback addToFavourites;
  final VoidCallback removeFromFavorites;
  final bool isMapCard;
  final VoidCallback? buildRoute;

  const SightCard(
      {required this.place,
      required this.addToFavourites,
      required this.removeFromFavorites,
      required this.isMapCard,
      required this.buildRoute,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
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
            UpperPart(place),
            Positioned(
              top: 96,
              left: 16,
              right: 16,
              child: LowerPart(
                place,
                Text(
                  place.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                        return SightDetailsScreen(place);
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
              child: TextButton(
                style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                onPressed: () {
                  visitingScreenRepository.favouritePlaces.contains(place)
                      ? removeFromFavorites()
                      : addToFavourites();
                },
                child: AnimatedCrossFade(
                  firstChild: const Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                  ),
                  secondChild: const Icon(
                    Icons.favorite_sharp,
                    color: Colors.red,
                  ),
                  duration: Duration(milliseconds: 600),
                  crossFadeState:
                      visitingScreenRepository.favouritePlaces.contains(place)
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                ),
              ),
            ),
            isMapCard
                ? Positioned(
                  right:0,
                  top: 101,
                    child: IconButton(
                      onPressed: buildRoute,
                      icon: Image.asset(
                        AppAssets.buildRouteAsset,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
