import 'package:flutter/material.dart';
import 'package:transaksi_apps/list_barang.dart';

import 'database_helper.dart';
import 'model/barang_model.dart';

class EditBarang extends StatefulWidget {
  final int barangId;

  const EditBarang({Key? key, required this.barangId}) : super(key: key);

  @override
  _EditBarangState createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBarangData();
  }

  Future<void> _loadBarangData() async {
    BarangModel barang = await DatabaseHelper().getBarangById(widget.barangId);

    setState(() {
      _kodeController.text = barang.kodeBarang;
      _nomorController.text = barang.nomorBarang;
      _namaBarangController.text = barang.namaBarang;
      _hargaController.text = barang.hargaBarang.toString();
      _jumlahController.text = barang.jumlahBarang.toString();
      _totalController.text = barang.total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    updateTotal();
    return MaterialApp(
      home: Scaffold(
          body: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'BARANG',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Kode Barang',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _kodeController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Kode Barang',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 9),
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Nomor Barang',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _nomorController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Nomor Barang',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 9),
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Nama Barang',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _namaBarangController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Nama Barang',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 9),
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      'Harga',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _hargaController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Harga',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 9),
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Jumlah',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _jumlahController,
                      onChanged: (String value) {
                        updateTotal();
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Jumlah',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 9),
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Total',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _totalController,
                      enabled: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Total',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 9),
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            BarangModel updatedBarang =
                                await DatabaseHelper().updateBarang(
                              widget.barangId,
                              BarangModel(
                                kodeBarang: _kodeController.text,
                                nomorBarang: _nomorController.text,
                                namaBarang: _namaBarangController.text,
                                hargaBarang:
                                    double.parse(_hargaController.text),
                                jumlahBarang: int.parse(_jumlahController.text),
                                total: double.parse(_totalController.text),
                              ),
                            );

                            setState(() {
                              _kodeController.text = updatedBarang.kodeBarang;
                              _nomorController.text = updatedBarang.nomorBarang;
                              _namaBarangController.text =
                                  updatedBarang.namaBarang;
                              _hargaController.text =
                                  updatedBarang.hargaBarang.toString();
                              _jumlahController.text =
                                  updatedBarang.jumlahBarang.toString();
                              _totalController.text =
                                  updatedBarang.total.toString();
                            });

                            print('Data barang berhasil diupdate!');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ListBarangPage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF505F98),
                          minimumSize: MediaQuery.of(context).size.width >= 600
                              ? const Size(600, 53)
                              : const Size(360, 43),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Update Barang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }

  void updateTotal() {
    if (_jumlahController.text.isNotEmpty && _hargaController.text.isNotEmpty) {
      int jumlah = int.parse(_jumlahController.text);
      double harga = double.parse(_hargaController.text);
      double total = jumlah * harga;

      _totalController.text = total.toStringAsFixed(2);
    }
  }
}
