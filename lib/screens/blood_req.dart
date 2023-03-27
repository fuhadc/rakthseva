import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String _gender = 'Male';
  String _bloodGroup = 'A+';
  int _unit = 1;
  DateTime? _dateTime;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // send form data to REST API
      // example code for sending data using http package
      // await http.post(
      //   Uri.parse('https://example.com/api/submit'),
      //   body: {
      //     'name': _nameController.text,
      //     'phone': _phoneController.text,
      //     'address': _addressController.text,
      //     'dob': _dobController.text,
      //     'gender': _gender,
      //     'bloodGroup': _bloodGroup,
      //     'unit': _unit.toString(),
      //     'dateTime': _dateTime.toString(),
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blood Request Form')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Patient Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Patient Name';
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
                    if (value!.isEmpty) {
                      return 'Please enter Phone Number';
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
                    if (value!.isEmpty) {
                      return 'Please enter Address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dobController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Date of Birth';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Gender'),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(
                  height: 16,
                  width: 16,
                ),
                Text('Blood Group'),
                SizedBox(
                  width: 8,
                ),
                DropdownButton<String>(
                  value: _bloodGroup,
                  onChanged: (value) {
                    setState(() {
                      _bloodGroup = value!;
                    });
                  },
                  items: <String>[
                    'A+',
                    'B+',
                    'O+',
                    'AB+',
                    'A-',
                    'B-',
                    'O-',
                    'AB-'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text('Unit Required'),
                Slider(
                  value: _unit.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _unit.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _unit = value.toInt();
                    });
                  },
                ),
                SizedBox(height: 16),
                Text('Date and Time Required'),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (dateTime != null) {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (timeOfDay != null) {
                        setState(() {
                          _dateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            timeOfDay.hour,
                            timeOfDay.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Text(
                    _dateTime == null
                        ? 'Select Date and Time'
                        : '${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year} ${_dateTime!.hour}:${_dateTime!.minute}',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
