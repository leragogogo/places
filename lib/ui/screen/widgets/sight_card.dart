import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data_providers/want_to_visit_provider.dart';
import 'package:places/ui/screen/widgets/parts_of_card.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';
import 'package:places/ui/screen/widgets/store.dart';
import 'package:provider/provider.dart';

class SightCard extends StatefulWidget {
  final Place place;

  const SightCard(this.place, {Key? key}) : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  bool isFavouriteButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    isFavouriteButtonClicked = widget.place.wished;

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
                style: TextButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  setState(() {
                    isFavouriteButtonClicked = !isFavouriteButtonClicked;
                  });
                  isFavouriteButtonClicked
                      ? store.addToFavorites(place: widget.place)
                      : store.removeFromFavorites(place: widget.place);
                  final favouritePlaces = store.getFavoritesPlaces();
                  Provider.of<WantToVisitProvider>(context, listen: false)
                      .changeState(
                    newWantToVisit: favouritePlaces,
                    newIsWantToVisitEmpty: favouritePlaces.isEmpty,
                  );
                },
                child: isFavouriteButtonClicked &&
                        Provider.of<WantToVisitProvider>(context, listen: true)
                            .wantToVisit
                            .contains(widget.place)
                    ? const Icon(
                        Icons.favorite_sharp,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
