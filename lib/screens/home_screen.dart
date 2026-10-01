// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'game_screen.dart';
// import '../services/firestore_service.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _controller = TextEditingController();

//   final FirestoreService _service = FirestoreService();

//   bool _isLoading = false;

//   String _generateRoomId() {
//     return (1000 + Random().nextInt(9000)).toString();
//   }

//   Future<void> _createRoom() async {
//     if (_isLoading) return;

//     setState(() {
//       _isLoading = true;
//     });

//     final roomId = _generateRoomId();

//     try {
//       // FAST NAVIGATION
//       if (mounted) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => GameScreen(
//               roomId: roomId,
//               isHost: true,
//             ),
//           ),
//         );
//       }

//       // FIREBASE BACKGROUND
//       await _service.createRoom(
//         roomId,
//       );
//     } catch (e) {
//       debugPrint(
//         "Create Room Error: $e",
//       );

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               "Failed to create room",
//             ),
//           ),
//         );
//       }
//     }

//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _joinRoom() async {
//     if (_isLoading) return;

//     final roomId = _controller.text.trim();

//     if (roomId.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Enter Room ID",
//           ),
//         ),
//       );

//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final exists = await _service.roomExists(
//         roomId,
//       );

//       if (!exists) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 "Room not found",
//               ),
//             ),
//           );
//         }

//         setState(() {
//           _isLoading = false;
//         });

//         return;
//       }

//       if (mounted) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => GameScreen(
//               roomId: roomId,
//               isHost: false,
//             ),
//           ),
//         );
//       }

//       await _service.joinRoom(
//         roomId,
//       );
//     } catch (e) {
//       debugPrint(
//         "Join Room Error: $e",
//       );

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               "Failed to join room",
//             ),
//           ),
//         );
//       }
//     }

