import 'package:flutter/material.dart';

class add_card_v2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Extra Card'),
            centerTitle: true,
            leading:IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_back_ios_new_rounded)
            )
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name on Card',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Card Number',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "_______ / ______ / _____",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Card Type',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Select Card Type',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'visa', child: Text('Visa')),
                        DropdownMenuItem(value: 'mastercard', child: Text('MasterCard')),
                        DropdownMenuItem(value: 'amex', child: Text('Amex')),
                      ],
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 15),
                    Text('Expiry Date',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "MM / YY",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('CVV',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.help_outline, size: 22),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "______",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Billing Address',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),

                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text('Save Card',style: TextStyle(color: Colors.white)),
                      ),
                    )


                  ],
                )
            )
        )
    );
  }

}