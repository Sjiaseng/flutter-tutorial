import 'package:flutter/material.dart';
import 'dice_roller.dart';

const StartAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {

  const GradientContainer(this.color1, this.color2, {super.key});

  const GradientContainer.purple({super.key})
    : color1 = Colors.deepPurple,
      color2 = Colors.indigo;

  final Color color1;
  final Color color2;

  void rollDice(){
    //...
  }

  @override
  Widget build(context){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: StartAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
         Image.asset(
          'images/dice-2.png',
          width: 200,
          ),
      
        const SizedBox(height: 20),

        TextButton(
          onPressed: rollDice , 
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(
            top: 20),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            )
          ),
          child: const Text('Roll Dice'),
          )
        ],
      ),
      )
    );
  }
}


class GradientContainer2 extends StatelessWidget {

  const GradientContainer2(this.color1, this.color2, {super.key});

  const GradientContainer2.purple({super.key})
    : color1 = Colors.deepPurple,
      color2 = Colors.indigo;

  final Color color1;
  final Color color2;

  @override
  Widget build(context){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: StartAlignment,
          end: endAlignment,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      )
    );
  }

}