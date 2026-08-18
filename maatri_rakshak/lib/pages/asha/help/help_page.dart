import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/colors.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'What should I do when a patient is identified as high risk?',
      'answer':
          'Escalate according to your clinical protocol, document the findings, arrange urgent review or referral, and seek qualified medical guidance without delay.',
    },
    {
      'question': 'What does the maternal risk score mean?',
      'answer':
          'It is a decision-support screening indicator based on vitals, symptoms, and context. It does not replace a doctor\'s assessment or approved clinical protocol.',
    },
    {
      'question': 'How do I create a new patient?',
      'answer':
          'Use the Patients module and add the patient profile with required personal and pregnancy information before completing an assessment.',
    },
    {
      'question': 'How do I perform an assessment?',
      'answer':
          'Open a patient profile, complete the assessment checklist, capture the latest vitals, review danger signs, and submit the record for follow-up.',
    },
    {
      'question': 'How do I book emergency transport?',
      'answer':
          'From the Transport module, select the patient, choose a pickup location, pick the destination facility, and confirm the transport booking.',
    },
    {
      'question': 'Where can I find doctor reviews?',
      'answer':
          'Go to the Reports section and open the Doctor Review tab to view consultation summaries and follow-up guidance.',
    },
    {
      'question': 'How does offline mode work?',
      'answer':
          'Offline mode stores local data so the app remains usable without connectivity. Sync status will update once connectivity is available.',
    },
  ];

  bool _aiOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Help & Support',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.deepNavy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Find answers, guidance and assistance while using MaatriRakshak.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 22),
                _SectionCard(
                  title: 'Frequently Asked Questions',
                  child: Column(
                    children: _faqs
                        .map(
                          (faq) => ExpansionTile(
                            title: Text(
                              faq['question'],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepNavy,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  16,
                                ),
                                child: Text(
                                  faq['answer'],
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    height: 1.5,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'How MaatriRakshak Works',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _BulletText(
                        'Register or identify a patient in the Patients module.',
                      ),
                      _BulletText(
                        'Capture assessment data and current vital signs.',
                      ),
                      _BulletText(
                        'Review risk screening and decide on follow-up or referral.',
                      ),
                      _BulletText(
                        'Book transport and monitor progress in real time.',
                      ),
                      _BulletText(
                        'Generate reports and share reviews with the care team.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'Emergency Guidance',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _BulletText(
                        'Follow local emergency protocols for severe symptoms.',
                      ),
                      _BulletText(
                        'Escalate immediately when risk is high or urgent.',
                      ),
                      _BulletText(
                        'Use this app as decision-support only and seek professional care.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'Contact Support',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ASHA Support Desk',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepNavy,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Phone: +91 20 0000 0000\nEmail: support@maatri-rakshak.in',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.primaryText,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () => setState(() => _aiOpen = !_aiOpen),
            backgroundColor: AppColors.primaryTeal,
            foregroundColor: AppColors.white,
            child: const Icon(Icons.smart_toy_rounded),
          ),
        ),
        if (_aiOpen)
          Positioned(
            right: 20,
            bottom: 90,
            child: Container(
              width: 340,
              constraints: const BoxConstraints(maxHeight: 420),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.lightTeal,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryTeal,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.smart_toy_rounded,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MaatriRakshak Assistant',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.deepNavy,
                                ),
                              ),
                              Text(
                                'AI-assisted support',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() => _aiOpen = false),
                          icon: const Icon(Icons.close_rounded),
                          color: AppColors.deepNavy,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ChatBubble(
                            text:
                                'Hello! I can help with risk guidance, transport, reports, and app support.',
                            isUser: false,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: const [
                              _SuggestedChip(
                                'What does a high risk score mean?',
                              ),
                              _SuggestedChip('How do I assess a mother?'),
                              _SuggestedChip('How do I book transport?'),
                              _SuggestedChip(
                                'Where can I find doctor reviews?',
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Decision-support information only. Follow approved clinical protocols and professional medical advice.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Ask a question...',
                                    filled: true,
                                    fillColor: AppColors.warmCream,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryTeal,
                                  foregroundColor: AppColors.white,
                                ),
                                child: const Text('Send'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;

  const _BulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 8, color: AppColors.primaryTeal),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13,
                height: 1.5,
                color: AppColors.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const _ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primaryTeal : AppColors.lightTeal,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isUser ? AppColors.white : AppColors.deepNavy,
          ),
        ),
      ),
    );
  }
}

class _SuggestedChip extends StatelessWidget {
  final String text;

  const _SuggestedChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightTeal,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          color: AppColors.primaryTeal,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
