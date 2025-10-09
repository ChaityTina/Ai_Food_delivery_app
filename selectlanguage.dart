import 'package:flutter/material.dart';
class selectlanguage extends StatefulWidget{
  const selectlanguage({super.key});

  @override
  State<StatefulWidget> createState() {
    return selectlanguagePage();
  }
}
class selectlanguagePage extends State<selectlanguage> {
  String selectedLang = "English (US)";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),

      child: SingleChildScrollView(
        child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2)
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Select Language",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _languageItem("Indonesina", "assets/images/user_3.png"),
          _languageItem("English (US)", "assets/images/user_3.png"),
          _languageItem("Thailand", "assets/images/user_3.png"),
          _languageItem("Chinese", "assets/images/user_3.png"),


          SizedBox(height: 20),

          // "Select" button that spans full width
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8C00), // Orange color
                shape: const StadiumBorder(), // Rounded pill shape
              ),
              onPressed: () {},
              child: const Text(
                "Select",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),


        ],
      ),

        
      )

    );
  }

  Widget _languageItem(String title, String flagPath) {
    bool isSelected = title == selectedLang;
    return GestureDetector(
      onTap:
          () {
        setState(() {
          selectedLang = title;
        });
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFFFF8C00) : Colors.grey[300]!, // Orange border if selected
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
              children: [
                ClipOval(
                  child: Image.asset(flagPath,width: 32,height: 32, fit: BoxFit.cover),
                ),
                SizedBox(width: 12),
                Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                    )
                ),
                if(isSelected)
                  Icon(Icons.check_circle,color: Color(0xFFFF8C00),size: 20),

              ]

          )



      ),
    );

  }
}
