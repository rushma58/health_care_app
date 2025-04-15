import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/app_spaces.dart';
import 'package:health_care_app/core/utils/app_bars/custom_app_bar.dart';
import 'package:health_care_app/core/utils/inputs/custom_input.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'component/chat_message.dart';

@RoutePage()
class AiConversationScreen extends StatefulWidget implements AutoRouteWrapper {
  const AiConversationScreen({super.key});

  @override
  State<AiConversationScreen> createState() => _AiConversationScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _AiConversationScreenState extends State<AiConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  String? _apiKey;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadApiKey();
    _addWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadApiKey() async {
    await dotenv.load(fileName: ".env");
    setState(() {
      _apiKey = dotenv.env['GEMINI_API_KEY'];
    });
  }

  void _addWelcomeMessage() {
    _messages.add({
      'message':
          'Hello! I\'m your AI health assistant. How can I help you with your diet and health concerns today?',
      'isUser': false,
      'timestamp': _getCurrentTime(),
    });
  }

  String _getCurrentTime() {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _messages.add({
            'message': 'Image sent',
            'isUser': true,
            'timestamp': _getCurrentTime(),
            'imageUrl': image.path,
          });
        });
        _scrollToBottom();
        // Here you can add logic to process the image with Gemini API
        // For example, you can use Gemini's vision capabilities
      }
    } catch (e) {
      log('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty || _apiKey == null) return;

    final userMessage = _messageController.text.trim();
    _messageController.clear();

    setState(() {
      _messages.add({
        'message': userMessage,
        'isUser': true,
        'timestamp': _getCurrentTime(),
      });
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final model =
          GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey!);
      final prompt = '''
You are a health and diet assistant. Please provide helpful, accurate, and concise responses about diet and health-related questions.
User's question: $userMessage
''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _messages.add({
          'message':
              response.text ?? 'Sorry, I couldn\'t process your request.',
          'isUser': false,
          'timestamp': _getCurrentTime(),
        });
        _isLoading = false;
      });

      _scrollToBottom();
    } catch (e) {
      log('Error generating response: $e');
      setState(() {
        _messages.add({
          'message':
              'Sorry, there was an error processing your request. Please try again.',
          'isUser': false,
          'timestamp': _getCurrentTime(),
        });
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: 'AI Health Assistant',
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppConstants.screenPadding),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatMessage(
                    message: message['message'],
                    isUser: message['isUser'],
                    timestamp: message['timestamp'],
                    imageUrl: message['imageUrl'],
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Container(
              padding: const EdgeInsets.all(AppConstants.screenPadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Iconify(
                      MaterialSymbols.image,
                      color: AppColors.primary,
                      size: AppConstants.mediumIconSize,
                    ),
                  ),
                  AppSpaces.medium,
                  Expanded(
                    child: CustomInput(
                      controller: _messageController,
                      hint: 'Type your message...',
                      isPassword: false,
                      textInputType: TextInputType.text,
                      onSubmit: (_) => _sendMessage(),
                    ),
                  ),
                  AppSpaces.medium,
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Iconify(
                      MaterialSymbols.send,
                      color: AppColors.primary,
                      size: AppConstants.mediumIconSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
