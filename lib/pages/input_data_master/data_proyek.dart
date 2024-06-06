import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProyek extends StatefulWidget {
  const DataProyek({super.key});

  @override
  _DataProyekState createState() => _DataProyekState();
}

class _DataProyekState extends State<DataProyek> {
  final TextEditingController _kodeProyekController = TextEditingController();
  final TextEditingController _namaProyekController = TextEditingController();
  final TextEditingController _telpFaxController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _createData() async {
    String kodeProyek = _kodeProyekController.text;
    String namaProyek = _namaProyekController.text;
    String telpFax = _telpFaxController.text;
    String email = _emailController.text;

    if (kodeProyek.isEmpty ||
        namaProyek.isEmpty ||
        telpFax.isEmpty ||
        email.isEmpty) {
      _showErrorDialog('Semua field harus diisi.');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('data_input_proyek').add({
        'kode_proyek': kodeProyek,
        'nama_proyek': namaProyek,
        'telp_fax': telpFax,
        'email': email,
      });
      _clearFields();
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _clearFields() {
    _kodeProyekController.clear();
    _namaProyekController.clear();
    _telpFaxController.clear();
    _emailController.clear();
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
          content: Text(message),
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
          "Data Proyek",
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
              'Kode Proyek',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _kodeProyekController,
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
              'Nama Proyek',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _namaProyekController,
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
              'Telp/Fax',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _telpFaxController,
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
              'Email',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _emailController,
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
