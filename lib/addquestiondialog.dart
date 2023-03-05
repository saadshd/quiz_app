import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';

QuizBrain quizBrain = QuizBrain();

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  TextEditingController textController = TextEditingController();
  String questionText = "";
  bool questionAnswer = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Questions'),
      content: SizedBox(
        width: 300,
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Enter Question',
              ),
            ),
            const SizedBox(height: 10),
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
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('DONE'),
        ),
      ],
    );
  }
}
