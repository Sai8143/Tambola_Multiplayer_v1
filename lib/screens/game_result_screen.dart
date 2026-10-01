import 'package:flutter/material.dart';

import '../models/player_model.dart';
import '../models/player_role.dart';

class GameResultScreen extends StatelessWidget {
  final List<PlayerModel> players;
  final List<PlayerModel> winners;
  final bool influencerWon;
  final VoidCallback onHome;

  const GameResultScreen({
    super.key,
    required this.players,
    required this.winners,
    required this.influencerWon,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = influencerWon ? Colors.redAccent : Colors.greenAccent;
    final String emoji = influencerWon ? "🕵️" : "🎉";
    final String title = influencerWon ? "Influencers Victorious" : "Normal Players Victorious";
    final String message = influencerWon
        ? "The Influencers successfully manipulated fate and escaped detection!"
        : "Vigilant players completed their tickets and unmasked the manipulators!";

    // Calculate Award Winners
    PlayerModel? masterPredictor;
    PlayerModel? ticketChampion;
    PlayerModel? topDetective;
    PlayerModel? masterDeceiver;

    if (players.isNotEmpty) {
      final sortedByScore = [...players]..sort((a, b) => b.predictionScore.compareTo(a.predictionScore));
      masterPredictor = sortedByScore.first;

      final sortedByMarked = [...players]..sort((a, b) => b.markedNumbers.length.compareTo(a.markedNumbers.length));
      ticketChampion = sortedByMarked.first;

      final sortedBySuspicion = [...players]..sort((a, b) => a.suspicionScore.compareTo(b.suspicionScore));
      topDetective = sortedBySuspicion.first;

      final influencers = players.where((p) => p.role == PlayerRole.influencer).toList();
      if (influencers.isNotEmpty) {
        masterDeceiver = influencers.first;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: primary.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // =========================
                    // AWARD BADGES PANEL
                    // =========================
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "MATCH MVP & AWARDS",
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (masterPredictor != null)
                            buildAwardTile(
                              icon: "🔮",
                              title: "Master Predictor",
                              name: masterPredictor.playerName,
                              detail: "${masterPredictor.predictionScore} Points",
                              color: Colors.purpleAccent,
                            ),
                          if (ticketChampion != null)
                            buildAwardTile(
                              icon: "🎟️",
                              title: "Ticket Champion",
                              name: ticketChampion.playerName,
                              detail: "${ticketChampion.markedNumbers.length} Marked",
                              color: Colors.amberAccent,
                            ),
                          if (topDetective != null)
                            buildAwardTile(
                              icon: "🕵️",
                              title: "Top Detective",
                              name: topDetective.playerName,
                              detail: "${topDetective.suspicionScore}% Suspicion",
                              color: Colors.cyanAccent,
                            ),
                          if (masterDeceiver != null)
                            buildAwardTile(
                              icon: "🎭",
                              title: "Master Deceiver",
                              name: masterDeceiver.playerName,
                              detail: masterDeceiver.isEliminated ? "Exposed" : "Undetected",
                              color: Colors.redAccent,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // HOME BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onHome,
                        icon: const Icon(Icons.home),
                        label: const Text("Return to Home"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
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
      ),
    );
  }

  Widget buildAwardTile({
    required String icon,
    required String title,
    required String name,
    required String detail,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            detail,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
