import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/res/app_assets.dart';

enum WidgetStatus { isLoading, isReady, isEmpty, isError }

//верхняя часть верстки карточки с изображением
class UpperPart extends StatefulWidget {
  final Place place;
  const UpperPart(this.place, {Key? key}) : super(key: key);

  @override
  State<UpperPart> createState() => _UpperPartState();
}

class _UpperPartState extends State<UpperPart> {
  late NetworkImage _networkImage;

  WidgetStatus status = WidgetStatus.isLoading;

  @override
  void initState() {
    super.initState();
    if (widget.place.urls.isEmpty) {
      status = WidgetStatus.isEmpty;
      _networkImage = NetworkImage(AppAssets.placeholderAsset);
    } else {
      _networkImage = NetworkImage(widget.place.urls[0]);
      _networkImage.resolve(ImageConfiguration.empty).addListener(
            ImageStreamListener(
              (_, __) async {
                if (mounted) {
                  setState(() {
                    status = WidgetStatus.isReady;
                  });
                }
              },
              onError: (_, __) {
                if (mounted) {
                  setState(() {
                    status = WidgetStatus.isError;
                  });
                }
              },
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 96,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: AnimatedCrossFade(
              firstChild: status == WidgetStatus.isEmpty
                  ? Center(
                      child: Image.asset(
                        AppAssets.placeholderAsset,
                        width: 200,
                        height: 200,
                      ),
                    )
                  : Image.network(
                      _networkImage.url,
                      width: double.infinity,
                      height: 96,
                      fit: BoxFit.fitWidth,
                    ),
              secondChild: Center(
                child: Image.asset(
                  AppAssets.placeholderAsset,
                  width: 200,
                  height: 200,
                ),
              ),
              duration: Duration(seconds: 1),
              crossFadeState: (status == WidgetStatus.isLoading) ||
                      (status == WidgetStatus.isError) ||
                      (status == WidgetStatus.isEmpty)
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            widget.place.beatifulType,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// нижняя часть верстки карточки
class LowerPart extends StatelessWidget {
  final Place sight;
  final Text text;
  const LowerPart(this.sight, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            sight.name,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).canvasColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: text,
        ),
      ],
    );
  }
}
