import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BloodRequestPage extends StatefulWidget {
  @override
  _BloodRequestPageState createState() => _BloodRequestPageState();
}

class _BloodRequestPageState extends State<BloodRequestPage> {
  final _formKey = GlobalKey<FormState>();
  String? _patientName;
  String? _phoneNumber;
  String? _address;
  String? _gender;
  String? _bloodGroup;
  DateTime? _dateTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Send the request to the server
      print('Patient Name: $_patientName');
      print('Phone Number: $_phoneNumber');
      print('Address: $_address');
      print('Gender: $_gender');
      print('Blood Group Required: $_bloodGroup');
      print('Date and Time Required: $_dateTime');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Patient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter patient name';
                  }
                  return null;
                },
                onSaved: (value) => _patientName = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value,
              ),
              const SizedBox(height: 16),
              const Text(
                'Gender',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  const Text('Male'),
                  Radio<String>(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  const Text('Female'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Blood Group Required:'),
              DropdownButtonFormField(
                value