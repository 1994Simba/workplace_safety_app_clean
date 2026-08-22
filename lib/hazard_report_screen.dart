import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'models/hazard.dart';

class HazardReportScreen extends StatefulWidget {
  const HazardReportScreen({super.key});

  @override
  State<HazardReportScreen> createState() => _HazardReportScreenState();
}

class _HazardReportScreenState extends State<HazardReportScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _captureImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });
    }
  }

  Future<String?> _saveImagePermanently(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    final newImage = await image.copy('$path/$fileName');
    return newImage.path;
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
            _descriptionController.text = _text;
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _saveHazard() async {
    FocusScope.of(context).unfocus(); // ✅ closes keyboard

    final description = _descriptionController.text.trim();

    if (description.isEmpty && _imageFile == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe or capture a hazard.')),
      );
      return;
    }

    String? savedImagePath;
    if (_imageFile != null) {
      savedImagePath = await _saveImagePermanently(_imageFile!);
    }

    final hazardBox = Hive.box<Hazard>('hazards');

    final hazard = Hazard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: "Reported Hazard",
      description: description,
      timestamp: DateTime.now(),
      imagePath: savedImagePath,
    );

    hazardBox.add(hazard);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hazard saved successfully!')),
    );

    _descriptionController.clear();
    setState(() {
      _imageFile = null;
      _text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // ✅ tap anywhere to close keyboard
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Report Hazard'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Describe the hazard',
                  border: UnderlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _captureImage,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Capture Photo'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: _listen,
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    label: Text(_isListening ? 'Listening...' : 'Speak Hazard'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveHazard,
                child: const Text('Save Hazard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
