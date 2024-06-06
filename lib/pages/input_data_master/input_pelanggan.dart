import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pelanggan extends StatefulWidget {
  const Pelanggan({super.key});

  @override
  _PelangganState createState() => _PelangganState();
}

class _PelangganState extends State<Pelanggan> {
  final TextEditingController _kodePelangganController =
      TextEditingController();
  final TextEditingController _namaPelangganController =
      TextEditingController();
  final TextEditingController _npwpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  Future<void> _createData() async {
    String kodePelanggan = _kodePelangganController.text;
    String namaPelanggan = _namaPelangganController.text;
    String npwp = _npwpController.text;
    String alamat = _alamatController.text;

    if (kodePelanggan.isEmpty ||
        namaPelanggan.isEmpty ||
        npwp.isEmpty ||
        alamat.isEmpty) {
      _showValidationDialog();
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('data_input_pelanggan').add({
        'kode_pelanggan': kodePelanggan,
        'nama_pelanggan': namaPelanggan,
        'npwp': npwp,
        'alamat': alamat,
      });
      _clearFields();
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _clearFields() {
    _kodePelangganController.clear();
    _namaPelangganController.clear();
    _npwpController.clear();
    _alamatController.clear();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Data berhasil disimpan.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Data gagal disimpan: $message'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showValidationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Semua field harus diisi.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Data Pelanggan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 66, 50, 97),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 66, 50, 97),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Kode Pelanggan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _kodePelangganController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Nama Pelanggan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _namaPelangganController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'NPWP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _npwpController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Alamat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _createData,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 24, 72),
                  ),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
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
