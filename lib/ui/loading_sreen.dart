import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoadingSreen extends StatelessWidget {
  const LoadingSreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    // print(a);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255 ,238, 233, 218),
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
              color: const Color.fromARGB(255,189, 205, 218),
              size: 200,
            ),
      ),
    );
  }
}