import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  bool _seekingRecruitment = true;
  double _gpa = 3.4;
  String _position = 'SG';
  
  final List<String> _positions = ['PG', 'SG', 'SF', 'PF', 'C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('EDIT PROFILE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade900,
                        border: Border.all(color: const Color(0xFFE4FF00), width: 2),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1518063319789-7217e6706b04?q=80&w=200&auto=format&fit=crop'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFE4FF00),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              const _SectionHeader(title: 'BASIC INFO'),
              _buildTextField('Full Name', initialValue: 'Jalen Green'),
              _buildTextField('Bio', initialValue: 'Class of 2025. 5-Star Recruit. Hardest worker in the room.', maxLines: 3),
              
              const SizedBox(height: 24),
              const _SectionHeader(title: 'ATHLETIC INFO'),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField('Position', _position, _positions, (v) {
                      setState(() => _position = v!);
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Height', initialValue: "6'5\"")),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Weight (lbs)', initialValue: '185')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Wingspan', initialValue: "6'8\"")),
                ],
              ),

              const SizedBox(height: 24),
              const _SectionHeader(title: 'ACADEMIC INFO'),
              _buildTextField('High School', initialValue: 'Prolific Prep'),
              _buildTextField('Graduation Year', initialValue: '2025'),
              const SizedBox(height: 16),
              const Text('Cumulative GPA', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text(_gpa.toStringAsFixed(1), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Slider(
                      value: _gpa,
                      min: 2.0,
                      max: 4.0,
                      divisions: 20,
                      activeColor: const Color(0xFFE4FF00),
                      inactiveColor: Colors.white24,
                      onChanged: (val) => setState(() => _gpa = val),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const _SectionHeader(title: 'RECRUITING STATUS'),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Seeking Recruitment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Turn off if you have committed to a program.', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                    ),
                    Switch(
                      value: _seekingRecruitment,
                      activeColor: const Color(0xFFE4FF00),
                      onChanged: (val) => setState(() => _seekingRecruitment = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100), // padding for FAB
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile Updated Successfully!')),
                );
                context.pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE4FF00),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('SAVE CHANGES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5)),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {String? initialValue, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.grey.shade900.withValues(alpha: 0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE4FF00)),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: Colors.grey.shade900,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.grey.shade900.withValues(alpha: 0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(color: Color(0xFFE4FF00), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }
}
