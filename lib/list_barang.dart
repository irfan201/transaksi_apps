import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaksi_apps/add_barang.dart';
import 'package:transaksi_apps/edit_barang.dart';
import 'package:transaksi_apps/home.dart';
import 'package:transaksi_apps/database_helper.dart';

class ListBarangPage extends StatefulWidget {
  const ListBarangPage({super.key});

  @override
  _ListBarangPage createState() => _ListBarangPage();
}

class _ListBarangPage extends State<ListBarangPage> {
  late Future<List<Map<String, dynamic>>> _barang;
  late TextEditingController _searchController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _getBarangData();
    _searchController = TextEditingController();
  }

  Future<void> _getBarangData() async {
    DatabaseHelper databaseHelper = DatabaseHelper();

    if (_isSearching) {
      _barang = databaseHelper.searchBarang(_searchController.text);
    } else {
      _barang = databaseHelper.getBarang();
    }
  }

  void _performSearch(String searchTerm) async {
    if (searchTerm.isNotEmpty) {
      List<Map<String, dynamic>> barangData = await _barang.then((value) =>
          value
              .where((barang) => barang['nama_barang']
                  .toString()
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()))
              .toList());

      setState(() {
        _barang = Future.value(barangData);
      });
    } else {
      _getBarangData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Cari Nama Barang...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    _performSearch(value);
                  },
                )
              : const Text(
                  'List Barang',
                  style: TextStyle(color: Colors.white),
                ),
          backgroundColor: const Color(0xFF2C447C),
          actions: [
            _isSearching
                ? IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                        _getBarangData();
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: FutureBuilder(
          future: _barang,
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> barang = snapshot.data ?? [];
              return ListView.builder(
                itemCount: barang.length,
                itemBuilder: (context, index) {
                  final barangData = barang[index];
                  return Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              barangData['nomor_barang'],
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2C447C)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Nama Barang",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "Kode Barang",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(barangData['nama_barang'],
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const SizedBox(width: 80),
                                Text(barangData['kode_barang'],
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Jumlah Barang",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(barangData['jumlah_barang'].toString(),
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const SizedBox(width: 80),
                                Text(
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 2,
                                  ).format(barangData['total'] ?? 0),
                                )
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            const Divider(
                              color: Colors.grey,
                              height: 5,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditBarang(
                                          barangId: barangData['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2C447C),
                                    minimumSize:
                                        MediaQuery.of(context).size.width >= 600
                                            ? const Size(250, 43)
                                            : const Size(120, 43),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        barangData['id']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    minimumSize:
                                        MediaQuery.of(context).size.width >= 600
                                            ? const Size(250, 43)
                                            : const Size(120, 43),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(
                                            0xFF2C447C)), 
                                  ),
                                  child: Text(
                                    'Hapus',
                                    style: TextStyle(
                                      color: const Color(0xFF2C447C),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF2C447C),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('List Transaksi'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              ListTile(
                title: const Text('List Barang'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListBarangPage()));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBarang()),
            );
          },
          backgroundColor: const Color(0xFF2C447C),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus barang ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus'),
              onPressed: () async {
                await DatabaseHelper().deleteBarang(id);

                _getBarangData();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
