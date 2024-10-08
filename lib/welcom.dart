import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quiz_app/input_details.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;

    // Calculate responsive values
    final imageSize = size.width * 0.5; // Image size based on screen width
    final buttonWidth = size.width * 0.4; // Button width based on screen width
    final paddingHorizontal = size.width * 0.1; // Padding based on screen width
    final fontSize = size.width * 0.04; // Font size based on screen width

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          HexColor('#FF671F').withOpacity(.6),
          HexColor('#	FFFFFF'),
          HexColor(
            '#046A38',
          ).withOpacity(.6)
        ])),
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: imageSize, // Use responsive image size
                    width: imageSize, // Use responsive image size
                    child: const Image(
                        image: AssetImage('lib/asset/image/Asset 2@4x.png')),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: paddingHorizontal), // Responsive padding
                  child: Text(
                    "In honor of our nation's Independence Day, we've created an engaging quiz "
                    "that highlights India's remarkable history and culture. Whether you're a "
                    "history buff or just looking to have some fun, this quiz is for you. Test "
                    "your knowledge, challenge friends, and celebrate the spirit of India. Get "
                    "started now and see how much you really know about our incredible country!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: fontSize), // Use responsive font size
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 5,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                // Adjust button position for different screen sizes
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(185, 249, 249, 249),
                  ),
                  child: SizedBox(
                    height: 30,
                    width: buttonWidth, // Use responsive button width
                    child: const Center(
                      child: Text(
                        'Let’s go',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
