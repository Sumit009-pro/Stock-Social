import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_social/models/search_model.dart';

class SearchUserItem extends StatelessWidget {
  // final List<ResponseDatum> user;
  final ResponseDatum user;

  SearchUserItem(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            // user.thumbnail != null && restaurant.thumbnail.isNotEmpty
            //     ? Ink(
            //   height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //     color: Colors.blueGrey,
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: NetworkImage(restaurant.thumbnail),
            //     ),
            //   ),
            // )
            //     :
            Container(
              height: 100,
              width: 100,
              color: Colors.blueGrey,
              child: Icon(
                Icons.restaurant,
                size: 30,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.id??'',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text(                      user.id??'',
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    // RatingBarIndicator(
                    //   rating: double.parse(restaurant.rating),
                    //   itemBuilder: (_, __) {
                    //     return Icon(
                    //       Icons.star,
                    //       color: Colors.amber,
                    //     );
                    //   },
                    //   itemSize: 20,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}