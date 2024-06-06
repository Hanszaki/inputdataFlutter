import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataInputKategori extends StatefulWidget {
  const DataInputKategori({super.key});

  @override
  _DataInputKategoriState createState() => _DataInputKategoriState();
}

class _DataInputKategoriState extends State<DataInputKategori> {
  int _rowsPerPage = 5;
  int _currentPage = 0;
  String _searchQuery = "";
  List<DocumentSnapshot> _documents = [];

  Future<void> _fetchData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('jenis_kategori').get();
      setState(() {
        _documents = snapshot.docs;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  List<DocumentSnapshot> get _filteredData {
    if (_searchQuery.isEmpty) {
      return _documents;
    } else {
      return _documents.where((doc) {
        return doc['kode_kategori']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            doc['nama_layanan']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            doc['referensi']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            doc['ukuran']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            doc['harga']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  Future<void> _deleteItem(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('jenis_kategori')
          .doc(id)
          .delete();
      _fetchData();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  void _editItem(String id) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _kodeKategoriController =
            TextEditingController();
        final TextEditingController _namaLayananController =
            TextEditingController();
        final TextEditingController _referensiController =
            TextEditingController();
        final TextEditingController _ukuranController = TextEditingController();
        final TextEditingController _hargaController = TextEditingController();

        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _kodeKategoriController,
                decoration: InputDecoration(labelText: 'Kode Kategori'),
              ),
              TextField(
                controller: _namaLayananController,
                decoration: InputDecoration(labelText: 'Nama Layanan'),
              ),
              TextField(
                controller: _referensiController,
                decoration: InputDecoration(labelText: 'Referensi'),
              ),
              TextField(
                controller: _ukuranController,
                decoration: InputDecoration(labelText: 'Ukuran'),
              ),
              TextField(
                controller: _hargaController,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('jenis_kategori')
                      .doc(id)
                      .update({
                    'kode_kategori': _kodeKategoriController.text,
                    'nama_layanan': _namaLayananController.text,
                    'referensi': _referensiController.text,
                    'ukuran': _ukuranController.text,
                    'harga': _hargaController.text,
                  });
                  Navigator.of(context).pop();
                  _fetchData();
                } catch (e) {
                  print('Error updating item: $e');
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _paginatedData = _filteredData
        .skip(_currentPage * _rowsPerPage)
        .take(_rowsPerPage)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Input Kategori",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  header: Text('Daftar Kategori'),
                  rowsPerPage: _rowsPerPage,
                  onRowsPerPageChanged: (perPage) {
                    setState(() {
                      _rowsPerPage = perPage!;
                    });
                  },
                  availableRowsPerPage: [5, 10, 15, 20],
                  columns: [
                    DataColumn(label: Text('Kode Kategori')),
                    DataColumn(label: Text('Nama Layanan')),
                    DataColumn(label: Text('Referensi')),
                    DataColumn(label: Text('Ukuran')),
                    DataColumn(label: Text('Harga')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  source: _TableDataSource(
                    data: _paginatedData,
                    editItem: _editItem,
                    deleteItem: _deleteItem,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _currentPage > 0
                      ? () {
                          setState(() {
                            _currentPage--;
                          });
                        }
                      : null,
                  child: Text('Previous'),
                ),
                TextButton(
                  onPressed: _currentPage <
                          (_filteredData.length / _rowsPerPage).ceil() - 1
                      ? () {
                          setState(() {
                            _currentPage++;
                          });
                        }
                      : null,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TableDataSource extends DataTableSource {
  final List<DocumentSnapshot> data;
  final void Function(String) editItem;
  final void Function(String) deleteItem;

  _TableDataSource({
    required this.data,
    required this.editItem,
    required this.deleteItem,
  });

  @override
  DataRow getRow(int index) {
    // ignore: null_check_always_fails
    if (index >= data.length) return null!;
    final item = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(item['kode_kategori'])),
        DataCell(Text(item['nama_layanan'])),
        DataCell(Text(item['referensi'])),
        DataCell(Text(item['ukuran'])),
        DataCell(Text(item['harga'])),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => editItem(item.id),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteItem(item.id),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
