import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class DishCardWidget extends StatefulWidget {
  const DishCardWidget({
    Key? key,
    this.dishReference,
  }) : super(key: key);

  final DocumentReference? dishReference;

  @override
  State<DishCardWidget> createState() => _DishCardWidgetState();
}

class _DishCardWidgetState extends State<DishCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.lightImpact();
        Navigator.pushNamed(
          context,
          'DishDetails',
          arguments: {'dishReference': widget.dishReference},
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              HapticFeedback.lightImpact();
              Navigator.pushNamed(
                context,
                'DishDetails',
                arguments: {'dishReference': widget.dishReference},
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.48,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://example.com/dish_image.jpg',
                  ),
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1,
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                  child: GestureDetector(
                    onTap: () async {
                      // Logic for favorite action
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.black54,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Text(
              'Dish Name Here',
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (widget.dishReference != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Diet Type Here',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.green[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
