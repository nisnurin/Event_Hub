import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String serverBaseUrl = 'http://202.58.90.77';

class StudentUser {
  final String id;
  final String email;
  final String fullName;
  final String role;

  StudentUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
  });

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? 'Student',
    );
  }
}

class CampusEvent {
  final String id;
  final String title;
  final String category;
  final String organizer;
  final String date;
  final String location;
  final double price;
  final String imagePlaceholder;
  final String description;

  CampusEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.organizer,
    required this.date,
    required this.location,
    required this.price,
    required this.imagePlaceholder,
    required this.description,
  });

  factory CampusEvent.fromJson(Map<String, dynamic> json) {
    return CampusEvent(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      category: json['category']?.toString() ?? 'General',
      organizer: json['organizer']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imagePlaceholder: json['imagePlaceholder']?.toString() ?? '🎉',
      description: json['description']?.toString() ?? '',
    );
  }
}

class EventBooking {
  final String id;
  final String eventId;
  final String studentId;
  final int ticketCount;
  final double totalPaid;
  final String bookingDate;

  EventBooking({
    required this.id,
    required this.eventId,
    required this.studentId,
    required this.ticketCount,
    required this.totalPaid,
    required this.bookingDate,
  });
}

class MockDatabase extends ChangeNotifier {
  final List<StudentUser> _usersTable = [
    StudentUser(
      id: 'u1',
      email: 'franklinclinton@gmail.com',
      fullName: 'Franklin Clinton',
      role: 'Student',
    ),
  ];

  final List<CampusEvent> _eventsTable = [
    CampusEvent(
      id: 'e1',
      title: 'Synchronize Fest 2026',
      category: 'Club Activities',
      organizer: 'Michael De Santa',
      date: 'May 20, 2026',
      location: 'UiTM Kuala Terengganu',
      price: 25.00,
      imagePlaceholder: '🎹',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    CampusEvent(
      id: 'e2',
      title: 'Moshing Metal Fest 2026',
      category: 'Club Activities',
      organizer: 'Trevor Philips',
      date: 'June 15, 2026',
      location: 'Sleman, Yogyakarta',
      price: 15.00,
      imagePlaceholder: '🎸',
      description:
          'Experience the heaviest riffs and underground acts on campus.',
    ),
    CampusEvent(
      id: 'e3',
      title: 'Inter-Faculty Football Cup',
      category: 'Sports',
      organizer: 'Sports Council',
      date: 'July 02, 2026',
      location: 'Main Campus Stadium',
      price: 0.00,
      imagePlaceholder: '⚽',
      description:
          'Cheer for your faculty in the annual elimination tournament.',
    ),
  ];

  final List<EventBooking> _bookingsTable = [];

  StudentUser? _currentUser;
  StudentUser? get currentUser => _currentUser;
  List<CampusEvent> get allEvents => _eventsTable;
  List<EventBooking> get allBookings => _bookingsTable;

  Future<void> initialize() async {
    await _loadRemoteData();
  }

  Future<void> _loadRemoteData() async {
    try {
      final eventsResponse = await http.get(
        Uri.parse('$serverBaseUrl/api/events'),
      );
      if (eventsResponse.statusCode == 200) {
        final decoded = jsonDecode(eventsResponse.body);
        if (decoded is List) {
          _eventsTable.clear();
          _eventsTable.addAll(
            decoded.map((item) => CampusEvent.fromJson(item)).toList(),
          );
        }
      }

      final usersResponse = await http.get(
        Uri.parse('$serverBaseUrl/api/users'),
      );
      if (usersResponse.statusCode == 200) {
        final decoded = jsonDecode(usersResponse.body);
        if (decoded is List) {
          _usersTable.clear();
          _usersTable.addAll(
            decoded.map((item) => StudentUser.fromJson(item)).toList(),
          );
        }
      }

      notifyListeners();
    } catch (_) {
      // Fall back to the local mock data if the server is unavailable.
    }
  }

  bool signIn(String email, String password) {
    try {
      _currentUser = _usersTable.firstWhere(
        (user) => user.email.toLowerCase() == email.trim().toLowerCase(),
      );
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  bool signUp(String email, String fullName, String role) {
    final exists = _usersTable.any(
      (u) => u.email.toLowerCase() == email.trim().toLowerCase(),
    );
    if (exists) return false;

    final newUser = StudentUser(
      id: 'u${_usersTable.length + 1}',
      email: email.trim(),
      fullName: fullName,
      role: role,
    );
    _usersTable.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  void signOut() {
    _currentUser = null;
    notifyListeners();
  }

  void createBooking(String eventId, int count, double total) {
    final newBooking = EventBooking(
      id: 'BK${_bookingsTable.length + 1001}',
      eventId: eventId,
      studentId: _currentUser?.id ?? 'Guest',
      ticketCount: count,
      totalPaid: total,
      bookingDate: 'May 20, 2026',
    );
    _bookingsTable.add(newBooking);
    notifyListeners();
  }

  List<CampusEvent> getEventsByCategory(String category) {
    if (category == 'All') return _eventsTable;
    return _eventsTable.where((e) => e.category == category).toList();
  }
}
