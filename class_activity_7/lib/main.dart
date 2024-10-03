import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true; // To toggle text visibility
  bool _showFrame = true; // To toggle frame visibility around the image
  double _rotation = 0.0; // For image rotation

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible; // Toggle the visibility state
    });
  }

  void toggleFrame(bool value) {
    setState(() {
      _showFrame = value; // Update the frame visibility state
    });
  }

  void spinImage() {
    setState(() {
      // Rotate the image by 360 degrees
      _rotation += 360.0;
      // Toggle visibility for fading effect
      _isVisible = !_isVisible; // Toggle visibility to fade out
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imagePath = 'assets/icegif-1575.gif'; // Local image path

    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        backgroundColor: Colors.blue, // App bar background color
      ),
      body: Container(
        color: const Color(0xFF8FD3FE), // Light blue background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                // Use GestureDetector to toggle visibility on tap
                onTap: toggleVisibility,
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: const Text(
                    'Hello! Welcome To Flutter!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 20),
              AnimatedContainer(
                // AnimatedContainer to create a frame around the image
                duration: const Duration(seconds: 1),
                decoration: BoxDecoration(
                  border: _showFrame // Show frame if _showFrame is true
                      ? Border.all(color: Colors.blue, width: 4)
                      : null,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath, // Use the local image asset
                      width: 250,
                      height: 250,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Show Frame'), // Title for the switch
                value: _showFrame,
                onChanged: toggleFrame, // Toggle the frame visibility
              ),
              SizedBox(height: 20),
              GestureDetector(
                // GestureDetector to spin the image
                onTap: spinImage, // Spin the image on tap
                child: AnimatedRotation(
                  // Animate the rotation
                  turns: _rotation / 360,
                  duration: const Duration(seconds: 1),
                  child: AnimatedOpacity(
                    opacity: _isVisible ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imagePath, // Use the local image asset
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: spinImage, // Floating button to spin the image
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
