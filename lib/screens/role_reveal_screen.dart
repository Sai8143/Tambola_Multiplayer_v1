import 'package:flutter/material.dart';

import '../models/player_role.dart';

class RoleRevealScreen extends StatelessWidget {
  final PlayerRole role;

  final VoidCallback onContinue;

  const RoleRevealScreen({
    super.key,
    required this.role,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInfluencer = role == PlayerRole.influencer;

    return Scaffold(
      backgroundColor: const Color(
        0xFF0F172A,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            24,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Container(
              padding: const EdgeInsets.all(
                30,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isInfluencer
                      ? [
                          Colors.red,
                          Colors.deepPurple,
                        ]
                      : [
                          Colors.indigo,
                          Colors.deepPurple,
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Column(
                children: [
                  // =================
                  // EMOJI
                  // =================

                  Text(
                    isInfluencer ? "🕵️" : "🎟",
                    style: const TextStyle(
                      fontSize: 90,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =================
                  // TITLE
                  // =================

                  Text(
                    isInfluencer ? "INFLUENCER" : "NORMAL PLAYER",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================
                  // DESCRIPTION
                  // =================

                  Text(
                    isInfluencer
                        ? "Manipulate fate secretly and avoid suspicion."
                        : "Complete your ticket and expose the hidden influencer.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // =================
                  // ROLE INFO
                  // =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                        0.12,
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      children: [
                        buildPoint(
                          isInfluencer
                              ? "Delay upcoming numbers"
                              : "Mark called numbers",
                        ),
                        buildPoint(
                          isInfluencer
                              ? "Create hidden chaos"
                              : "Watch suspicious actions",
                        ),
                        buildPoint(
                          isInfluencer
                              ? "Survive meetings"
                              : "Vote correctly in meetings",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 34),

                  // =================
                  // BUTTON
                  // =================

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            isInfluencer ? Colors.red : Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Enter Game",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // POINT
  // =========================

  Widget buildPoint(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
