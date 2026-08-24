import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:hive/hive.dart';
import 'models/hazard.dart';

class HazardReportScreen extends StatefulWidget {
  final VoidCallback? onHazardSaved;

  const HazardReportScreen({super.key, this.onHazardSaved});

  @override
  State<HazardReportScreen> createState() => _HazardReportScreenState();
}

class _HazardReportScreenState extends State<HazardReportScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String imagePath = "";
  String selectedSeverity = "Low";
  final ImagePicker picker = ImagePicker();
  late stt.SpeechToText speech;
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  Future<void> openCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (!mounted) return;
    if (photo != null) setState(() => imagePath = photo.path);
  }

  Future<void> openGallery() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (!mounted) return;
    if (photo != null) setState(() => imagePath = photo.path);
  }

  Future<void> startListening() async {
    bool available = await speech.initialize();
    if (!available) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Speech recognition not available")),
      );
      return;
    }
    setState(() => isListening = true);
    speech.listen(onResult: (result) {
      setState(() => descController.text = result.recognizedWords);
    });
  }

  void stopListening() {
    speech.stop();
    setState(() => isListening = false);
  }

  void saveHazard() {
    final title = titleController.text.trim();
    final description = descController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and description required")),
      );
      return;
    }

    final hazard = Hazard(
      title: title,
      description: description,
      imagePath: imagePath,
      severity: selectedSeverity,
      timestamp: DateTime.now(),
    );

    final box = Hive.box('hazards');
    box.add(hazard);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Hazard saved")),
    );

    widget.onHazardSaved?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              const SizedBox(height: 30),

              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Hazard Title",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onEditingComplete: () => FocusScope.of(context).unfocus(),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: descController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onEditingComplete: () => FocusScope.of(context).unfocus(),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: selectedSeverity,
                dropdownColor: const Color(0xFF203A43),
                decoration: InputDecoration(
                  labelText: "Severity",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                items: ["Low", "Medium", "High"]
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level, style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedSeverity = value!);
                },
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: openCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: openGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Gallery"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (imagePath.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: isListening ? stopListening : startListening,
                icon: Icon(isListening ? Icons.stop : Icons.mic),
                label: Text(isListening ? "Stop Listening" : "Speak Description"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: saveHazard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Save Hazard",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
