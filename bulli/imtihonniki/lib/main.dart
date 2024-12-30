import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int age = 34;
  int energy = 34;
  int smart = 24;
  int speed = 54;

  final List<String> images = [
    'images/photo_2024-12-30_09-52-23.jpg',
    'images/photo_2024-12-30_09-52-28.jpg',
    'images/photo_2024-12-30_09-52-32.jpg',
    'images/photo_2024-12-30_09-52-38.jpg',
    'images/photo_2024-12-30_09-52-41.jpg',
    'images/photo_2024-12-30_09-52-46.jpg',
    'images/photo_2024-12-30_09-52-50.jpg',
    'images/photo_2024-12-30_09-52-54.jpg',
    'images/photo_2024-12-30_09-52-59.jpg',
    'images/photo_2024-12-30_09-53-04.jpg',
    'images/photo_2024-12-30_09-53-08.jpg',
    'images/photo_2024-12-30_09-53-11.jpg',
    'images/photo_2024-12-30_09-53-15.jpg',
    'images/photo_2024-12-30_09-53-19.jpg',
    'images/photo_2024-12-30_09-53-22.jpg',
    'images/photo_2024-12-30_09-53-27.jpg',
    'images/photo_2024-12-30_09-53-34.jpg',
    'images/photo_2024-12-30_09-53-40.jpg',
    'images/photo_2024-12-30_09-53-45.jpg',
    'images/photo_2024-12-30_09-53-50.jpg',
  ];

  List<String> selectedImages = [];

  @override
  void initState() {
    super.initState();
    // Filtrlash (start va end orasidagi indekslar)
    selectedImages = images
        .where((image) =>
            image.compareTo('images/photo_2024-12-30_09-52-23.jpg') >= 0 &&
            image.compareTo('images/photo_2024-12-30_09-53-50.jpg') <= 0)
        .toList();
  }

  void _showAgeDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: InputDecoration(
              label: Text("Enter your age"),
              border: OutlineInputBorder(), // 4-burchak chegarasi
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String input = controller.text;
                if (input.isNotEmpty && int.tryParse(input) != null) {
                  setState(() {
                    age = int.parse(input);
                    energy = age; // Energy bilan bir xil o'zgaradi
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Information saved',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      backgroundColor: Colors.purple.shade900,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: Text('ok'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('back'),
            ),
          ],
        );
      },
    );
  }

  void _showFullImage(String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue, Colors.green],
            ).createShader(bounds);
          },
          child: Text(
            'flutter',
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.w900),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrencyRatesPage(),
                  ));
            },
            child: Image(
                image: NetworkImage(
                    "https://www.shutterstock.com/image-vector/money-coin-icon-glyph-style-600nw-1914078058.jpg"))),
        actions: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black, width: 1), // Qora chegarani qo'shish
              borderRadius: BorderRadius.circular(
                  100), // Chegaraning burchaklarini yumshatish (ixtiyoriy)
            ),
            child: IconButton(
              icon: Lottie.asset('lottie/button.json', fit: BoxFit.cover),
              onPressed: () => _showAgeDialog(context),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HIS AGE',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          '$age / 100',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'OVERALL',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.red),
                                Column(
                                  children: [
                                    Text('$energy / 100'),
                                    Text('Energy'),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage("images/gg.png"))),
                                Column(
                                  children: [
                                    Text('$smart / 100'),
                                    Text(
                                      'Smart',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(
                                            "images/lightning.png"))),
                                Column(
                                  children: [
                                    Text('$speed / 100'),
                                    Text(
                                      'Speed',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Lottie.asset(
                            'lottie/circul1.json',
                            height: 100,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            "images/o'zim2.png",
                            height: 400, // Rasm kattaligi
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft, // Chap tomonga joylashadi
                child: Text(
                  'Old Memory',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
           CarouselSlider(
  items: selectedImages.map((image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => katta(imagePath: image),  // Pass the selected image to the katta page
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }).toList(),
  options: CarouselOptions(
    height: 300,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    enlargeCenterPage: true,
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}

class katta extends StatelessWidget {
  final String imagePath;

  const katta({super.key, required this.imagePath});  // Accept the image path

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),  // Tap to go back
        child: Center(
          child: Image.asset(
            imagePath,  // Display the selected image
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}


class FullImagePage extends StatelessWidget {
  final String imagePath;

  FullImagePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
        backgroundColor: Colors.blue,
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Image.asset(imagePath,
              fit: BoxFit.contain), // Show the image in full size
        ),
      ),
    );
  }
}
class CurrencyRatesPage extends StatefulWidget {
  @override
  _CurrencyRatesPageState createState() => _CurrencyRatesPageState();
}

class _CurrencyRatesPageState extends State<CurrencyRatesPage> {
  String time = "";
  String date = "";
  List<dynamic> currencyRates = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrencyRates();
    updateTime();
  }

  Future<void> fetchCurrencyRates() async {
    final response = await http
        .get(Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
    if (response.statusCode == 200) {
      setState(() {
        currencyRates = jsonDecode(response.body);
        loading = false;
      });
    } else {
      throw Exception('Failed to load currency rates');
    }
  }

  void updateTime() {
    setState(() {
      DateTime now = DateTime.now();
      date =
          "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";
      time =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    });
    Future.delayed(Duration(seconds: 1), () {
      updateTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple.shade900,
        title: Text(
          "Valyuta kurslari",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        actions: [
          Text(
            "$date",
            style: TextStyle(color: Colors.white, fontSize: 30),
          )
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currencyRates.length,
              itemBuilder: (context, index) {
                final currency = currencyRates[index];
                return SizedBox(
                  height: 200,
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "updated day",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          Text("$date"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "1 ${currency['Ccy']} ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${currency['CcyNm_UZ']} (${currency['Code']})",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple.shade900),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${currency['Rate']} UZS",
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "+${currency['Diff']}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: currency['Diff']
                                            .toString()
                                            .startsWith('-')
                                        ? Colors.red
                                        : Colors.green),
                              ),
                            ],
                          ),
                          Divider(color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}