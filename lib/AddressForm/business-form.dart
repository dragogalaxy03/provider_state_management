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
  //Next Step
  void _nextStep() {
    setState(() => _currentStep++);
    _pageController.animateToPage(_currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  //Prev Step
  void _prevStep() {
    setState(() => _currentStep--);
    _pageController.animateToPage(_currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  //Save Form
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Form Saved: $_business");
    }
  }

  //File picker function
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _business.file = result.files.single.path!;
      });
    }
  }

  // Function to pick media (Image/Video)
  Future<void> _buildMediaPicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _business.file = pickedFile.path; // Save the file path
      });
    }
  }

  //Title as per Form
  String _getCurrentStepTitle() {
    switch (_currentStep) {
      case 0:
        return "Legal Information";
      case 1:
        return "Brand Information";
      case 2:
        return "Bank & Accounts";
      case 3:
        return "Personal Information";
      case 4:
        return "Business Address";
      case 5:
        return "Files & Documents";
      default:
        return "Business Form";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue,
          title: const Text('Business Form', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
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

  //Step Progress Indicator
  Widget _buildStepProgress() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: StepProgressIndicator(
            totalSteps: 6,
            currentStep: _currentStep + 1,
            selectedColor: Colors.blue.shade300,
            unselectedColor: Colors.white,
            size: 7,
            roundedEdges: Radius.circular(4),
          ),
        ),
      ],
    );
  }
  // Navigation Buttons (Hidden "SAVE" on last step)
  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button (Icon Only)
          if (_currentStep > 0)
            ElevatedButton(
              onPressed: _prevStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjusted size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rectangular shape with slight curve
                ),
                elevation: 2,
              ),
              child: Icon(Icons.arrow_back, color: Colors.black),
            )
          else
            SizedBox(width: 50), // Placeholder for alignment

          // Next Button (Icon Only)
          if (_currentStep < 5)
            ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjusted size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rectangular shape with slight curve
                ),
                elevation: 2,
              ),
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
        ],
      ),
    );
  }





  // Improved Input Field with Icons
  Widget _buildTextField(String label, IconData icon, Function(String) onChanged, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onChanged: onChanged,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) => value!.isEmpty ? "Required field" : null,
      ),
    );
  }

  // PageView for steps
  Widget _buildStepContent() {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildStepCard('Legal Information', [
          _buildTextField('Brand Name', Icons.business, (value) => _business.legalName = value),
          _buildTextField('Location Name', Icons.location_on, (value) => _business.locationName = value),
          _buildTextField('Business Type', Icons.apartment, (value) => _business.businessStructure = value),
          _buildTextField('Registration Number', Icons.confirmation_number, (value) => _business.registryNumber = value),
          _buildTextField('GST', Icons.currency_rupee_outlined, (value) => _business.gst = value),
          _buildTextField('PAN', Icons.credit_card, (value) => _business.pan = value),
        ]),
        _buildStepCard('Contact Information', [
          _buildTextField('Company Name', Icons.apartment, (value) => _business.companyName = value),
          _buildTextField('Brand Code', Icons.qr_code, (value) => _business.brandCode = value),
          _buildTextField('Brand Name', Icons.label, (value) => _business.brandName = value),
        ]),
        _buildStepCard('Bank Account', [
          _buildTextField('Account Number', Icons.account_balance, (value) => _business.accountNumber = value, isNumber: true),
          _buildTextField('Account Name', Icons.person, (value) => _business.accountName = value),
          _buildTextField('IFSC Code', Icons.code, (value) => _business.ifsc = value),
          _buildTextField('Bank Name', Icons.account_balance_wallet, (value) => _business.bankName = value),
        ]),
        _buildStepCard('Personal Information', [
          _buildTextField('Person Name', Icons.person, (value) => _business.personName = value),
          _buildTextField('Person Phone', Icons.phone, (value) => _business.personPhone = value, isNumber: true),
          _buildTextField('Person Email', Icons.email, (value) => _business.personEmail = value),
        ]),
        _buildStepCard('Address', [
          _buildTextField('Address', Icons.home, (value) => _business.address = value),
          _buildTextField('Postal Code', Icons.location_city, (value) => _business.postalCode = value, isNumber: true),
          _buildTextField('Country', Icons.flag, (value) => _business.country = value),
          // Fetch Button
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _showCoordinates = true; // Show fields on click, no toggling back
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Always stays blue
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            icon: Icon(Icons.my_location, color: Colors.white),
            label: Text(
              "Fetch Coordinates",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),

// Show Latitude & Longitude fields once clicked
          if (_showCoordinates)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(child: _buildTextField('Latitude', Icons.gps_fixed, (value) => _business.latitude = value, isNumber: true)),
                  SizedBox(width: 10),
                  Expanded(child: _buildTextField('Longitude', Icons.gps_fixed, (value) => _business.longitude = value, isNumber: true)),
                ],
              ),
            ),

        ]),
        _buildStepCard('Files', [
          _buildTextField('Document Name', Icons.insert_drive_file, (value) => _business.documentName = value),
          _buildTextField('Tags', Icons.tag, (value) => _business.tags = value),
          _buildTextField('Comment', Icons.comment, (value) => _business.comment = value),
          _buildTextFieldWithFilePicker('File Path', Icons.folder, (value) => _business.file = value),
          //_buildTextField('Add Media', Icons.perm_media_outlined, (value) => _buildMediaPicker(),),
        ], showSaveButton: true),

      ],
    );
  }

  // Step Card Layout
  Widget _buildStepCard(String title, List<Widget> fields, {bool showSaveButton = false}) {
    return IntrinsicWidth( // Centers the card in the available space
       child: IntrinsicHeight( // Adjusts height based on the content
          child: Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensures column doesn't take extra space
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...fields, // Dynamically adds form fields

                  if (showSaveButton) // Show only on last step
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 400,
                        child: ElevatedButton(
                          onPressed: _saveForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade300,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Text("SAVE", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  // Function to create text fields with file picker
  Widget _buildTextFieldWithFilePicker(String label, IconData icon, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: TextEditingController(text: _business.file),
        readOnly: true, // Make it non-editable
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(Icons.attach_file, color: Colors.blue),
            onPressed: _pickFile,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onTap: _pickFile,
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
