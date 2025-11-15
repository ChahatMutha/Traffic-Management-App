// --- Imports ---
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// --- Colors ---
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);
const kGreyTab = Color(0xFFBDBDBD);

// --- Model ---
class PublicNotice {
  final String id;
  final String title;
  final String description;
  final String? photoPath;
  final DateTime createdAt;

  PublicNotice({
    required this.id,
    required this.title,
    required this.description,
    this.photoPath,
    required this.createdAt,
  });

  factory PublicNotice.fromMap(Map<String, dynamic> map) {
    return PublicNotice(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      photoPath: map['photo_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Future<String?> getSignedUrl() async {
    if (photoPath == null) return null;
    final url = await Supabase.instance.client.storage
        .from('notice-photos')
        .createSignedUrl(photoPath!, 60 * 60);
    return url;
  }
}

// --- Providers ---
final noticeCreateProvider = Provider((ref) => NoticeService());

final myNoticeListProvider = FutureProvider<List<PublicNotice>>((ref) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return [];
  final response = await Supabase.instance.client
      .from('public_notices')
      .select('*')
      .eq('admin_id', user.id)
      .order('created_at', ascending: false);
  return response.map((e) => PublicNotice.fromMap(e)).toList();
});

// --- Service ---
class NoticeService {
  final _supabase = Supabase.instance.client;

  Future<void> createNotice({
    required String title,
    required String description,
    File? photoFile,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not logged in');

    String? storagePath;
    if (photoFile != null) {
      final fileNameOnly = photoFile.path.split(Platform.pathSeparator).last;
      storagePath =
          'notices/${DateTime.now().millisecondsSinceEpoch}_$fileNameOnly';
      final fileBytes = await photoFile.readAsBytes();
      await _supabase.storage
          .from('notice-photos')
          .uploadBinary(storagePath, fileBytes);
    }

    await _supabase.from('public_notices').insert({
      'admin_id': user.id,
      'title': title,
      'description': description,
      'photo_url': storagePath,
    });
  }

  Future<void> deleteNotice(String id) async {
    final data = await _supabase
        .from('public_notices')
        .select('photo_url')
        .eq('id', id)
        .maybeSingle();

    if (data != null && data['photo_url'] != null) {
      try {
        await _supabase.storage.from('notice-photos').remove([
          data['photo_url'],
        ]);
      } catch (e) {
        debugPrint('⚠️ Error deleting photo: $e');
      }
    }

    await _supabase.from('public_notices').delete().eq('id', id);
  }
}

// --- Screen ---
class AdminNoticeScreen extends ConsumerStatefulWidget {
  const AdminNoticeScreen({super.key});
  @override
  ConsumerState<AdminNoticeScreen> createState() => _AdminNoticeScreenState();
}

class _AdminNoticeScreenState extends ConsumerState<AdminNoticeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  File? _selectedFile;
  int _selectedTab = 0;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() => _selectedFile = File(result.files.single.path!));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      await ref
          .read(noticeCreateProvider)
          .createNotice(
            title: _title,
            description: _description,
            photoFile: _selectedFile,
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Public Notice Added'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        _selectedFile = null;
        _formKey.currentState?.reset();
      });
      ref.invalidate(myNoticeListProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteNotice(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Notice'),
        content: const Text('Are you sure you want to delete this notice?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await ref.read(noticeCreateProvider).deleteNotice(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🗑️ Notice Deleted'),
          backgroundColor: Colors.green,
        ),
      );
      ref.invalidate(myNoticeListProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/admin/home'),
        ),
        title: const Text(
          'Manage Notices',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              _tabButton("Add Notice", 0),
              _tabButton("My Notices", 1),
            ],
          ),
          Expanded(
            child: _selectedTab == 0
                ? _AddNoticeTab(
                    formKey: _formKey,
                    onSubmit: _submit,
                    pickFile: _pickFile,
                    selectedFile: _selectedFile,
                    onSavedTitle: (v) => _title = v,
                    onSavedDesc: (v) => _description = v,
                  )
                : _MyNoticesTab(onDelete: _deleteNotice),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? (index == 1 ? kPrimary : kPrimary)
              : Colors.transparent,
          foregroundColor: isSelected ? Colors.white : kTextPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () => setState(() => _selectedTab = index),
        child: Text(label),
      ),
    );
  }
}

// --- Add Notice Tab ---
class _AddNoticeTab extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;
  final VoidCallback pickFile;
  final File? selectedFile;
  final ValueChanged<String> onSavedTitle;
  final ValueChanged<String> onSavedDesc;

  const _AddNoticeTab({
    required this.formKey,
    required this.onSubmit,
    required this.pickFile,
    required this.selectedFile,
    required this.onSavedTitle,
    required this.onSavedDesc,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Public Notice',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onSaved: (v) => onSavedTitle(v ?? ''),
              validator: (v) =>
                  v!.trim().isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              onSaved: (v) => onSavedDesc(v ?? ''),
              validator: (v) =>
                  v!.trim().isEmpty ? 'Please enter a description' : null,
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: pickFile,
              icon: const Icon(Icons.photo, color: kPrimary),
              label: const Text(
                'Pick Photo',
                style: TextStyle(color: kPrimary),
              ),
            ),
            if (selectedFile != null)
              const Text(
                '✅ Image selected',
                style: TextStyle(color: Colors.green),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.send),
                label: const Text('Post Notice'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- My Notices Tab ---
class _MyNoticesTab extends ConsumerWidget {
  final void Function(String id) onDelete;
  const _MyNoticesTab({required this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myNoticesAsync = ref.watch(myNoticeListProvider);
    return myNoticesAsync.when(
      data: (notices) => notices.isEmpty
          ? const Center(child: Text('No notices posted by you yet'))
          : ListView.builder(
              itemCount: notices.length,
              itemBuilder: (context, i) {
                final n = notices[i];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  color: kCardBackground,
                  child: ListTile(
                    title: Text(
                      n.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(n.description),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd MMM yyyy').format(n.createdAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: kTextSecondary,
                          ),
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        if (n.photoPath != null)
                          FutureBuilder<String?>(
                            future: n.getSignedUrl(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Icon(Icons.image_not_supported);
                              }
                              return IconButton(
                                icon: const Icon(Icons.image, color: kPrimary),
                                onPressed: () async {
                                  final uri = Uri.parse(snapshot.data!);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Could not open image'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => onDelete(n.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
