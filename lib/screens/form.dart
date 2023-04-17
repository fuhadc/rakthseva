import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'compleation.dart';

class DonationForm extends StatefulWidget {
  final dynamic user;
  const DonationForm({super.key, required this.user});
  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _lastDonationDateController = TextEditingController();
  String _gender = 'Male';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final url =
          'http://192.168.1.11:5555/bloodReq?userId=${widget.user.userid}';
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'phone_number': _phoneNumberController.text,
            'address': _addressController.text,
            'date_of_birth': _dateOfBirthController.text,
            'medical_history': _medicalHistoryController.text,
            'last_donation_date': _lastDonationDateController.text,
            'gender': _gender,
          }));

      if (response.statusCode == 201) {
        // Success!
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubmissionScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donation Form')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _medicalHistoryController,
                decoration: const InputDecoration(labelText: 'Medical History'),
                maxLines: null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastDonationDateController,
                decoration:
                    const InputDecoration(labelText: 'Last Donation Date'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last donation date.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text('Gender', style: Theme.of(context).textTheme.titleMedium),
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                  const SizedBox(width: 16),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
