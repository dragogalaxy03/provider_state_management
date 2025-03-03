import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'address-data-model.dart';
import 'package:image_picker/image_picker.dart';

class BusinessForm extends StatefulWidget {
  const BusinessForm({super.key});

  @override
  _BusinessFormState createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  final PageController _pageController = PageController();
  bool _showCoordinates = false;

  void _nextStep() {
    setState(() => _currentStep++);
    _pageController.animateToPage(_currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _prevStep() {
    setState(() => _currentStep--);
    _pageController.animateToPage(_currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Form Saved: $_business");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Business Form', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildNavigationButtons(),
            _buildStepProgress(),
            Expanded(child: _buildStepContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildStepProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: StepProgressIndicator(
        totalSteps: 6,
        currentStep: _currentStep + 1,
        selectedColor: Colors.blue.shade400,
        unselectedColor: Colors.grey.shade300,
        size: 7,
        roundedEdges: Radius.circular(4),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            ElevatedButton(
              onPressed: _prevStep,
              style: _buttonStyle(Colors.grey.shade300, Colors.black),
              child: Icon(Icons.arrow_back, color: Colors.black),
            )
          else
            SizedBox(width: 50),

          if (_currentStep < 5)
            ElevatedButton(
              onPressed: _nextStep,
              style: _buttonStyle(Colors.blueAccent, Colors.white),
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle(Color background, Color foreground) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
    );
  }

  Widget _buildStepContent() {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildStepCard('Legal Information', [
          _buildTextField('Brand Name', Icons.business),
          _buildTextField('Location Name', Icons.location_on),
          _buildTextField('Business Type', Icons.apartment),
        ]),
        _buildStepCard('Bank Account', [
          _buildTextField('Account Number', Icons.account_balance, isNumber: true),
          _buildTextField('Bank Name', Icons.account_balance_wallet),
        ]),
        _buildStepCard('Personal Information', [
          _buildTextField('Person Name', Icons.person),
          _buildTextField('Person Phone', Icons.phone, isNumber: true),
        ]),
        _buildStepCard('Address', [
          _buildTextField('Address', Icons.home),
          _buildTextField('Country', Icons.flag),
        ]),
      ],
    );
  }

  Widget _buildStepCard(String title, List<Widget> fields) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...fields,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.blueAccent)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.blue, width: 2)),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) => value!.isEmpty ? "Required field" : null,
      ),
    );
  }

  BusinessModel _business = BusinessModel(
    legalName: '',
    locationName: '',
    businessStructure: '',
    registryNumber: '',
    gst: '',
    pan: '',
    companyName: '',
    brandCode: '',
    brandName: '',
    accountNumber: '',
    accountName: '',
    ifsc: '',
    bankName: '',
    personName: '',
    personPhone: '',
    personEmail: '',
    address: '',
    postalCode: '',
    country: '',
    administrativeArea: '',
    latitude: '',
    longitude: '',
    documentName: '',
    tags: '',
    comment: '',
    file: '',
    media:'',
  );

}