import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum SmartImageType {
  asset,
  network,
  memory,
}

class SmartImage extends StatelessWidget {
  final SmartImageType type;
  final String imageUrl;
  final String assetPath;
  final Uint8List byte;
  final BoxFit fit;
  final double width;
  final double height;
  final Color backgroundColor;

  const SmartImage.network({
    Key key,
    @required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width = 100,
    this.height = 100,
    this.backgroundColor,
  })  : this.assetPath = null,
        this.byte = null,
        this.type = SmartImageType.network,
        super(key: key);

  const SmartImage.asset({
    Key key,
    @required this.assetPath,
    this.fit = BoxFit.cover,
    this.width = 100,
    this.height = 100,
    this.backgroundColor,
  })  : this.imageUrl = null,
        this.byte = null,
        this.type = SmartImageType.asset,
        super(key: key);

  const SmartImage.memory({
    Key key,
    @required this.byte,
    this.fit = BoxFit.cover,
    this.width = 100,
    this.height = 100,
    this.backgroundColor,
  })  : this.imageUrl = null,
        this.assetPath = null,
        this.type = SmartImageType.memory,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider image;
    const int _milliseconds = 100;

    String parseImageUrl() {
      String url = this.imageUrl.toString();

      if (url.startsWith("http://") || url.startsWith("https://")) {
        return url;
      }

      return "https://" + url;
    }

    Widget handleErrorBuilder(context, exception, stackTrace) {
      return Container(
        color: this.backgroundColor ?? Colors.grey[300],
      );
    }

    switch (this.type) {
      case SmartImageType.network:
        return Container(
          color: this.backgroundColor ?? Colors.grey[300],
          width: this.width,
          height: this.height,
          child: CachedNetworkImage(
            fit: this.fit,
            fadeOutCurve: Curves.easeIn,
            fadeInDuration: const Duration(milliseconds: _milliseconds),
            fadeOutDuration: const Duration(milliseconds: _milliseconds),
            progressIndicatorBuilder: (context, _, __) {
              return Image(
                image: _placeholder,
              );
            },
            imageUrl: parseImageUrl(),
          ),
        );
        break;

      case SmartImageType.memory:
        image = MemoryImage(this.byte);
        break;

      default:
        image = AssetImage(this.assetPath);
        break;
    }

    return Container(
      color: this.backgroundColor ?? Colors.grey[300],
      width: this.width,
      height: this.height,
      child: FadeInImage(
        fit: this.fit,
        fadeOutCurve: Curves.easeIn,
        fadeInDuration: const Duration(milliseconds: _milliseconds),
        fadeOutDuration: const Duration(milliseconds: _milliseconds),
        placeholder: _placeholder,
        imageErrorBuilder: handleErrorBuilder,
        image: image,
      ),
    );
  }
}

final _placeholder = Image.memory(
  Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]),
).image;
