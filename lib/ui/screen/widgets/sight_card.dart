import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/ui/screen/widgets/parts_of_card.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';

class SightCard extends StatefulWidget {
  final Place place;
  final VoidCallback addToFavourites;
  final VoidCallback removeFromFavorites;

  const SightCard(
      {required this.place,
      required this.addToFavourites,
      required this.removeFromFavorites,
      Key? key})
      : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  bool isFavouriteButtonClicked = false;

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
            UpperPart(widget.place),
            Positioned(
              top: 96,
              left: 16,
              right: 16,
              child: LowerPart(
                widget.place,
                Text(
                  widget.place.description,
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
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => SightDetailsScreen(widget.place),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: TextButton(
                style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                onPressed: () {
                  setState(() {
                    isFavouriteButtonClicked = !isFavouriteButtonClicked;
                  });
                  isFavouriteButtonClicked
                      ? widget.addToFavourites()
                      : widget.removeFromFavorites();
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
                  crossFadeState: isFavouriteButtonClicked &&
                          visitingScreenRepository.favouritePlaces
                              .contains(widget.place)
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
