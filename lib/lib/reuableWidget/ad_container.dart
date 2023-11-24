import 'package:flutter/material.dart';

class AddContainer extends StatefulWidget {
  const AddContainer({super.key});

  @override
  State<AddContainer> createState() => _AddContainerState();
}

class _AddContainerState extends State<AddContainer> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.12,
      width: screenWidth * 0.90,
      child: Card(
        elevation: 2,
        color: Color(0xFF12111D),
        child: Padding(
          padding: EdgeInsets.only(
            top: screenWidth * 0.02,
            bottom: screenWidth * 0.01,
            right: screenWidth * 0.02,
            left: screenWidth * 0.02,
          ),
          child: Row(
            children: [
              SizedBox(
                height: screenHeight * 0.09,
                width: screenHeight * 0.1,
                child: Card(
                  color: Theme.of(context).colorScheme.tertiary,
                  elevation: 2,
                  child: const Center(
                    child: Text("ADS"),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.035,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "AD",
                        style: TextStyle(
                          fontSize: screenWidth * 0.02,
                        ),
                      ),
                      Text(
                        "App Title",
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Get It From Google Playstore",
                    style: TextStyle(
                      fontSize: screenWidth * 0.020,
                    ),
                  ),
                  Image.asset(
                    "assets/rating.png",
                    color: Colors.yellow[600],
                    height: screenWidth * 0.035,
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                ),
                child: const Text("Install"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
