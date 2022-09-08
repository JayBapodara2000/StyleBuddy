import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final int rating;
  final RatingChangeCallback onRatingChanged;

  StarRating({
    this.starCount = 5,
    this.rating = 0,
    required this.onRatingChanged,
  });

  Widget buildStar(BuildContext context, int index) {
    var starIcon;
    if (index >= rating) {
      starIcon = Container(
        child: SvgPicture.asset(
          'assets/images/android/Customer_Assets/Rating/Icon material-stars.svg',
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
      );
    } else {
      starIcon = Container(
        child: SvgPicture.asset(
          'assets/images/android/Customer_Assets/Rating/Icon material-stars2.svg',
          height: 30,
          width: 30,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: new InkResponse(
        onTap:
            onRatingChanged == null ? null : () => onRatingChanged(index + 1),
        child: starIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

typedef void RatingChangeCallback(int rating);
