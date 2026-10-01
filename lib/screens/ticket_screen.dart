import 'package:flutter/material.dart';

import '../services/ticket_generator.dart';

import 'game_screen.dart';

class TicketScreen extends StatefulWidget {
  final String roomId;

  final String playerName;

  final bool isHost;

  const TicketScreen({
    super.key,
    required this.roomId,
    required this.playerName,
    required this.isHost,
  });

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  // =========================
  // TICKET
  // =========================

  late List<List<int?>> ticket;

  @override
  void initState() {
    super.initState();

    generateTicket();
  }

  // =========================
  // GENERATE TICKET
  // =========================

  void generateTicket() {
    ticket = TicketGenerator.generate();

    if (mounted) {
      setState(() {});
    }
  }

  // =========================
  // CONTINUE TO GAME
  // =========================

  void continueToGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          roomId: widget.roomId,
          playerName: widget.playerName,
          isHost: widget.isHost,
          ticket: ticket,
        ),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(
    BuildContext context,
  ) {
    final width = MediaQuery.of(context).size.width;

    final mobile = width < 700;

    return Scaffold(
      backgroundColor: const Color(
        0xFF0F172A,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            mobile ? 16 : 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 720,
              ),
              child: Column(
                children: [
                  // =================
                  // LOGO
                  // =================

                  Container(
                    width: mobile ? 90 : 110,
                    height: mobile ? 90 : 110,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.deepPurple,
                          Colors.indigo,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        28,
                      ),
                    ),
                    child: Icon(
                      Icons.confirmation_number,
                      color: Colors.white,
                      size: mobile ? 48 : 60,
                    ),
                  ),

                  SizedBox(
                    height: mobile ? 24 : 32,
                  ),

                  // =================
                  // TITLE
                  // =================

                  Text(
                    "YOUR FATE TICKET",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: mobile ? 28 : 38,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Review your generated multiplayer ticket before entering the match.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: mobile ? 14 : 16,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(
                    height: mobile ? 28 : 36,
                  ),

                  // =================
                  // ROOM CARD
                  // =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      22,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF1E293B,
                      ),
                      borderRadius: BorderRadius.circular(
                        28,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.indigo,
                                Colors.deepPurple,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: const Icon(
                            Icons.groups,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ROOM ID",
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.roomId,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontSize: mobile ? 24 : 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: widget.isHost ? Colors.orange : Colors.green,
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),
                          child: Text(
                            widget.isHost ? "HOST" : "PLAYER",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: mobile ? 28 : 36,
                  ),

                  // =================
                  // TICKET GRID
                  // =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF1E293B,
                      ),
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: Column(
                      children: ticket.map(
                        (
                          row,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 14,
                            ),
                            child: Row(
                              children: row.map(
                                (
                                  value,
                                ) {
                                  final filled = value != null;

                                  return Expanded(
                                    child: Container(
                                      height: mobile ? 58 : 70,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: filled
                                            ? const LinearGradient(
                                                colors: [
                                                  Colors.deepPurple,
                                                  Colors.indigo,
                                                ],
                                              )
                                            : null,
                                        color: filled ? null : Colors.white10,
                                        borderRadius: BorderRadius.circular(
                                          18,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          filled ? value.toString() : "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: mobile ? 18 : 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),

                  SizedBox(
                    height: mobile ? 30 : 40,
                  ),

                  // =================
                  // BUTTONS
                  // =================

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: generateTicket,
                      icon: const Icon(
                        Icons.refresh,
                      ),
                      label: const Text(
                        "Generate Again",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: continueToGame,
                      icon: const Icon(
                        Icons.arrow_forward,
                      ),
                      label: const Text(
                        "Enter Game",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: mobile ? 26 : 34,
                  ),

                  // =================
                  // INFO
                  // =================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(
                        0.10,
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      border: Border.all(
                        color: Colors.orange.withOpacity(
                          0.30,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            "Once the game starts your ticket cannot be regenerated. Mark numbers carefully and monitor hidden influence activity.",
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
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
}
