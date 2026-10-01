import 'package:flutter/material.dart';

import '../models/player_model.dart';
import '../models/player_role.dart';

import 'game_badge.dart';

class LivePlayersPanel extends StatelessWidget {
  final List<PlayerModel> players;

  final String currentPlayerId;

  final bool revealInfluencers;

  const LivePlayersPanel({
    super.key,
    required this.players,
    required this.currentPlayerId,
    this.revealInfluencers = false,
  });

  // =========================
  // ACTIVE PLAYERS
  // =========================

  List<PlayerModel> get activePlayers {
    return players
        .where(
          (player) => !player.isEliminated,
        )
        .toList();
  }

  // =========================
  // ELIMINATED PLAYERS
  // =========================

  List<PlayerModel> get eliminatedPlayers {
    return players
        .where(
          (player) => player.isEliminated,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================
          // HEADER
          // =====================
          Row(
            children: [
              const Icon(
                Icons.groups,
                color: Colors.indigoAccent,
                size: 30,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Live Players",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "${activePlayers.length}/${players.length}",
                  style: const TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // =====================
          // ACTIVE PLAYERS
          // =====================
          if (activePlayers.isNotEmpty)
            ...activePlayers.map(
              (player) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: buildPlayerCard(
                    player,
                    active: true,
                  ),
                );
              },
            ),

          // =====================
          // ELIMINATED TITLE
          // =====================
          if (eliminatedPlayers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(color: Colors.white24),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "ELIMINATED",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: Colors.white24),
                  ),
                ],
              ),
            ),

          // =====================
          // ELIMINATED PLAYERS
          // =====================
          if (eliminatedPlayers.isNotEmpty)
            ...eliminatedPlayers.map(
              (player) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: buildPlayerCard(
                    player,
                    active: false,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // =========================
  // PLAYER CARD
  // =========================

  Widget buildPlayerCard(
    PlayerModel player, {
    required bool active,
  }) {
    final bool isYou = player.playerId == currentPlayerId;
    final bool influencer = player.role == PlayerRole.influencer;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0F172A) : Colors.black38,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isYou ? Colors.deepPurpleAccent : Colors.white10,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: active ? Colors.indigo.withValues(alpha: 0.3) : Colors.grey.shade800,
            child: Text(
              player.playerName.isNotEmpty ? player.playerName[0].toUpperCase() : 'P',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      player.playerName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: active ? null : TextDecoration.lineThrough,
                      ),
                    ),
                    if (isYou)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "YOU",
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (player.isHost)
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: GameBadge(
                          label: "HOST",
                          color: Colors.orange,
                        ),
                      ),
                    if (revealInfluencers && influencer)
                      const GameBadge(
                        label: "INFLUENCER",
                        color: Colors.red,
                      )
                    else
                      GameBadge(
                        label: active ? "ACTIVE" : "ELIMINATED",
                        color: active ? Colors.green : Colors.grey,
                      ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Marked: ${player.markedNumbers.length}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Score: ${player.predictionScore}",
                style: const TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
