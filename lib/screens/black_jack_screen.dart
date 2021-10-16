import 'dart:math';

import 'package:flutter/material.dart';


class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  _BlackJackScreenState createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  Random random = Random();

  bool gameOn = false;
  final Map<String, int> deckOfCards = {
    "assets/cards/2.1.png": 2,
    "assets/cards/2.2.png": 2,
    "assets/cards/2.3.png": 2,
    "assets/cards/2.4.png": 2,
    "assets/cards/3.1.png": 3,
    "assets/cards/3.2.png": 3,
    "assets/cards/3.3.png": 3,
    "assets/cards/3.4.png": 3,
    "assets/cards/4.1.png": 4,
    "assets/cards/4.2.png": 4,
    "assets/cards/4.3.png": 4,
    "assets/cards/4.4.png": 4,
    "assets/cards/5.1.png": 5,
    "assets/cards/5.2.png": 5,
    "assets/cards/5.3.png": 5,
    "assets/cards/5.4.png": 5,
    "assets/cards/6.1.png": 6,
    "assets/cards/6.2.png": 6,
    "assets/cards/6.3.png": 6,
    "assets/cards/6.4.png": 6,
    "assets/cards/7.1.png": 7,
    "assets/cards/7.2.png": 7,
    "assets/cards/7.3.png": 7,
    "assets/cards/7.4.png": 7,
    "assets/cards/8.1.png": 8,
    "assets/cards/8.2.png": 8,
    "assets/cards/8.3.png": 8,
    "assets/cards/8.4.png": 8,
    "assets/cards/9.1.png": 9,
    "assets/cards/9.2.png": 9,
    "assets/cards/9.3.png": 9,
    "assets/cards/9.4.png": 9,
    "assets/cards/10.1.png": 10,
    "assets/cards/10.2.png": 10,
    "assets/cards/10.3.png": 10,
    "assets/cards/10.4.png": 10,
    "assets/cards/J1.png": 10,
    "assets/cards/J2.png": 10,
    "assets/cards/J3.png": 10,
    "assets/cards/J4.png": 10,
    "assets/cards/Q1.png": 10,
    "assets/cards/Q2.png": 10,
    "assets/cards/Q3.png": 10,
    "assets/cards/Q4.png": 10,
    "assets/cards/K1.png": 10,
    "assets/cards/K2.png": 10,
    "assets/cards/K3.png": 10,
    "assets/cards/K4.png": 10,
    "assets/cards/A1.png": 11,
    "assets/cards/A2.png": 11,
    "assets/cards/A3.png": 11,
    "assets/cards/A4.png": 11,
  };
  Map<String, int> playingCards = {};
  List<Image> myCards = [], dealerCards = [];
  String? dealerFirstCard, dealerSecondCard;
  String? playersFirstCard, playersSecondCard;
  int playerScore = 0, dealerScore = 0;

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }


  void changeCards(){
    setState(() {
      gameOn = true;
    });

    playingCards = {};
    playingCards.addAll(deckOfCards);

    myCards = [];
    dealerCards = [];

    String cardOneKeyDealer = playingCards.keys.elementAt(random.nextInt(playingCards.length)); // random card from #1 to #32 included
    playingCards.removeWhere((key, value) => key == cardOneKeyDealer); // remove selected card from all cards list

    String cardTwoKeyDealer = playingCards.keys.elementAt(random.nextInt(playingCards.length)); // random card from #1 to #32 included
    playingCards.removeWhere((key, value) => key == cardTwoKeyDealer);

    String cardOneKey = playingCards.keys.elementAt(random.nextInt(playingCards.length)); // random card from #1 to #32 included
    playingCards.removeWhere((key, value) => key == cardOneKey); // remove selected card from all cards list

    String cardTwoKey = playingCards.keys.elementAt(random.nextInt(playingCards.length)); // random card from #1 to #32 included
    playingCards.removeWhere((key, value) => key == cardTwoKey); // remove selected card from all cards list

    // remove selected card from all cards list
    dealerFirstCard = cardOneKeyDealer;
    dealerSecondCard = cardTwoKeyDealer;

    playersFirstCard = cardOneKey;
    playersSecondCard = cardTwoKey;

    dealerCards.add(Image.asset(dealerFirstCard!));
    dealerCards.add(Image.asset(dealerSecondCard!));

    myCards.add(Image.asset(playersFirstCard!));
    myCards.add(Image.asset(playersSecondCard!));

    dealerScore = deckOfCards[dealerFirstCard]! + deckOfCards[dealerSecondCard]!;
    playerScore = deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!;

    if (dealerScore <=14){
      String thirdDealerCardKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == thirdDealerCardKey);
      dealerCards.add(Image.asset(thirdDealerCardKey));
      dealerScore+= deckOfCards[thirdDealerCardKey]!;
    }
    checkWin();
  }

  void checkWin(){
    if(dealerScore > 21){
      print("Player won");
    }else if(playerScore >21){
      print("Dealer won");
    } else if(playerScore >= dealerScore){
      print("Player won");}
      else {print ("Dealer won");
    }
  }

  void addCard(){
    checkWin();
    if(playingCards.isNotEmpty) {
      String cardKey = playingCards.keys.elementAt(
          random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == cardKey);
      setState(() {
        myCards.add(Image.asset(cardKey));
      });
      playerScore += deckOfCards[cardKey]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gameOn ?
      SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Dealer score: $dealerScore",
                    style: TextStyle(
                      color: dealerScore <=21 ? Colors.green : Colors.red,
                    ),),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: dealerCards[index]),
                        itemCount: dealerCards.length,
                        ),
                  ),
                ],
              ), // dealers cards
              Column(
                children: [
                  Text("Player score: $playerScore",
                  style: TextStyle(
                    color: playerScore <=21 ? Colors.green : Colors.red,
                  ),),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                          child: myCards[index]),
                      itemCount: myCards.length,
                    ),
                  ),
                ],
              ), // players cards
              IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MaterialButton(
                      child: const Text("Another card"),
                      color: Colors.brown[200],
                      onPressed: addCard,
                    ),
                    MaterialButton(
                      child: const Text("Next round"),
                      color: Colors.brown[200],
                      onPressed: changeCards,
                    ),
                    MaterialButton(
                      child: const Text("Stay"),
                      color: Colors.brown[200],
                      onPressed: checkWin,
                    ),
                  ],
                ),
              ), // 2 buttons
            ],
          ),
        ),
      )
          :
      Center(
        child: MaterialButton(
          child: const Text("Start game"),
          color: Colors.brown[200],
          onPressed: changeCards,
        ),
      ),
    );
  }
}
