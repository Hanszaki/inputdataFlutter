import 'package:flutter/material.dart';
import 'package:newproject4/laporan/data_master/data_inputlayanan.dart';
import 'package:newproject4/laporan/data_master/data_inputpelanggan.dart';
import 'package:newproject4/laporan/data_master/data_inputproyek.dart';
import 'package:newproject4/laporan/data_master/data_jeniskategory.dart';

class LDataMaster extends StatelessWidget {
  const LDataMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Laporan Data Mater",
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
            Navigator.pop(
                context); // Menggunakan Navigator.pop untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 66, 50, 97),
        padding: EdgeInsets.all(20),
        child: SizedBox(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 8 / 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, int i) {
                    List<Map<String, dynamic>> serviceData = [
                      {
                        'icon': Icons.import_contacts_rounded,
                        'text': '        Table\nInput Layanan',
                      },
                      {
                        'icon': Icons.category_rounded,
                        'text': '   Table\nKategory',
                      },
                      {
                        'icon': Icons.supervisor_account,
                        'text': '     Table\nPelanggan',
                      },
                      {
                        'icon': Icons.cases_rounded,
                        'text': '      Table\nData Proyek',
                      },
                    ];

                    return Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Material(
                        elevation: 10,
                        color: Theme.of(context).colorScheme.tertiary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (i == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataInputLayanan()),
                              );
                            } else if (i == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataInputKategori()),
                              );
                            } else if (i == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataInputPelanggan()),
                              );
                            } else if (i == 3) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataInputProyek()),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Icon(
                                  serviceData[i]['icon'],
                                  size: 75,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                child: Text(
                                  serviceData[i]['text'],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 7),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 47.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade800,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Text(
                                          "Cek",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
