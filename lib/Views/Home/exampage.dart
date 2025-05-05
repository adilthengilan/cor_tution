// exam_page.dart - MCQ Exam with questions and navigation
import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  final String examTitle;
  final int examIndex;

  const ExamPage({
    Key? key,
    required this.examTitle,
    required this.examIndex,
  }) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int _currentQuestionIndex = 0;
  List<int?> _selectedAnswers = List.filled(5, null);
  bool _isExamSubmitted = false;
  int _score = 0;

  // Questions and answers for 10th standard Kerala state syllabus chemistry
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which of the following is a chemical change?',
      'options': [
        'Melting of ice',
        'Rusting of iron',
        'Evaporation of water',
        'Dissolving salt in water'
      ],
      'correctAnswer': 1,
    },
    {
      'question': 'Litmus paper is obtained from:',
      'options': [
        'Algae',
        'Fungi',
        'Lichens',
        'Bacteria'
      ],
      'correctAnswer': 2,
    },
    {
      'question': 'The gas released during the reaction of zinc with dilute hydrochloric acid is:',
      'options': [
        'Oxygen',
        'Carbon dioxide',
        'Hydrogen',
        'Chlorine'
      ],
      'correctAnswer': 2,
    },
    {
      'question': 'Which among the following has the highest pH value?',
      'options': [
        'Lemon juice',
        'Water',
        'Sodium hydroxide solution',
        'Vinegar'
      ],
      'correctAnswer': 2,
    },
    {
      'question': 'The periodic table was developed by:',
      'options': [
        'Dmitri Mendeleev',
        'J.J. Thomson',
        'Ernest Rutherford',
        'Niels Bohr'
      ],
      'correctAnswer': 0,
    },
  ];

  void _checkAnswers() {
    int totalScore = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i]['correctAnswer']) {
        totalScore++;
      }
    }
    setState(() {
      _score = totalScore;
      _isExamSubmitted = true;
    });
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _selectAnswer(int optionIndex) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = optionIndex;
    });
  }

  void _resetExam() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswers = List.filled(5, null);
      _isExamSubmitted = false;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.examTitle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _isExamSubmitted ? _buildResultsPage() : _buildExamContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildExamContent() {
    final currentQuestion = _questions[_currentQuestionIndex];
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress indicator
        LinearProgressIndicator(
          value: (_currentQuestionIndex + 1) / _questions.length,
          backgroundColor: Colors.grey.withOpacity(0.1),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 15),
        
        // Question counter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1}/${_questions.length}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            // Add a timer widget here if needed
          ],
        ),
        const SizedBox(height: 25),
        
        // Question text
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blue.withOpacity(0.2)),
          ),
          child: Text(
            currentQuestion['question'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 25),
        
        // Answer options
        Expanded(
          child: ListView.builder(
            itemCount: currentQuestion['options'].length,
            itemBuilder: (context, index) {
              final isSelected = _selectedAnswers[_currentQuestionIndex] == index;
              return GestureDetector(
                onTap: () => _selectAnswer(index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        child: Center(
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 18)
                              : Text(
                                  String.fromCharCode(65 + index), // A, B, C, D
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : Colors.grey[700],
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          currentQuestion['options'][index],
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.blue[800] : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        // Navigation buttons
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous button (hidden for first question)
            _currentQuestionIndex > 0
                ? ElevatedButton.icon(
                    onPressed: _previousQuestion,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : const SizedBox(width: 120), // Empty space for alignment
            
            // Next/Submit button
            ElevatedButton.icon(
              onPressed: isLastQuestion ? _checkAnswers : _nextQuestion,
              label: Text(isLastQuestion ? 'Submit' : 'Next'),
              icon: Icon(isLastQuestion ? Icons.check_circle : Icons.arrow_forward),
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastQuestion ? Colors.green : Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultsPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: _score >= 3 ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: _score >= 3 ? Colors.green : Colors.orange,
                width: 3,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_score/${_questions.length}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _score >= 3 ? Colors.green : Colors.orange,
                    ),
                  ),
                  Text(
                    'Score',
                    style: TextStyle(
                      fontSize: 16,
                      color: _score >= 3 ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            _score >= 3 ? 'Great job!' : 'Better luck next time!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _score >= 3
                ? 'You have passed this exam successfully!'
                : 'Keep studying and try again.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Review answers button
              ElevatedButton.icon(
                onPressed: () {
                  // Here you could implement a review screen
                  // For simplicity, we'll just reset the exam
                  _resetExam();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // Back to exams button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.list),
                label: const Text('All Exams'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          // Add a detailed performance breakdown here if needed
        ],
      ),
    );
  }
}