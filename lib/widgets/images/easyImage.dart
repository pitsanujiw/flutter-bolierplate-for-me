import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';

enum ImageType {
  network,
  asset,
  memory,
  file,
  byte,
}

enum ImageShape {
  circle,
  square,
  none,
}

class EasyImage extends StatelessWidget {
  final ImageType type;
  final String? imageUrl;
  final String? assetPath;
  final Uint8List? byte;
  final File? file;
  final double size;
  final ImageShape shape;
  final BoxFit fit;

  const EasyImage.network({
    Key? key,
    required this.imageUrl,
    this.size = 7,
    this.shape = ImageShape.square,
    this.fit = BoxFit.cover,
  })  : this.assetPath = null,
        this.byte = null,
        this.file = null,
        this.type = ImageType.network,
        super(key: key);

  const EasyImage.asset({
    Key? key,
    @required this.assetPath,
    this.size = 7,
    this.shape = ImageShape.square,
    this.fit = BoxFit.cover,
  })  : this.imageUrl = null,
        this.byte = null,
        this.file = null,
        this.type = ImageType.asset,
        super(key: key);

  const EasyImage.memory({
    Key? key,
    @required this.byte,
    this.size = 7,
    this.shape = ImageShape.square,
    this.fit = BoxFit.cover,
  })  : this.imageUrl = null,
        this.file = null,
        this.assetPath = null,
        this.type = ImageType.memory,
        super(key: key);

  const EasyImage.file({
    Key? key,
    @required this.file,
    this.size = 7,
    this.shape = ImageShape.square,
    this.fit = BoxFit.cover,
  })  : this.imageUrl = null,
        this.assetPath = null,
        this.byte = null,
        this.type = ImageType.file,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const int _milliseconds = 200;

    BorderRadius handleShape() {
      switch (this.shape) {
        case ImageShape.circle:
          return BorderRadius.circular(size * 20);

        case ImageShape.square:
          return BorderRadius.circular(5);

        default:
          return BorderRadius.zero;
      }
    }

    bool hasImage() {
      if (this.imageUrl?.isEmpty ?? true) {
        return false;
      } else if (this.imageUrl == "null") {
        return false;
      }

      return true;
    }

    String parseImageUrl() {
      String url = this.imageUrl.toString();

      if (url.startsWith("http://") || url.startsWith("https://")) {
        return url;
      }

      return "https://" + url;
    }

    Widget handleErrorBuilder(context, exception, stackTrace) {
      return Container(
        color: Colors.grey[300],
      );
    }

    Widget handleImage() {
      switch (this.type) {
        case ImageType.network:
          return hasImage()
              ? CachedNetworkImage(
                  useOldImageOnUrlChange: true,
                  fit: this.fit,
                  imageUrl: parseImageUrl(),
                  fadeOutCurve: Curves.easeIn,
                  fadeInDuration: const Duration(milliseconds: _milliseconds),
                  fadeOutDuration: const Duration(milliseconds: _milliseconds),
                  placeholder: (context, url) {
                    return Container(
                      color: Colors.grey[300],
                    );
                  },
                  errorWidget: (context, url, error) {
                    Log.wtf({
                      "message": "Fail to load image url",
                      "url": this.imageUrl,
                      "parsed_url": url,
                      "error": error.toString(),
                    });

                    return Container(
                      color: Colors.grey[300],
                    );
                  },
                )
              : Container(
                  color: Colors.grey[300],
                );

        case ImageType.memory:
          return Container(
            color: Colors.grey[300],
            child: FadeInImage(
              fit: this.fit,
              fadeOutCurve: Curves.easeIn,
              fadeInDuration: const Duration(milliseconds: _milliseconds),
              fadeOutDuration: const Duration(milliseconds: _milliseconds),
              placeholder: _placeholder,
              imageErrorBuilder: handleErrorBuilder,
              image: MemoryImage(
                this.byte!,
              ),
            ),
          );

        case ImageType.file:
          return Container(
            color: Colors.grey[300],
            child: FadeInImage(
              fit: this.fit,
              fadeOutCurve: Curves.easeIn,
              fadeInDuration: const Duration(milliseconds: _milliseconds),
              fadeOutDuration: const Duration(milliseconds: _milliseconds),
              placeholder: _placeholder,
              imageErrorBuilder: handleErrorBuilder,
              image: FileImage(
                this.file!,
              ),
            ),
          );

        default:
          return Container(
            color: Colors.grey[300],
            child: FadeInImage(
              fit: this.fit,
              fadeOutCurve: Curves.easeIn,
              fadeInDuration: const Duration(milliseconds: _milliseconds),
              fadeOutDuration: const Duration(milliseconds: _milliseconds),
              placeholder: _placeholder,
              imageErrorBuilder: handleErrorBuilder,
              image: AssetImage(
                this.assetPath!,
              ),
            ),
          );
      }
    }

    return ClipRRect(
      borderRadius: handleShape(),
      child: SizedBox(
        height: 10 * size,
        width: 10 * size,
        child: handleImage(),
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
