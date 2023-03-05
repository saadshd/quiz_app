import 'package:flutter/material.dart';
import 'package:quiz_app/homepage.dart';
import 'package:quiz_app/quiz.dart';

class QuizPage extends StatefulWidget {

  final QuizBrain quizBrain;
  const QuizPage({super.key, required this.quizBrain});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int right =0;
  int wrong=0;
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Finished'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                  const Text( 'You\'ve reached the end of the quiz.'),
                  Text( 'Total correct answers given : $right'),
                  Text( 'Total wrong answers given : $wrong'),
                  ]
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                    right=0;
                    wrong=0;
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
            )
          );
          right++;
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
          wrong++;
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz')
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                      checkAnswer(true);
                    },
                        child: const Text('True')
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                      checkAnswer(false);
                    },
                        child: const Text('False')
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 30,
                child: Row(
                  children: scoreKeeper,
                ),
              ),
            ],
          ),
        ),
      );
  }
}

// import 'package:flutter/material.dart';
// import 'package:quiz_app/quiz.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
//
//
//
//
// class HomePage extends StatefulWidget {
//
//   final QuizBrain quizBrain;
//   HomePage({required this.quizBrain});
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<Icon> scoreKeeper = [];
//
//
//
//   void checkAnswer(bool userPickedAnswer) {
//     bool? correctAnswer = widget.quizBrain.getCorrectAnswer();
//     setState(() {
//       if (widget.quizBrain.isFinished() == true) {
//         Alert(
//           context: context,
//           title: 'Finished!',
//           desc: 'You\'ve reached the end of the quiz.',
//         ).show();
//         widget.quizBrain.reset();
//         scoreKeeper = [];
//       }
//       else {
//         if (userPickedAnswer == correctAnswer) {
//           scoreKeeper.add(const Icon(
//             Icons.check,
//             color: Colors.green,
//           ));
//         } else {
//           scoreKeeper.add(const Icon(
//             Icons.close,
//             color: Colors.red,
//           ));
//         }
//         widget.quizBrain.nextQuestion();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 Colors.yellow,
//                 Colors.black,
//               ],
//             )),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Expanded(
//               flex: 5,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Center(
//                   child: Text(
//                     widget.quizBrain.getQuestionText(),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 25.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.green, // Text Color
//                   ),
//                   child: const Text(
//                     'True',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                   onPressed: () {
//                     checkAnswer(true);
//                   },
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.red, // Text Color
//                   ),
//                   child: const Text(
//                     'False',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onPressed: () {
//                     checkAnswer(false);
//                   },
//                 ),
//               ),
//             ),
//             Row(
//               children: scoreKeeper,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }