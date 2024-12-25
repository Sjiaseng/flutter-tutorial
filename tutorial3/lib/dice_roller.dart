import 'package:flutter/material.dart';
import 'dart:math';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
    //var activeDiceImage = '/images/dice-2.png';

    /*  
    void rollDice(){
      setState(() {
        activeDiceImage = '/images/dice-4.png';
      });
    }
    */
    var currentDiceRoll = 2;
    void rollDice(){
      setState(() {
        currentDiceRoll = randomizer.nextInt(6) + 1;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(
          height:20,
        ),
        TextButton(
          onPressed: rollDice, 
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(
              top: 20,
            ),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 28,
          ),
          ),
        child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}