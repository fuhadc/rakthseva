import 'package:flutter/material.dart';

class BloodDonationFactsPage extends StatelessWidget {
  final List<String> facts = [
    "One pint of blood can save up to three lives.",
    "Every second, someone in the India needs blood.",
    "Type O-negative blood (red cells) can be transfused to patients of all blood types.",
    "The average adult has about 10 pints of blood in his or her body.",
    "Donating blood is a safe and simple process that takes about an hour.",
    "Donors can give blood every 56 days.",
    "Donating blood can help prevent hemochromatosis, a condition that occurs when there is too much iron in the blood.",
    "After donating blood, your body will replace the fluids within 24 hours and the red blood cells within 4-6 weeks.",
    "You can donate blood if you are at least 17 years old (or 16 with parental consent in some states), weigh at least 110 pounds, and are in good health.",
    "Donating blood does not affect your ability to exercise or perform normal activities.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Facts'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: facts.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 4.0,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    facts[index],
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
