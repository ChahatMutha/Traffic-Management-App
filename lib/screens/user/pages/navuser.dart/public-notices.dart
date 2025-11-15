import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

class PublicNotice {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String? photoUrl;

  PublicNotice({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.photoUrl,
  });
}

final noticeListProvider = FutureProvider<List<PublicNotice>>((ref) async {
  final client = Supabase.instance.client;
  final response = await client
      .from('public_notices')
      .select('*')
      .order('created_at', ascending: false);

  final List<PublicNotice> result = [];

  for (final item in response) {
    String? signedUrl;

    if (item['photo_url'] != null && item['photo_url'] != '') {
      final filePath = item['photo_url'];
      final res = await client.storage
          .from('notice-photos')
          .createSignedUrl(filePath, 60 * 60 * 24);
      signedUrl = res;
    }

    result.add(
      PublicNotice(
        id: item['id'],
        title: item['title'],
        description: item['description'],
        createdAt: DateTime.parse(item['created_at']),
        photoUrl: signedUrl,
      ),
    );
  }

  return result;
});

class PublicNoticeScreen extends ConsumerWidget {
  const PublicNoticeScreen({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open the file')));
    }
  }

  Future<void> _downloadFile(BuildContext context, String url) async {
    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Storage permission denied')),
          );
          return;
        }
      }

      final uri = Uri.parse(url);
      final fileName = uri.pathSegments.last.split('?').first;

      Directory? downloadDir;

      if (Platform.isAndroid) {
        downloadDir = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadDir = await getApplicationDocumentsDirectory();
      }

      if (downloadDir == null || !(await downloadDir.exists())) {
        downloadDir = await getExternalStorageDirectory();
      }

      final filePath = '${downloadDir!.path}/$fileName';
      final dio = Dio();

      final response = await dio.download(url, filePath);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Downloaded to: $filePath')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Download failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Download error: $e')));
    }
  }

  void _showFullDescription(
    BuildContext context,
    String title,
    String description,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(child: Text(description)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticesAsync = ref.watch(noticeListProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimary),
          onPressed: () => context.go('/user/home'),
        ),
        title: const Text(
          'Public Notices',
          style: TextStyle(
            color: kTextPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: noticesAsync.when(
        data: (notices) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notices.length,
          itemBuilder: (context, index) {
            final notice = notices[index];
            final formattedDate = DateFormat(
              'd MMM yyyy',
            ).format(notice.createdAt);

            return Card(
              color: kCardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notice.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kTextPrimary,
                                ),
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 12,
                                color: kTextSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notice.description,
                          style: const TextStyle(color: kTextSecondary),
                          softWrap: true,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => _showFullDescription(
                                context,
                                notice.title,
                                notice.description,
                              ),
                              child: const Text(
                                'Read More',
                                style: TextStyle(color: kPrimary),
                              ),
                            ),
                            const Spacer(),
                            if (notice.photoUrl != null) ...[
                              IconButton(
                                tooltip: 'View File',
                                icon: const Icon(
                                  Icons.visibility,
                                  color: kPrimary,
                                ),
                                onPressed: () =>
                                    _openLink(context, notice.photoUrl!),
                              ),
                              IconButton(
                                tooltip: 'Download File',
                                icon: const Icon(
                                  Icons.download,
                                  color: kPrimary,
                                ),
                                onPressed: () =>
                                    _downloadFile(context, notice.photoUrl!),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator(color: kPrimary)),
        error: (e, _) => Center(
          child: Text(
            'Error loading notices.\n$e',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
