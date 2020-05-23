import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain brain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userSelectedAnswer) {
    setState(() {
      scoreKeeper
          .add(getResultIcon(userSelectedAnswer == brain.getQuestionAnswer()));

      if (brain.isEndOfQuestions()) {
        Alert(context: context, title: "Test Finished!",
//            content: Column(
//              children: <Widget>[
//                TextField(
//                  decoration: InputDecoration(
//                    icon: Icon(Icons.account_circle),
//                    labelText: 'Username',
//                  ),
//                ),
//                TextField(
//                  obscureText: true,
//                  decoration: InputDecoration(
//                    icon: Icon(Icons.lock),
//                    labelText: 'Password',
//                  ),
//                ),
//              ],
//            ),
            buttons: [
              DialogButton(
                onPressed: () {
                  brain.resetQuestions();
                  scoreKeeper.clear();
                  setState(() {
                    brain.resetQuestions();
                    scoreKeeper.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
      } else {
        brain.nextQuestion();
      }
    });
  }

  Icon getResultIcon(bool isCorrect) {
    return Icon(
      isCorrect ? Icons.check : Icons.close,
      color: isCorrect ? Colors.green : Colors.red,
    );
  }

  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  brain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
//                      side: BorderSide(color: Colors.red),
                    ),
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'True',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      checkAnswer(true);
                    },
                  ),
                ),
                Text('OR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    )),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
//                      side: BorderSide(color: Colors.red),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'False',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      checkAnswer(false);
                    },
                  ),
                ),
              ],
            ),
          ),
          //TODO: Add a Row here as your score keeper
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          )
        ],
      ),
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
