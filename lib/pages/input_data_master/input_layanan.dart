import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InputLayanan extends StatefulWidget {
  const InputLayanan({Key? key}) : super(key: key);

  @override
  _InputLayananState createState() => _InputLayananState();
}

class _InputLayananState extends State<InputLayanan> {
  final TextEditingController _kodeLayananController = TextEditingController();
  final TextEditingController _namaLayananController = TextEditingController();

  Future<void> _simpanData() async {
    String kodeLayanan = _kodeLayananController.text;
    String namaLayanan = _namaLayananController.text;

    if (kodeLayanan.isEmpty || namaLayanan.isEmpty) {
      _showErrorDialog('Semua field harus diisi.');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('data_input_layanan').add({
        'kodeLayanan': kodeLayanan,
        'namaLayanan': namaLayanan,
      });

      _kodeLayananController.clear();
      _namaLayananController.clear();

      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog('Gagal menyimpan data: $e');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Data berhasil disimpan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Input Layanan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 66, 50, 97),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 66, 50, 97),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Kode Layanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _kodeLayananController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nama Layanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _namaLayananController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _simpanData,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 24, 72),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
