import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  final String subjectName;
  final String subjectIcon;

  const ExamPage({
    super.key,
    required this.subjectName,
    required this.subjectIcon,
  });

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int _currentQuestionIndex = 0;
  List<int?> _selectedAnswers = List.filled(5, null);
  bool _isExamSubmitted = false;
  int _score = 0;
  final PageController _pageController = PageController();

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
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
      _pageController.jumpToPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.subjectName + ' MCQ Test',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF33C4A9),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: _isExamSubmitted 
          ? _buildResultsPage() 
          : Column(
              children: [
                _buildTopProgressBar(),
                Expanded(
                  child: _buildExamContent(),
                ),
              ],
            ),
      ),
      bottomNavigationBar: _isExamSubmitted 
        ? null 
        : _buildBottomNavigation(),
    );
  }

  Widget _buildTopProgressBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF33C4A9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.white, size: 18),
                    const SizedBox(width: 5),
                    const Text(
                      '10:00',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildExamContent() {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _questions.length,
      onPageChanged: (index) {
        setState(() {
          _currentQuestionIndex = index;
        });
      },
      itemBuilder: (context, index) {
        final question = _questions[index];
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question number and badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF33C4A9).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF33C4A9),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Q${index + 1}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF33C4A9),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Question text
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  question['question'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              
              // Options
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: question['options'].length,
                itemBuilder: (context, optionIndex) {
                  final isSelected = _selectedAnswers[index] == optionIndex;
                  return GestureDetector(
                    onTap: () => _selectAnswer(optionIndex),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isSelected 
                          ? const Color(0xFF33C4A9).withOpacity(0.1) 
                          : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected 
                            ? const Color(0xFF33C4A9) 
                            : Colors.grey.withOpacity(0.2),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected 
                          ? [
                              BoxShadow(
                                color: const Color(0xFF33C4A9).withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ] 
                          : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isSelected 
                                ? const Color(0xFF33C4A9) 
                                : Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : Text(
                                    String.fromCharCode(65 + optionIndex), // A, B, C, D
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected 
                                        ? Colors.white 
                                        : Colors.black87,
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              question['options'][optionIndex],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected 
                                  ? const Color(0xFF33C4A9) 
                                  : Colors.black87,
                                fontWeight: isSelected 
                                  ? FontWeight.w500 
                                  : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;
    final isFirstQuestion = _currentQuestionIndex == 0;
    final hasSelectedAnswer = _selectedAnswers[_currentQuestionIndex] != null;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous button
          ElevatedButton(
            onPressed: isFirstQuestion ? null : _previousQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF33C4A9),
              disabledForegroundColor: Colors.grey.withOpacity(0.5),
              disabledBackgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isFirstQuestion 
                    ? Colors.grey.withOpacity(0.3) 
                    : const Color(0xFF33C4A9),
                ),
              ),
            ),
            child: const Text(
              'Previous',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Next/Submit button
          ElevatedButton(
            onPressed: hasSelectedAnswer 
              ? (isLastQuestion ? _checkAnswers : _nextQuestion)
              : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF33C4A9),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              isLastQuestion ? 'Submit' : 'Next',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsPage() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Score circle
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: _score >= 3 
                    ? const Color(0xFF33C4A9).withOpacity(0.2) 
                    : Colors.orange.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
              border: Border.all(
                color: _score >= 3 
                  ? const Color(0xFF33C4A9) 
                  : Colors.orange,
                width: 3,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_score',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: _score >= 3 
                        ? const Color(0xFF33C4A9) 
                        : Colors.orange,
                    ),
                  ),
                  Text(
                    'out of ${_questions.length}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          // Result message
          Text(
            _score >= 3 ? 'Great job!' : 'Better luck next time!',
            style: const TextStyle(
              fontSize: 28,
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
          
          // Performance details
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                _buildPerformanceRow(
                  'Correct Answers', 
                  '$_score',
                  const Color(0xFF33C4A9)
                ),
                const SizedBox(height: 10),
                _buildPerformanceRow(
                  'Wrong Answers', 
                  '${_questions.length - _score}',
                  Colors.red.shade300
                ),
                const SizedBox(height: 10),
                _buildPerformanceRow(
                  'Accuracy', 
                  '${(_score / _questions.length * 100).toStringAsFixed(0)}%',
                  Colors.blue.shade300
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _resetExam,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33C4A9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.list),
                  label: const Text('All Exams'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF33C4A9),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Color(0xFF33C4A9)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}