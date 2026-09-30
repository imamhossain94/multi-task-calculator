import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/constant.dart';
import '../utils/extensions.dart';

/// Shown when the user gives 3 stars or fewer and is sent here for feedback.
class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(Icons.sentiment_dissatisfied_rounded,
                size: 72, color: Colors.amber),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'We are sorry to hear that',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your rating means a lot. Tell us what went wrong or what is '
              'missing and we will work on it.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: () => openExternal(context, feedbackMail),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadii.allMd,
                    ),
                  ),
                  icon: const Icon(Icons.mail_outline_rounded),
                  label: const Text('Email us'),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () => openExternal(context, storeLink),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadii.allMd,
                    ),
                  ),
                  icon: const Icon(Icons.reviews_outlined),
                  label: const Text('Leave a Play Store review'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
