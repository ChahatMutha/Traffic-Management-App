import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// === Color Palette ===
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);
const kSuccess = Colors.green;
const kError = Colors.red;

/// === Providers ===
final quizProvider =
    StateNotifierProvider<QuizNotifier, List<Map<String, dynamic>>>(
      (ref) => QuizNotifier()..loadQuizzes(),
    );

final toggleIndexProvider = StateProvider<int>((ref) => 0);

class QuizNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  QuizNotifier() : super([]);

  final supabase = Supabase.instance.client;

  Future<void> loadQuizzes() async {
    final data = await supabase
        .from('road_sign_quiz')
        .select('*')
        .order('created_at');
    state = List<Map<String, dynamic>>.from(data);
  }

  Future<String?> uploadImage(File file) async {
    final fileName = const Uuid().v4();
    final filePath = 'quiz-images/$fileName.jpg';
    final storageRef = supabase.storage.from('road-signs');

    try {
      await storageRef.upload(filePath, file);
      final url = await storageRef.createSignedUrl(filePath, 60 * 60 * 24 * 7);
      return url;
    } catch (e) {
      return null;
    }
  }

  Future<bool> addQuiz({
    required String question,
    required List<String> options,
    required int correctIndex,
    required String explanation,
    required File imageFile,
  }) async {
    final imageUrl = await uploadImage(imageFile);
    if (imageUrl == null) throw 'Failed to upload image.';

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) throw 'User not authenticated.';

    await supabase.from('road_sign_quiz').insert({
      'question_text': question,
      'options': options,
      'correct_index': correctIndex,
      'explanation': explanation,
      'image_url': imageUrl,
      'added_by': userId,
    });

    await loadQuizzes();
    return true;
  }
}

/// === Screen ===
class AdminQuizUploadScreen extends ConsumerWidget {
  const AdminQuizUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggleIndex = ref.watch(toggleIndexProvider);
    final quizzes = ref.watch(quizProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        title: const Text("Admin Quiz Panel"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin/home'),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: kCardBackground,
            child: ToggleButtons(
              isSelected: [toggleIndex == 0, toggleIndex == 1],
              onPressed: (index) {
                ref.read(toggleIndexProvider.notifier).state = index;
              },
              selectedColor: Colors.white,
              color: kPrimary,
              fillColor: kPrimary,
              borderRadius: BorderRadius.circular(12),
              constraints: const BoxConstraints(minHeight: 40, minWidth: 150),
              children: const [Text("Add Quiz"), Text("My Quizzes")],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: toggleIndex == 0
                ? AddQuizForm()
                : quizzes.isEmpty
                ? const Center(child: Text("No quizzes found"))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: quizzes.length,
                    itemBuilder: (context, index) {
                      final quiz = quizzes[index];
                      final List options = quiz['options'] is String
                          ? jsonDecode(quiz['options'])
                          : quiz['options'];
                      return Card(
                        color: kCardBackground,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (quiz['image_url'] != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    quiz['image_url'],
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                )
                              else
                                const Icon(Icons.image_not_supported, size: 70),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      quiz['question_text'] ?? 'No question',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kTextPrimary,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Answer: ${options[quiz['correct_index']]}",
                                      style: TextStyle(color: kTextSecondary),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Explanation: ${quiz['explanation'] ?? ''}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: kTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// === Add Quiz Form ===
class AddQuizForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddQuizForm> createState() => _AddQuizFormState();
}

class _AddQuizFormState extends ConsumerState<AddQuizForm> {
  bool _isLoading = false;
  final questionController = TextEditingController();
  final explanationController = TextEditingController();
  final optionControllers = List.generate(4, (_) => TextEditingController());
  int correctIndex = 0;
  File? selectedImage;

  void _showSnackbar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? kPrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _submit() async {
    final question = questionController.text.trim();
    final options = optionControllers.map((e) => e.text.trim()).toList();
    final explanation = explanationController.text.trim();

    if (question.isEmpty ||
        options.any((o) => o.isEmpty) ||
        explanation.isEmpty ||
        selectedImage == null) {
      _showSnackbar(
        "Please fill all fields and select an image.",
        color: kError,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref
          .read(quizProvider.notifier)
          .addQuiz(
            question: question,
            options: options,
            correctIndex: correctIndex,
            explanation: explanation,
            imageFile: selectedImage!,
          );
      _showSnackbar("Quiz added successfully!", color: kSuccess);

      // Reset
      questionController.clear();
      explanationController.clear();
      for (final controller in optionControllers) {
        controller.clear();
      }
      selectedImage = null;
    } catch (e) {
      _showSnackbar("Error: $e", color: kError);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: questionController,
            decoration: const InputDecoration(labelText: "Question"),
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          ...List.generate(
            4,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: TextField(
                controller: optionControllers[i],
                decoration: InputDecoration(labelText: "Option ${i + 1}"),
              ),
            ),
          ),
          DropdownButtonFormField<int>(
            value: correctIndex,
            items: List.generate(
              4,
              (i) => DropdownMenuItem(
                value: i,
                child: Text("Correct: Option ${i + 1}"),
              ),
            ),
            onChanged: (val) => setState(() => correctIndex = val ?? 0),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: explanationController,
            decoration: const InputDecoration(labelText: "Explanation"),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.image),
            label: const Text("Select Image"),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
              if (result != null && result.files.single.path != null) {
                setState(() => selectedImage = File(result.files.single.path!));
              }
            },
          ),
          if (selectedImage != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Selected: ${selectedImage!.path.split('/').last}",
                style: TextStyle(color: kTextSecondary, fontSize: 12),
              ),
            ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(45),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : const Text("Submit Quiz"),
          ),
        ],
      ),
    );
  }
}
