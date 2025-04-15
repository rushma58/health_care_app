import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors.dart';
import 'package:health_care_app/core/constants/app_constants.dart';
import 'package:health_care_app/core/constants/text_styles.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isUser;
  final String? timestamp;
  final String? imageUrl;

  const ChatMessage({
    super.key,
    required this.message,
    required this.isUser,
    this.timestamp,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CustomPaint(
              painter: ChatBubblePainter(
                color: AppColors.lightGrey,
                alignment: ChatBubbleAlignment.left,
              ),
              // child: const SizedBox(width: 8, height: 8),
            ),
          ] else ...[
            const SizedBox(width: 10)
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : AppColors.lightGrey,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppConstants.borderRadius),
                  topRight: const Radius.circular(AppConstants.borderRadius),
                  bottomLeft:
                      Radius.circular(isUser ? AppConstants.borderRadius : 0),
                  bottomRight:
                      Radius.circular(isUser ? 0 : AppConstants.borderRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null) ...[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadius),
                      child: Image.network(
                        imageUrl!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 200,
                            height: 200,
                            color: AppColors.lightGrey,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
                            color: AppColors.lightGrey,
                            child: const Icon(
                              Icons.error_outline,
                              color: AppColors.danger,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    message,
                    style: TextStyles.regular14.copyWith(
                      color: isUser ? AppColors.white : AppColors.black,
                    ),
                  ),
                  if (timestamp != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      timestamp!,
                      style: TextStyles.regular10.copyWith(
                        color: isUser
                            ? AppColors.white.withOpacity(0.7)
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isUser) ...[
            CustomPaint(
              painter: ChatBubblePainter(
                color: AppColors.primary,
                alignment: ChatBubbleAlignment.right,
              ),
              // child: const SizedBox(width: 8, height: 8),
            ),
          ] else ...[
            const SizedBox(width: 10)
          ],
        ],
      ),
    );
  }
}

enum ChatBubbleAlignment { left, right }

class ChatBubblePainter extends CustomPainter {
  final Color color;
  final ChatBubbleAlignment alignment;

  ChatBubblePainter({
    required this.color,
    required this.alignment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    if (alignment == ChatBubbleAlignment.left) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(size.width, size.height);
      path.lineTo(0, 0);
      path.lineTo(0, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ChatBubblePainter oldDelegate) =>
      color != oldDelegate.color || alignment != oldDelegate.alignment;
}
