import 'package:flutter/material.dart';
import '../main.dart';
import '../booking/booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Academic',
    'Sports',
    'Club Activities',
  ];

  @override
  Widget build(BuildContext context) {
    final db = DatabaseProvider.of(context);
    final displayedEvents = db.getEventsByCategory(_selectedCategory);
    final user = db.currentUser;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Location',
                        style: TextStyle(fontSize: 12, color: Colors.white38),
                      ),
                      Text(
                        user != null
                            ? 'UITM KUALA TERENGGANU'
                            : 'Unknown Campus',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFF9D4EDD),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  hintText: 'Search Event...',
                  filled: true,
                  fillColor: const Color(0xFF1A1927),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, idx) {
                    final isSelected = _categories[idx] == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(_categories[idx]),
                        selected: isSelected,
                        selectedColor: const Color(0xFF9D4EDD),
                        backgroundColor: const Color(0xFF1A1927),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.white54,
                        ),
                        onSelected: (_) => setState(
                          () => _selectedCategory = _categories[idx],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedEvents.length,
                itemBuilder: (context, index) {
                  final item = displayedEvents[index];
                  return Card(
                    color: const Color(0xFF1A1927),
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            item.imagePlaceholder,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${item.date} • ${item.location}\n\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white54),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white30,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailEventScreen(event: item),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
