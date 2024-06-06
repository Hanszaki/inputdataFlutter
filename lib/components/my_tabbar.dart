import 'package:flutter/material.dart';
import 'package:newproject4/pages/input_data_master/data_proyek.dart';
import 'package:newproject4/pages/input_data_master/input_layanan.dart';
import 'package:newproject4/pages/input_data_master/input_pelanggan.dart';
import 'package:newproject4/pages/input_data_master/kategory_page.dart';
import 'package:newproject4/pages/laporan_datamaster.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          labelColor: Color.fromARGB(255, 66, 50, 97),
          indicatorColor: Color.fromARGB(255, 66, 50, 97),
          indicatorWeight: 4,
          tabs: [
            Container(
              width: 75,
              height: 70,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Tab(
                  icon: Icon(
                    Icons.design_services_outlined,
                    size: 45,
                  ),
                ),
              ),
            ),
            Container(
              width: 75,
              alignment: Alignment.center,
              height: 70,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Tab(
                  icon: Icon(
                    Icons.receipt_long_rounded,
                    size: 45,
                  ),
                ),
              ),
            ),
            Container(
              width: 75,
              alignment: Alignment.center,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Tab(
                  icon: Icon(
                    Icons.poll_outlined,
                    size: 45,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Color.fromARGB(255, 66, 50, 97),
            child: TabBarView(
              children: [
                // Isi dari Tab 1
                SizedBox(
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Data Master',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 75.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 9 / 9,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, int i) {
                            List<Map<String, dynamic>> serviceData = [
                              {
                                'icon': Icons.import_contacts_rounded,
                                'text': 'Input Layanan',
                              },
                              {
                                'icon': Icons.category_rounded,
                                'text': 'Kategory',
                              },
                              {
                                'icon': Icons.supervisor_account,
                                'text': 'Pelanggan',
                              },
                              {
                                'icon': Icons.cases_rounded,
                                'text': 'Data Proyek',
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
                                            builder: (context) =>
                                                InputLayanan()),
                                      );
                                    } else if (i == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Kategory()),
                                      );
                                    } else if (i == 2) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Pelanggan()),
                                      );
                                    } else if (i == 3) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DataProyek()),
                                      );
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          serviceData[i]['icon'],
                                          size: 75,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
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
                                            horizontal: 55.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.blue.shade800,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 7),
                                                child: Text(
                                                  "Tambah",
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

                // Isi dari Tab 2
                SizedBox(
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Data Transaksi',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 75.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 9 / 9,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, int i) {
                            List<Map<String, dynamic>> serviceData = [
                              {
                                'icon': Icons.transform_rounded,
                                'text': 'Data Transaksi',
                              },
                              {
                                'icon': Icons.edit_square,
                                'text': 'Hasil Riset',
                              },
                              {
                                'icon': Icons.history_edu,
                                'text': 'Data Kuitansi',
                              },
                              {
                                'icon': Icons.task_rounded,
                                'text': 'Hasil Test',
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
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          serviceData[i]['icon'],
                                          size: 75,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
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
                                            horizontal: 55.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.blue.shade800,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 7),
                                                child: Text(
                                                  "Tambah",
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
                // Isi dari Tab 3
                SizedBox(
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Laporan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 75.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 9 / 9,
                          ),
                          itemCount: 3,
                          itemBuilder: (context, int i) {
                            List<Map<String, dynamic>> serviceData = [
                              {
                                'icon': Icons.design_services_outlined,
                                'text': 'Data Master',
                              },
                              {
                                'icon': Icons.receipt_long_rounded,
                                'text': 'Data Transaksi',
                              },
                              {
                                'icon': Icons.task_alt_rounded,
                                'text': 'Hasil Akhir',
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
                                            builder: (context) =>
                                                LDataMaster()),
                                      );
                                    } else if (i == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InputLayanan()),
                                      );
                                    } else if (i == 2) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InputLayanan()),
                                      );
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          serviceData[i]['icon'],
                                          size: 75,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
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
                                            horizontal: 57.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.blue.shade800,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 15),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
