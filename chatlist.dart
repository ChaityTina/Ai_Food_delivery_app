import 'package:flutter/material.dart';

class chatlist extends StatelessWidget {
  const chatlist ({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chatData = [
      {
        'name': 'Geopart Etdsien',
        'message': 'Your Order Just Arrived!',
        'time': '13.47',
        'image': 'assets/images/user_1.png',
        'isRead': true,
      },
      {
        'name': 'Stevano Clirover',
        'message': 'Your Order Just Arrived!',
        'time': '11.23',
        'image': 'assets/images/user_2.jpg',
        'isUnread': true,
      },
      {
        'name': 'Elisia Justin',
        'message': 'Your Order Just Arrived!',
        'time': '11.23',
        'image': 'assets/images/user_3.png',
        'isUnread': false,
      },
      {
        'name': 'Geopart Etdsien',
        'message': 'Your Order Just Arrived!',
        'time': '13.47',
        'image': 'assets/images/user_1.png',
        'isRead': true,
      },
      {
        'name': 'Stevano Clirover',
        'message': 'Your Order Just Arrived!',
        'time': '11.23',
        'image': 'assets/images/user_2.jpg',
        'isUnread': true,
      },
      {
        'name': 'Elisia Justin',
        'message': 'Your Order Just Arrived!',
        'time': '11.23',
        'image': 'assets/images/user_3.png',
        'isUnread': false,
      },
      {
        'name': 'Elisia Justin',
        'message': 'Your Order Just Arrived!',
        'time': '11.23',
        'image': 'assets/images/user_3.png',
        'isUnread': false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Chat List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Message',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                final chat = chatData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 6.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(chat['image']),
                        radius: 25,
                      ),
                      title: Text(
                        chat['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        chat['message'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            chat['time'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (chat['isRead'] == true)
                            const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.orange,
                            )
                          else if (chat['isUnread'] == true)
                            Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble, color: Colors.orange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }
}
