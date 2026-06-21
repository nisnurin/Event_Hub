import 'package:flutter/material.dart';
import 'database/mock_database.dart';
import 'screens/onboarding_screens.dart';

void main() {
  runApp(const EventHubApp());
}

class EventHubApp extends StatefulWidget {
  const EventHubApp({super.key});

  @override
  State<EventHubApp> createState() => _EventHubAppState();
}

class _EventHubAppState extends State<EventHubApp> {
  final MockDatabase database = MockDatabase();

  @override
  void initState() {
    super.initState();
    database.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return DatabaseProvider(
      database: database,
      child: MaterialApp(
        title: 'Student Event-Hub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0F0E17), // Deep Dark UI Base
          primaryColor: const Color(0xFF9D4EDD), // Bright Purple Brand Color
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF9D4EDD),
            secondary: Color(0xFF7B2CBF),
            surface: Color(0xFF1A1927),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

// Simple InheritedWidget state provider to pass database references across screens
class DatabaseProvider extends InheritedWidget {
  final MockDatabase database;

  const DatabaseProvider({
    super.key,
    required this.database,
    required super.child,
  });

  static MockDatabase of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DatabaseProvider>()!
        .database;
  }

  @override
  bool updateShouldNotify(DatabaseProvider oldWidget) => true;
}
