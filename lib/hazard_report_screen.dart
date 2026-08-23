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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Report Hazard"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Hazard Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: openCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[900],
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: openGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Gallery"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[700],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (imagePath.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(File(imagePath), fit: BoxFit.cover),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: isListening ? stopListening : startListening,
              icon: Icon(isListening ? Icons.stop : Icons.mic),
              label: Text(isListening ? "Stop Listening" : "Speak Description"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[700],
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveHazard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                  foregroundColor: Colors.white,
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
    );
  }
}