//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isMobile = MediaQuery.of(context).size.width < 700;

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.deepPurple.shade900,
//               Colors.indigo.shade700,
//               Colors.purple.shade400,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.all(
//                 24,
//               ),
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(
//                   maxWidth: 500,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       width: 110,
//                       height: 110,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.white,
//                             Colors.grey.shade300,
//                           ],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(
//                               0.25,
//                             ),
//                             blurRadius: 18,
//                             offset: const Offset(
//                               0,
//                               8,
//                             ),
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           "8",
//                           style: TextStyle(
//                             color: Colors.deepPurple.shade900,
//                             fontSize: 52,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 28,
//                     ),
//                     const Text(
//                       "Tambola",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 46,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Text(
//                       "Realtime Multiplayer Housie",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(
//                           0.8,
//                         ),
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 42,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(
//                         26,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(
//                           28,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(
//                               0.15,
//                             ),
//                             blurRadius: 18,
//                             offset: const Offset(
//                               0,
//                               8,
//                             ),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             width: double.infinity,
//                             height: 58,
//                             child: ElevatedButton.icon(
//                               onPressed: _isLoading ? null : _createRoom,
//                               icon: _isLoading
//                                   ? const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                   : const Icon(
//                                       Icons.add_circle_outline,
//                                     ),
//                               label: const Text(
//                                 "Create Room",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.deepPurple,
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                     18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 28,
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                 ),
//                                 child: Text(
//                                   "OR JOIN",
//                                   style: TextStyle(
//                                     color: Colors.grey.shade500,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 24,
//                           ),
//                           TextField(
//                             controller: _controller,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                               LengthLimitingTextInputFormatter(
//                                 4,
//                               ),
//                             ],
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 10,
//                             ),
//                             decoration: InputDecoration(
//                               labelText: "Enter Room ID",
//                               hintText: "_ _ _ _",
//                               filled: true,
//                               fillColor: Colors.grey.shade100,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   18,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   18,
//                                 ),
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   18,
//                                 ),
//                                 borderSide: const BorderSide(
//                                   color: Colors.deepPurple,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 22,
//                           ),
//                           SizedBox(
//                             width: double.infinity,
//                             height: 58,
//                             child: ElevatedButton.icon(
//                               onPressed: _isLoading ? null : _joinRoom,
//                               icon: const Icon(
//                                 Icons.login,
//                               ),
//                               label: const Text(
//                                 "Join Room",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.indigo,
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                     18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 34,
//                     ),
//                     Text(
//                       isMobile
//                           ? "Play realtime with friends"
//                           : "Fast Realtime Multiplayer Tambola",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(
//                           0.55,
//                         ),
//                         fontSize: 13,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';

import '../services/firestore_service.dart';
import '../services/ticket_generator.dart';

import '../widgets/game_action_button.dart';
import '../widgets/game_glass_container.dart';
import '../widgets/game_gradient_background.dart';

import 'ticket_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // =========================
  // SERVICES
  // =========================

  final FirestoreService firestoreService = FirestoreService();

  // =========================
  // CONTROLLERS
  // =========================

  final TextEditingController roomController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  // =========================
  // STATE
  // =========================

  bool loading = false;
  String selectedGameMode = 'complex'; // 'simple' or 'complex'

  @override
  void dispose() {
    roomController.dispose();

    nameController.dispose();

    super.dispose();
  }

  // =========================
  // CREATE ROOM
  // =========================

  Future<void> createRoom() async {
    final roomId = generateRoomId();

    if (nameController.text.trim().isEmpty) {
      showMessage(
        "Enter player name",
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await firestoreService.createRoom(
        roomId,
        gameMode: selectedGameMode,
      );

      if (!mounted) {
        return;
      }

      openTicketScreen(
        roomId: roomId,
        isHost: true,
      );
    } catch (e) {
      showMessage(
        "Failed to create room",
      );
    }

    setState(() {
      loading = false;
    });
  }

  // =========================
  // JOIN ROOM
  // =========================

  Future<void> joinRoom() async {
    final roomId = roomController.text.trim().toUpperCase();

    if (roomId.isEmpty) {
      showMessage(
        "Enter room ID",
      );

      return;
    }

    if (nameController.text.trim().isEmpty) {
      showMessage(
        "Enter player name",
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final exists = await firestoreService.roomExists(
        roomId,
      );

      if (!exists) {
        showMessage(
          "Room not found",
        );

        setState(() {
          loading = false;
        });

        return;
      }

      if (!mounted) {
        return;
      }

      openTicketScreen(
        roomId: roomId,
        isHost: false,
      );
    } catch (e) {
      showMessage(
        "Failed to join room",
      );
    }

    setState(() {
      loading = false;
    });
  }

  // =========================
  // OPEN TICKET SCREEN
  // =========================

  void openTicketScreen({
    required String roomId,
    required bool isHost,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TicketScreen(
          roomId: roomId,
          playerName: nameController.text.trim(),
          isHost: isHost,
        ),
      ),
    );
  }

  // =========================
  // ROOM ID
  // =========================

  String generateRoomId() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ123456789';

    final random = Random();

    return List.generate(
      6,
      (
        index,
      ) =>
          chars[random.nextInt(
        chars.length,
      )],
    ).join();
  }

  // =========================
  // MESSAGE
  // =========================

  void showMessage(
    String text,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          text,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =========================
  // GAME MODE SELECTOR
  // =========================

  Widget buildGameModeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.sports_esports, color: Colors.deepPurpleAccent, size: 18),
            const SizedBox(width: 8),
            Text(
              "SELECT GAME MODE",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: buildModeCard(
                modeKey: 'simple',
                title: "Simple Game",
                subtitle: "Classic Tambola",
                icon: Icons.casino,
                activeColor: Colors.teal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: buildModeCard(
                modeKey: 'complex',
                title: "Complex Game",
                subtitle: "Fate & Influence",
                icon: Icons.psychology,
                activeColor: Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildModeCard({
    required String modeKey,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color activeColor,
  }) {
    final isSelected = selectedGameMode == modeKey;

    return InkWell(
      onTap: () => setState(() => selectedGameMode = modeKey),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.2) : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? activeColor : Colors.white12,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : Colors.grey.shade400,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
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
      body: GameGradientBackground(
        dark: true,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(
                mobile ? 18 : 28,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 520,
                ),
                child: Column(
                  children: [
                    // LOGO
                    Container(
                      width: mobile ? 100 : 120,
                      height: mobile ? 100 : 120,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.indigo,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(
                              0.30,
                            ),
                            blurRadius: 30,
                            offset: const Offset(
                              0,
                              14,
                            ),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.confirmation_number,
                        color: Colors.white,
                        size: mobile ? 52 : 64,
                      ),
                    ),

                    SizedBox(
                      height: mobile ? 26 : 34,
                    ),

                    // TITLE
                    Text(
                      "FATE TICKETS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: mobile ? 34 : 44,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Multiplayer Tambola & Hidden Influence",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: mobile ? 15 : 18,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(
                      height: mobile ? 28 : 40,
                    ),

                    // MAIN CARD
                    GameGlassContainer(
                      child: Column(
                        children: [
                          // NAME FIELD
                          TextField(
                            controller: nameController,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(
                                0.06,
                              ),
                              hintText: "Enter Player Name",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white70,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  18,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          // ROOM FIELD
                          TextField(
                            controller: roomController,
                            textCapitalization: TextCapitalization.characters,
                            style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(
                                0.06,
                              ),
                              hintText: "Enter Room ID (To Join)",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                              prefixIcon: const Icon(
                                Icons.meeting_room,
                                color: Colors.white70,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  18,
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 22,
                          ),

                          // GAME MODE SELECTOR
                          buildGameModeSelector(),

                          const SizedBox(
                            height: 24,
                          ),

                          // CREATE ROOM
                          GameActionButton(
                            text: loading ? "PLEASE WAIT" : "CREATE ROOM (${selectedGameMode.toUpperCase()})",
                            icon: Icons.add,
                            colors: const [
                              Colors.deepPurple,
                              Colors.indigo,
                            ],
                            onPressed: loading ? null : createRoom,
                          ),

                          const SizedBox(
                            height: 14,
                          ),

                          // JOIN ROOM
                          GameActionButton(
                            text: loading ? "PLEASE WAIT" : "JOIN ROOM",
                            icon: Icons.login,
                            colors: const [
                              Colors.teal,
                              Colors.green,
                            ],
                            onPressed: loading ? null : joinRoom,
                          ),

                          // =================
                          // LOADING
                          // =================

                          if (loading)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 28,
                              ),
                              child: const CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: mobile ? 26 : 34,
                    ),

                    // =================
                    // INFO TEXT
                    // =================

                    Text(
                      "Create a room and invite friends or join an existing multiplayer match using the room code.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        height: 1.7,
                        fontSize: mobile ? 13 : 15,
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
}
