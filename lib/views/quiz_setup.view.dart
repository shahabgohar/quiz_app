import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/views/home.view.dart';

class QuizSetup extends StatefulWidget {
  static const route = '/setup';
  const QuizSetup({Key? key}) : super(key: key);

  @override
  _QuizSetupState createState() => _QuizSetupState();
}

class _QuizSetupState extends State<QuizSetup> {
  final _questionController = TextEditingController();
  final List<String> _categoryLevel = [
    'any',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32'
  ];
  late String _selectedCategory;
  final List<String> _difficultyLevel = ['any', 'easy', 'medium', 'hard'];
  late final String _selectedDifficulty;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categoryLevel[0];
    _selectedDifficulty = _difficultyLevel[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Welcome to QuizApp'),
            backgroundColor: Colors.transparent,
            elevation: 0.0),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose Options for your quiz',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                            controller: _questionController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                label: Text('Choose Cateogry'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: DropdownButtonFormField(
                            isExpanded: true,
                            hint: const Text('Choose the type of Questions'),
                            value: _selectedCategory,
                            items: _categoryLevel
                                .map<DropdownMenuItem>((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: DropdownButtonFormField(
                            hint: const Text('choose the difficulty level'),
                            isExpanded: true,
                            value: _selectedDifficulty,
                            items: _difficultyLevel
                                .map<DropdownMenuItem>((e) =>
                                    DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                .toList()),
                      ),
                    ],
                  )),
            ),
            Flexible(flex: 1, child: Container()),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.route, (Route<dynamic> route) => false);
                  },
                  child: const Text('Start your Quiz')),
            )
          ],
        ),
      ),
    );
  }
}
