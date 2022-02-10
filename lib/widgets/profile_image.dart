import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String? imageUrl;

  const ProfileImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl?.isNotEmpty ?? false)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: imageUrl!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => SizedBox( width: 5, height: 5, child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.camera_alt,),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50)),
            width: 100,
            height: 100,
            child: Icon(
              Icons.camera_alt,
              color: Colors.grey[800],
            ),
          );
  }
}
