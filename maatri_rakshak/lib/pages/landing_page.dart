import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes.dart';
import '../theme/colors.dart';

class LandingPageWidget extends StatelessWidget {
  const LandingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _LandingHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: const [
                      SizedBox(height: 28),
                      _HeroSection(),
                      SizedBox(height: 28),
                      _CapabilityCards(),
                      SizedBox(height: 72),
                      _AboutSection(),
                      SizedBox(height: 72),
                      _WorkflowSection(),
                      SizedBox(height: 72),
                      _FeatureGridSection(),
                      SizedBox(height: 72),
                      _OfflineSection(),
                      SizedBox(height: 72),
                      _RiskSection(),
                      SizedBox(height: 32),
                      _CTASection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LandingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.lightTeal,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MaatriRakshak',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepNavy,
                          ),
                        ),
                        Text(
                          'Early maternal emergency support',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Routes.signIn),
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(width: 6),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Routes.signUp),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryTeal,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 1100;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBlush,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'OFFLINE-FIRST MATERNAL HEALTH SUPPORT',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Helping ASHA Workers\nAct Earlier. Respond Faster.',
                    style: GoogleFonts.inter(
                      fontSize: compact ? 36 : 54,
                      height: 1.08,
                      fontWeight: FontWeight.w800,
                      color: AppColors.deepNavy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'MaatriRakshak helps ASHA workers identify maternal danger signs, assess urgency, coordinate timely care, and maintain a complete patient case history even when internet connectivity is unreliable.',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      height: 1.6,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(Icons.shield_outlined, color: AppColors.primaryTeal),
                      const SizedBox(width: 8),
                      Text(
                        'Designed for frontline maternal healthcare',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!compact) const SizedBox(width: 24),
            if (!compact)
              Expanded(child: _HeroGraphic())
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: _HeroGraphic(),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _HeroGraphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.softBlush,
            AppColors.warmCream,
            AppColors.lightTeal,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.96),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            child: Container(
              width: 220,
              height: 230,
              decoration: const BoxDecoration(
                color: AppColors.primaryTeal,
                borderRadius: BorderRadius.vertical(top: Radius.circular(110)),
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            left: 120,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: AppColors.softCoralPink,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 150,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 188,
            left: 120,
            child: Container(
              width: 180,
              height: 12,
              decoration: const BoxDecoration(
                color: AppColors.deepNavy,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CapabilityCards extends StatelessWidget {
  const _CapabilityCards();

  @override
  Widget build(BuildContext context) {
    final cards = [
      ['OFFLINE-FIRST', 'Works even with limited connectivity'],
      ['AI-ASSISTED', 'Context-aware support for every patient'],
      ['ACTION-ORIENTED', 'Guides ASHA workers toward timely next steps'],
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: cards.map((card) {
        return SizedBox(
          width: 320,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.lightTeal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primaryTeal,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        card[0],
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryTeal,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card[1],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 900;
        return Row(
          children: [
            if (!compact)
              Expanded(
                child: Container(
                  height: 380,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.softBlush, AppColors.lightTeal],
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.pregnant_woman_rounded,
                      size: 180,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                ),
              ),
            if (!compact) const SizedBox(width: 28),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Built for the Frontline of Maternal Healthcare',
                    style: GoogleFonts.inter(
                      fontSize: compact ? 30 : 38,
                      fontWeight: FontWeight.w800,
                      color: AppColors.deepNavy,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'ASHA workers frequently assess pregnant women in areas where internet connectivity is unreliable, specialist support may not be immediately available, patient information can be fragmented, and emergency decisions need to happen quickly.',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      height: 1.7,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _WorkflowSection extends StatelessWidget {
  const _WorkflowSection();

  @override
  Widget build(BuildContext context) {
    final steps = [
      [
        'Create Patient',
        'ASHA worker creates a patient profile and records pregnancy history.',
      ],
      [
        'Assess',
        'Enter symptoms, vitals, pregnancy history and current condition.',
      ],
      [
        'Identify Risk',
        'The offline risk engine evaluates danger signs and generates risk level and concern list.',
      ],
      [
        'AI Guidance',
        'The patient-specific AI assistant explains the concern and recommends next steps.',
      ],
      ['Find Care', 'Recommend suitable nearby healthcare facilities.'],
      [
        'Coordinate Transport',
        'ASHA worker can find, book and track emergency transport.',
      ],
      [
        'Medical Review',
        'Doctor observations and treatment decisions are recorded.',
      ],
      ['Case Summary', 'A complete case summary and timeline is generated.'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'How MaatriRakshak Works',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: AppColors.deepNavy,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ...steps.map(
          (step) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.lightTeal,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      '0${steps.indexOf(step) + 1}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryTeal,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step[0],
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepNavy,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        step[1],
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          height: 1.6,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
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

class _FeatureGridSection extends StatelessWidget {
  const _FeatureGridSection();

  @override
  Widget build(BuildContext context) {
    final features = [
      [
        'Offline Risk Screening',
        'Assess maternal danger signs even without internet connectivity.',
      ],
      [
        'Multilingual Support',
        'Use English or Marathi for easier interaction in the field.',
      ],
      [
        'AI-Assisted Patient Support',
        'Receive patient-specific explanations and guided questions.',
      ],
      ['Maternal Risk Score', 'Understand risk and urgency at a glance.'],
      [
        'Facility Recommendation',
        'Identify appropriate nearby healthcare facilities.',
      ],
      ['Transport Coordination', 'Book and track emergency transport.'],
      [
        'Medical Review',
        'Record structured doctor observations and recommendations.',
      ],
      [
        'Case Timeline',
        'Maintain a chronological record of assessments, vitals, reviews and actions.',
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'One Platform. One Complete Patient Journey.',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: AppColors.deepNavy,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: features.map((feature) {
              return SizedBox(
                width: 260,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.lightTeal,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.medical_services_outlined,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        feature[0],
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepNavy,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feature[1],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _OfflineSection extends StatelessWidget {
  const _OfflineSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Healthcare Shouldn\'t Stop When the Internet Does.',
            style: GoogleFonts.inter(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: AppColors.deepNavy,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Text(
            'MaatriRakshak is designed to work offline. Patient information and assessments can be stored securely on the device and synchronized automatically when connectivity becomes available.',
            style: GoogleFonts.inter(
              fontSize: 17,
              height: 1.7,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskSection extends StatelessWidget {
  const _RiskSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Understand Risk. Act with Confidence.',
          style: GoogleFonts.inter(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: AppColors.deepNavy,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        Center(
          child : Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              SizedBox(
                width: 260,
                child: _RiskCard(
                  title: 'LOW RISK',
                  score: '18 / 100',
                  status: 'Routine Follow-up',
                  color: AppColors.lowRiskGreen,
                  progress: 0.18,
                ),
              ),
              SizedBox(
                width: 260,
                child: _RiskCard(
                  title: 'MODERATE RISK',
                  score: '62 / 100',
                  status: 'Medical Review Recommended',
                  color: AppColors.mediumRiskOrange,
                  progress: 0.62,
                ),
              ),
              SizedBox(
                width: 260,
                child: _RiskCard(
                  title: 'HIGH RISK',
                  score: '89 / 100',
                  status: 'Urgent Hospital Referral',
                  color: AppColors.highRiskRed,
                  progress: 0.89,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RiskCard extends StatelessWidget {
  final String title;
  final String score;
  final String status;
  final Color color;
  final double progress;

  const _RiskCard({
    required this.title,
    required this.score,
    required this.status,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            score,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Ready to Transform Maternal Care in Your Community?',
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.deepNavy,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        Text(
          'MaatriRakshak empowers ASHA workers with decision support that works offline, adapts to local context, and ensures no mother is left behind.',
          style: GoogleFonts.inter(
            fontSize: 17,
            height: 1.7,
            color: AppColors.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.signUp),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
              ),
              child: Text(
                'Get Started',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 72),
      ],
    );
  }
}
