import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataInputProyek extends StatefulWidget {
  const DataInputProyek({super.key});

  @override
  _DataInputProyekState createState() => _DataInputProyekState();
}

class _DataInputProyekState extends State<DataInputProyek> {
  int _rowsPerPage = 5;
  int _currentPage = 0;
  String _searchQuery = "";
  List<DocumentSnapshot> _documents = [];

  Future<void> _fetchData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('data_input_proyek')
          .get();
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
        return doc['kode_proyek']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            doc['nama_proyek']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  Future<void> _deleteItem(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('data_input_proyek')
          .doc(id)
          .delete();
      _fetchData();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  void _editItem(String id, String kodeProyek, String namaProyek,
      String telpFax, String email) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _editKodeProyekController =
            TextEditingController(text: kodeProyek);
        final TextEditingController _editNamaProyekController =
            TextEditingController(text: namaProyek);
        final TextEditingController _editTelpFaxController =
            TextEditingController(text: telpFax);
        final TextEditingController _editEmailController =
            TextEditingController(text: email);

        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editKodeProyekController,
                decoration: InputDecoration(labelText: 'Kode Proyek'),
              ),
              TextField(
                controller: _editNamaProyekController,
                decoration: InputDecoration(labelText: 'Nama Proyek'),
              ),
              TextField(
                controller: _editTelpFaxController,
                decoration: InputDecoration(labelText: 'Telp/Fax'),
              ),
              TextField(
                controller: _editEmailController,
                decoration: InputDecoration(labelText: 'Email'),
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
                      .collection('data_input_proyek')
                      .doc(id)
                      .update({
                    'kode_proyek': _editKodeProyekController.text,
                    'nama_proyek': _editNamaProyekController.text,
                    'telp_fax': _editTelpFaxController.text,
                    'email': _editEmailController.text,
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
          "Data Input Proyek",
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
                  header: Text('Daftar Proyek'),
                  rowsPerPage: _rowsPerPage,
                  onRowsPerPageChanged: (perPage) {
                    setState(() {
                      _rowsPerPage = perPage!;
                    });
                  },
                  availableRowsPerPage: [5, 10, 15, 20],
                  columns: [
                    DataColumn(label: Text('Kode Proyek')),
                    DataColumn(label: Text('Nama Proyek')),
                    DataColumn(label: Text('Telp/Fax')),
                    DataColumn(label: Text('Email')),
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
  final void Function(String, String, String, String, String) editItem;
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
        DataCell(Text(item['kode_proyek'] ?? '')),
        DataCell(Text(item['nama_proyek'] ?? '')),
        DataCell(Text(item['telp_fax'] ?? '')),
        DataCell(Text(item['email'] ?? '')),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => editItem(
                  item.id,
                  item['kode_proyek'] ?? '',
                  item['nama_proyek'] ?? '',
                  item['telp_fax'] ?? '',
                  item['email'] ?? '',
                ),
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
