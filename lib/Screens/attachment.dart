import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:loqal_timetracker/components/login_custom_button.dart';
// import 'package:loqal_timetracker/helper/lang_provider.dart';
// import 'package:loqal_timetracker/models/employee/employee_model.dart';
// import 'package:loqal_timetracker/ui/colors/app_color.dart';
// import 'package:loqal_timetracker/ui/screens/employee/employee_list_screen.dart';
// import 'package:loqal_timetracker/ui/screens/todos/task/task_model.dart';
// import 'package:loqal_timetracker/viewmodels/employee_view_model.dart';
// import 'package:loqal_timetracker/wrapper/provider_wrapper.dart';
//
// import 'assign_employee_screen.dart';

class CreateTaskScreen extends StatefulWidget {
  final String? selectedLocation;
  const CreateTaskScreen({super.key, this.selectedLocation});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late Map<String, String> _lang = {};

  @override
  void initState() {
    super.initState();
    // initData();
  }

  // void initData() async {
  //   Map<String, String> mylang = await LangProvider.loadLanguage();
  //   setState(() {
  //     _lang = mylang;
  //   });
  // }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _tagController = TextEditingController(); // Controller for tag input

  final List<Map<String, dynamic>> _priorityLevels = [
    {'label': 'High', 'icon': Icons.priority_high, 'color': Colors.red},
    {'label': 'Medium', 'icon': Icons.trending_up, 'color': Colors.orange},
    {'label': 'Low', 'icon': Icons.low_priority, 'color': Colors.green},
  ];

  //final List<String> _priorityLevels = ['High', 'Medium', 'Low'];
  final List<String> _assignedToOptions = ['Self', 'Employees'];

  String? _selectedPriority;
  String? _assignedTo;
  String? _selectedEmployee;
  String? _selectedEmpId;
  String? _selectedFileName;

  List<String> _tags = []; // List to store tags

  void _selectDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dueDateController.text =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
      });
    }
  }

  void _addTag() {
    if (_tagController.text.isNotEmpty && !_tags.contains(_tagController.text)) {
      setState(() {
        _tags.add(_tagController.text);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  // void _selectEmployee() async {
  //   Employee? selected = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const AssignEmployeeScreen()),
  //   );
  //   if (selected != null) {
  //     setState(() {
  //       _selectedEmployee = selected.name;
  //       _selectedEmpId = selected.id.toString();
  //     });
  //   }
  // }

  //
  // void saveTask() {
  //   if (_formKey.currentState!.validate()) {
  //     final newTask = Task(
  //       name: _taskNameController.text,
  //       priority: _selectedPriority!,
  //       dueDate: _dueDateController.text,
  //       description: _taskDescriptionController.text,
  //       assignedTo: _assignedTo == "Employees" ? _selectedEmployee! : "Self",
  //     );
  //     Navigator.pop(context, newTask);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // return ProviderWrapper<EmployeeViewModel>(
    //   create: (context)=> EmployeeViewModel(getContext: ()=> context),
    //   builder: (context, empViewModel,_){
        return Scaffold(
          // backgroundColor: AppColors.greyBackgrond,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(_lang["create_task"] ?? "Create Task", style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue,
            // backgroundColor: AppColors.mainappColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Name
                    Text(_lang["task_name"] ?? "Task Name", style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _taskNameController,
                      decoration: InputDecoration(
                        hintText: _lang["enter_task_name"] ?? "Enter task name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter the task name' : null,
                    ),
                    const SizedBox(height: 16),

                    // Priority Level and Due Date
                    Row(
                      children: [
                        //Priority
                        Expanded(
                          child:  DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            value: _selectedPriority,
                            items: _priorityLevels.map((priority) {
                              return DropdownMenuItem<String>(
                                value: priority['label'] as String,
                                child: Row(
                                  children: [
                                    Icon(priority['icon'] as IconData, color: priority['color'] as Color),
                                    const SizedBox(width: 8),
                                    Text(priority['label'] as String),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() => _selectedPriority = value!),
                            validator: (value) => value == null ? 'Please select a priority' : null,
                            hint: const Text("Priority"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        //Due Date
                        Expanded(
                          child: TextFormField(
                            controller: _dueDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Due date",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: const Icon(Icons.calendar_today, color: Colors.black54, size: 18),
                            ),
                            onTap: _selectDueDate,
                            validator: (value) => value!.isEmpty ? 'Please select a due date' : null,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Assigned To
                    Text(_lang["assigned_to"] ?? "Assigned To", style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    // DropdownButtonFormField<String>(
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //   ),
                    //   value: _assignedTo,
                    //   items: _assignedToOptions.map((option) {
                    //     return DropdownMenuItem(value: option, child: Text(option));
                    //   }).toList(),
                    //   onChanged: (value) => setState(() {
                    //     _assignedTo = value;
                    //     _selectedEmployee = null; // Reset employee selection if switching
                    //   }),
                    //   validator: (value) => value == null ? 'Please select an assignment option' : null,
                    //   hint: Text(_lang["assigned_to"] ?? "Assigned to"),
                    // ),

                    _buildLocationField(),

                    if (_assignedTo == "Employees") ...[
                      const SizedBox(height: 16),
                      Text(_lang["select_employee"] ?? "Select Employee", style: const TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: _selectedEmployee,
                        // items: empViewModel.employeeList.map((employee) {
                        //   return DropdownMenuItem<String>(
                        //     value: employee.name,
                        //     child: Text(employee.name ?? ''),
                        //   );
                        // }).toList(),
                        onChanged: (value) => setState(() => _selectedEmployee = value),
                        validator: (value) => _assignedTo == "Employees" && value == null ? 'Please select an employee' : null,
                        hint: Text(_lang["select_employee"] ?? "Select an employee"), items: [],
                      ),
                    ],

                    const SizedBox(height: 16),

                    //Attachment
                    const Text("Attachment", style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _pickAttachment,  // Ensure function name matches exactly
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 0.8),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _selectedFileName ?? "No file selected",
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                            const Icon(Icons.attach_file, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tags Section
                    const Text("Tags", style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _tagController,
                      decoration: InputDecoration(
                        hintText: "Enter a tag and press add",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add, color: Colors.blue),
                          onPressed: _addTag,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _tags.map((tag) => _buildTagChip(tag)).toList(),
                    ),

                    const SizedBox(height: 24),
                    // Task Description
                    Text(_lang["task_description"] ?? "Task Description", style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _taskDescriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: _lang["enter_task_description"] ?? "Enter description here...",
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter the task description' : null,
                    ),
                    const SizedBox(height: 24),

                    //Save Task Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save Task Logic
                          print("Task Saved!");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Center(
                        child: Text("Save Task", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),

                    // CustomButton(title: _lang["save_task"] ?? "Save Task", onTap: saveTask, color: AppColors.mainappColor, borderRadius: 12),
                    // Attachment Field
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: "back_button",
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> const CardSelectionScreen()));
            },
            // backgroundColor: AppColors.mainappColor,
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 25,
            ),
          ),
        );
    //   },
    // );
  }

  Widget _buildLocationField() {
    return InkWell(
      // onTap: _selectEmployee,
      // onTap: (){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const AssignEmployeeScreen()),
      //   );
      // },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Colors.black,
              width: 0.8
          ),
          boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedEmployee ?? _lang["assigned_to"]?? 'Assigned To',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            // Icon(Icons.assignment, color: AppColors.mainappColor),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.label, size: 16, color: Colors.blue),
          const SizedBox(width: 4),
          Text(tag, style: const TextStyle(fontSize: 14, color: Colors.black)),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: const Icon(Icons.close, size: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }


}