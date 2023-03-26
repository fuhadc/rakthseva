import 'package:flutter/material.dart';

class BloodRequestForm extends StatefulWidget {
  @override
  _BloodRequestFormState createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<BloodRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _gender;
  String _bloodGroup;
  DateTime _dateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      setState(() {
        _dateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Patient Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter patient name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Date of Birth:'),
              TextFormField(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDateTime(context);
                },
                decoration: InputDecoration(
                  labelText: 'Select date and time',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (_dateTime == null) {
                    return 'Please select date and time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Gender:'),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  Text('Male'),
                  Radio(
                    value: 'female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
              SizedBox(height: 16),
              Text('Blood Group Required:'),
              DropdownButtonFormField(
                value: _bloodGroup,
                items: [
                  DropdownMenuItem(child: Text('A+'), value: 'A+'),
                  DropdownMenuItem(child: Text('A-'), value: 'A-'),
                  DropdownMenuItem(child: Text('B+'), value: 'B+'),
                  DropdownMenuItem(child: Text('B-'), value: 'B-'),
                  DropdownMenuItem(child: Text('AB+'), value: 'AB+'),
                  DropdownMenuItem(child: Text('AB-'), value: 'AB-'),
                  DropdownMenuItem(child: Text('O+'), value: 'O+'),
                  DropdownMenuItem(child: Text('O-'), value: 'O-'),
                ],
                onChanged: (value) {
                  setState(() {
                    _bloodGroup = value.toString();
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Date and Time Required:'),
              DateTimePicker(
                initialValue: _dateTime,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                timeLabelText: 'Time',
                onChanged: (val) => setState(() => _dateTime = val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              SizedBox(height: 16),
              Text('Address:'),
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Address'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
