import 'package:flutter/material.dart';
import 'package:quiz_app/addquestiondialog.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/quizpage.dart';

QuizBrain quizBrain = QuizBrain();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  String questionText = "";
  bool questionAnswer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        automaticallyImplyLeading: true,
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
                  surfaceTintColor: Colors.grey,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade50,
                          child: const Image(
                            image: AssetImage('images/quiz.png'),
                          ),
                        ),
                        const Text('Add Questions',
                          style: TextStyle(
                            fontSize: 26,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Question',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: (){
                                  questionAnswer = true;
                                  questionText = textController.text;
                                  quizBrain.addQuestion(questionText, questionAnswer);
                                  textController.clear();
                                },
                                child: const Text('True')
                            ),
                            TextButton(
                                onPressed: (){
                                  questionAnswer = false;
                                  questionText = textController.text;
                                  quizBrain.addQuestion(questionText, questionAnswer);
                                  textController.clear();
                                },
                                child: const Text('False')
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60,),
                // ElevatedButton(
                //     onPressed: (){
                //       showDialog(
                //           context: context,
                //           builder: (BuildContext context) {
                //             return const AddQuestion();
                //           });
                //     },
                //     child: const Text('Add Question')
                // ),
                // const SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () {
                      if (questionText.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Add Questions'),
                                content: const Text('Add Questions to proceed'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            }
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPage(quizBrain: quizBrain,)),
                        );
                        quizBrain.shuffle();
                      }
                    },
                    child: const Text('Start Quiz')
                ),
              ],
            ),
          ),
        ),
      );
  }
}


