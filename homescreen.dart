import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            // --- Header ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey USER,",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Find a course you want to learn",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.notifications_none, color: Colors.white, size: 28),
              ],
            ),
            const SizedBox(height: 20),

            // --- Search Bar ---
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search your course",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Categories ---
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategory("Finance & Accounting", Icons.attach_money),
                  const SizedBox(width: 10),
                  _buildCategory("Music", Icons.music_note),
                  const SizedBox(width: 10),
                  _buildCategory("Development", Icons.code),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // --- Popular Courses ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Popular Course",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "see all",
                  style: TextStyle(color: Color(0xFF937CD6)), 
                ),
              ],
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCourseCard(
                    imagePath: "assets/images/home1.png",
                    title: "Ask Better Questions - Build...",
                    author: "Brennan Broughton",
                    price: "\$59.99",
                    hours: "50 Hours",
                    rating: "4.9 Ratings",
                  ),
                  const SizedBox(width: 15),
                  _buildCourseCard(
                    imagePath: "assets/images/home1.png",
                    title: "The Complete UI Design Bootcamp",
                    author: "Sylvie Haynes",
                    price: "\$49.99",
                    hours: "72 Hours",
                    rating: "5.0 Ratings",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- Suggestions ---
            const Text(
              "Suggestions for you",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                _buildSuggestionCard(
                  title: "Fundamentals for Composition in Any Genre",
                  subtitle:
                      "Expand your music composition skills to the next level.",
                  tag: "Music Production",
                  time: "30 min",
                  progress: 0.0,
                ),
                _buildSuggestionCard(
                  title: "Communication Skills",
                  subtitle: "",
                  tag: "Development",
                  time: "25%",
                  progress: 0.25,
                ),
                _buildSuggestionCard(
                  title: "You haven’t missed a class in three days!",
                  subtitle: "",
                  tag: "",
                  progress: 0.0,
                ),
                _buildSuggestionCard(
                  title: "Tips for better teamwork for you...!",
                  subtitle: "",
                  tag: "Article",
                  progress: 0.0,
                ),
                _buildSuggestionCard(
                  title: "Social Media Marketing",
                  subtitle:
                      "In this course, we will learn the basic strategies.",
                  tag: "Development",
                  time: "60%",
                  progress: 0.6,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // --- Instructors ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Our best instructors",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "see all",
                  style: TextStyle(color: Color(0xFF937CD6)), 
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildInstructor(
              "Monique Haley",
              "Adobe Certified Instructor & Adobe Certified Expert",
              "49,569",
              courses: "20",
              rating: "4.9",
            ),
            _buildInstructor(
              "Sohail Hancock",
              "Developer and Lead Instructor",
              "64,089",
              courses: "07",
              rating: "5.0",
            ),
            _buildInstructor(
              "Abdurahman Churchill",
              "Best Selling Instructor, 9x AWS Certified",
              "12,489",
              courses: "10",
              rating: "4.5",
            ),
            _buildInstructor(
              "Monique Haley",
              "AWS certified, Professional Web Developer",
              "10,589",
              courses: "05",
              rating: "4.6",
            ),
            _buildInstructor(
              "Sylvie Haynes",
              "Microsoft Certified Trainer",
              "89,345",
              courses: "17",
              rating: "5.0",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- Category Widget ---
  static Widget _buildCategory(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF937CD6), size: 18), 
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // --- Course Card Widget ---
  static Widget _buildCourseCard({
    required String imagePath,
    required String title,
    required String author,
    required String price,
    required String hours,
    required String rating,
  }) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            author,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFF937CD6), // 💜 Accent updated
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Icon(Icons.bookmark_border, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(hours,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(width: 10),
              Text(rating,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // --- Suggestion Card Widget ---
  static Widget _buildSuggestionCard({
    required String title,
    required String subtitle,
    required String tag,
    String? time,
    required double progress,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tag.isNotEmpty)
            Text(tag, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
          const SizedBox(height: 10),
          if (progress > 0)
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: progress,
                color: Color(0xFF937CD6), // 💜 Accent updated
                backgroundColor: Colors.grey.shade800,
                minHeight: 4,
              ),
            ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF937CD6), 
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // --- Instructor Widget ---
  static Widget _buildInstructor(
    String name,
    String title,
    String students, {
    required String courses,
    required String rating,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF383838),
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  "$students students · $courses courses · ⭐ $rating",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
