import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Kategory extends StatefulWidget {
  const Kategory({super.key});

  @override
  _KategoryState createState() => _KategoryState();
}

class _KategoryState extends State<Kategory> {
  final TextEditingController _kodeKategoriController = TextEditingController();
  final TextEditingController _namaLayananController = TextEditingController();
  final TextEditingController _referensiController = TextEditingController();
  final TextEditingController _ukuranController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  Future<void> _createData() async {
    String kodeKategori = _kodeKategoriController.text;
    String namaLayanan = _namaLayananController.text;
    String referensi = _referensiController.text;
    String ukuran = _ukuranController.text;
    String harga = _hargaController.text;

    if (kodeKategori.isEmpty ||
        namaLayanan.isEmpty ||
        referensi.isEmpty ||
        ukuran.isEmpty ||
        harga.isEmpty) {
      _showValidationDialog();
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('jenis_kategori').add({
        'kode_kategori': kodeKategori,
        'nama_layanan': namaLayanan,
        'referensi': referensi,
        'ukuran': ukuran,
        'harga': harga,
      });
      _clearFields();
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _clearFields() {
    _kodeKategoriController.clear();
    _namaLayananController.clear();
    _referensiController.clear();
    _ukuranController.clear();
    _hargaController.clear();
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
          "Jenis Kategori",
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
              'Kode Kategori Layanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _kodeKategoriController,
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
              'Nama Layanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
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
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Referensi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _referensiController,
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
              'Ukuran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _ukuranController,
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
              'Harga',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _hargaController,
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
