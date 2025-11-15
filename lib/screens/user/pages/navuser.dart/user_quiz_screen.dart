import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Your custom UI palette
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kBackground = Color(0xFFEEEEEE);
const kCardBackground = Color(0xFFFFFFFF);

final userQuizProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from('road_sign_quiz')
      .select('*')
      .order('created_at');
  return List<Map<String, dynamic>>.from(response);
});

Future<void> saveUserQuizScore({
  required int totalQuestions,
  required int correctAnswers,
  required List<int> selectedAnswers,
}) async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) return;

  final score = (correctAnswers / totalQuestions) * 100;
  await supabase.from('quiz_attempts').insert({
    'user_id': userId,
    'total_questions': totalQuestions,
    'correct_answers': correctAnswers,
    'score': score,
    'answers': selectedAnswers,
  });
}

class UserQuizScreen extends ConsumerStatefulWidget {
  const UserQuizScreen({super.key});

  @override
  ConsumerState<UserQuizScreen> createState() => _UserQuizScreenState();
}

class _UserQuizScreenState extends ConsumerState<UserQuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  int score = 0;
  bool showExplanation = false;
  List<int> selectedOptions = [];

  void _nextQuestion(int totalQuestions) {
    setState(() {
      if (currentQuestionIndex < totalQuestions - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        showExplanation = false;
      } else {
        saveUserQuizScore(
          totalQuestions: totalQuestions,
          correctAnswers: score,
          selectedAnswers: selectedOptions,
        );
        currentQuestionIndex++;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedOptionIndex = null;
      score = 0;
      showExplanation = false;
      selectedOptions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizAsync = ref.watch(userQuizProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          "🚦 Road Sign Quiz",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/user/home'),
        ),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: quizAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text("Error: $err", style: TextStyle(color: Colors.red)),
        ),
        data: (quizList) {
          if (quizList.isEmpty) {
            return const Center(child: Text("No quiz questions found."));
          }

          if (currentQuestionIndex >= quizList.length) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "🎉 Quiz Completed!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your Score: $score / ${quizList.length}",
                    style: TextStyle(fontSize: 18, color: kTextSecondary),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text("Restart Quiz"),
                  ),
                ],
              ),
            );
          }

          final quiz = quizList[currentQuestionIndex];
          final List<String> options = List<String>.from(quiz['options']);
          final int correctIndex = quiz['correct_index'];
          final String? explanation = quiz['explanation'];
          final String? imageUrl = quiz['image_url'];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Card(
                color: kCardBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl != null && imageUrl.isNotEmpty)
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        "Q${currentQuestionIndex + 1}: ${quiz['question_text']}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(options.length, (i) {
                        final isSelected = selectedOptionIndex == i;
                        final isCorrect = i == correctIndex;
                        final isWrong = isSelected && !isCorrect;

                        Color? bgColor;
                        if (selectedOptionIndex != null) {
                          if (isCorrect) bgColor = Colors.green;
                          if (isWrong) bgColor = Colors.red;
                        }

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bgColor ?? Colors.grey[200],
                              foregroundColor: kTextPrimary,
                              padding: const EdgeInsets.all(14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: selectedOptionIndex != null
                                ? null
                                : () {
                                    setState(() {
                                      selectedOptionIndex = i;
                                      selectedOptions.add(i);
                                      showExplanation = true;
                                      if (i == correctIndex) score++;
                                    });
                                  },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                options[i],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      if (selectedOptionIndex != null && showExplanation)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            Text(
                              selectedOptionIndex == correctIndex
                                  ? "✅ Correct!"
                                  : "❌ Incorrect. Correct answer: ${options[correctIndex]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: selectedOptionIndex == correctIndex
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            if (explanation != null && explanation.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text("📝 Explanation: $explanation"),
                              ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => _nextQuestion(quizList.length),
                              child: const Text("Next"),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
