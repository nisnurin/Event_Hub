import 'package:flutter/material.dart';
import '../main.dart';
import '../database/mock_database.dart';

class DetailEventScreen extends StatelessWidget {
  final CampusEvent event;
  const DetailEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                color: const Color(0xFF7B2CBF),
                child: Center(
                  child: Text(
                    event.imagePlaceholder,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Organized by ${event.organizer}',
                      style: const TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      event.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D4EDD),
                ),
                onPressed: () {
                  final db = DatabaseProvider.of(context);
                  db.createBooking(event.id, 1, event.price);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BookingSuccessScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Register Event Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 44,
                backgroundColor: Color(0xFF9D4EDD),
                child: Icon(Icons.check, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 32),
              const Text(
                'Register Success!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please check your event dashboard item updates.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF9D4EDD)),
                  ),
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  child: const Text(
                    'Back To Home',
                    style: TextStyle(color: Colors.white),
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
