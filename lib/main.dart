import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> addNewAnnotation({
  required String user,
  required String video,
  required String annotation,
  required double time,
}) async {
  final url = Uri.parse("http://pigssh.ddns.net:8080/add_annotation");

  final data = {
    "user": user,
    "video": video,
    "annotation": annotation,
    "time": time,
  };

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add annotation: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Error occurred: $e');
  }
}


class PainCardWidget extends StatelessWidget {
  final String mealName;
  final String imageAsset;

  const PainCardWidget({
    Key? key,
    required this.mealName,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mealName)),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center, // Centering horizontally
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.blueAccent, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: Center(child: Text('Image not available')),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Text(
              mealName,
              maxLines: 2,
              textAlign: TextAlign.center, // Centering text
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class PainListWidget extends StatelessWidget {
  final List<Map<String, String>> dishes = [
    {
      'name': 'Happy',
      'image': 'assets/images/boldog.png',
    },
    {
      'name': 'Neutral',
      'image': 'assets/images/neutral.png',
    },
    {
      'name': 'Sad',
      'image': 'assets/images/sad.png',
    },
    {
      'name': 'Cry',
      'image': 'assets/images/sir.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          return Center( // Center each card in the horizontal list
            child: PainCardWidget(
                mealName: dishes[index]['name']!,
                imageAsset: dishes[index]['image']!,
              ),

          );
        },
      ),
    ));

  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pain Assessment')),
      body: Center(child: PainListWidget()), // Center the list widget in the body
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}
