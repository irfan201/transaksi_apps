import 'package:flutter/material.dart';
import 'package:transaksi_apps/database_helper.dart';
import 'package:transaksi_apps/home.dart';
import 'package:transaksi_apps/model/transaksi_model.dart';

class AddTransaksi extends StatefulWidget {
  const AddTransaksi({Key? key}) : super(key: key);

  @override
  _AddTransaksiState createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  List<String> barangOptions = [];
  Map<String, double> barangHargaMap = {};

  @override
  void initState() {
    super.initState();
    _fetchBarangOptions();
  }

  Future<void> _fetchBarangOptions() async {
    List<Map<String, dynamic>> barangList = await DatabaseHelper().getBarang();
    setState(() {
      barangOptions = barangList.map<String>((barang) {
        final String namaBarang = barang['nama_barang'];
        final double harga =
            barang['harga_barang']; 
        barangHargaMap[namaBarang] = harga;
        return namaBarang;
      }).toList();
      selectedBarang = barangOptions.isNotEmpty ? barangOptions.first : '';
    });
  }

  String selectedBarang = '';

  @override
  Widget build(BuildContext context) {
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
                        'TRANSAKSI',
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
                      'Nomor',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
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
                        hintText: 'Nomor',
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Tanggal',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _dateController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Tanggal',
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Barang',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    DropdownButtonFormField<String>(
                      value: selectedBarang,
                      onChanged: (String? value) {
                        setState(() {
                          selectedBarang = value!;
                          _hargaController.text =
                              barangHargaMap[selectedBarang]?.toString() ?? '';
                        });
                      },
                      items: barangOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please choose an option';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 9),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(color: Color(0xFFE9E9E9), width: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Harga',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      enabled: false,
                      controller: _hargaController,
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Jumlah',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _jumlahController,
                      onChanged: (String value) {
                        try {
                          double harga = double.parse(_hargaController.text);
                          int jumlah = int.parse(_jumlahController.text);
                          double total = harga * jumlah;
                          _totalController.text = total.toString();
                        } catch (e) {
                          _totalController.text = '';
                        }
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Total',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'CUSTOMER',
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
                      'Kode',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Kode',
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'Nama',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _namaController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Nama',
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      'nomor telepon',
                      style: TextStyle(
                        color: const Color(0xFF505F98),
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _nomorTeleponController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'nomor telepon',
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
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await DatabaseHelper()
                                .insertTransaction(TransactionModel(
                              nomor: _nomorController.text,
                              date: _dateController.text,
                              kode: _kodeController.text,
                              nama: _namaController.text,
                              nomorTelepon: _nomorTeleponController.text,
                              namaBarang: selectedBarang,
                              hargaBarang: double.parse(_hargaController.text),
                              jumlahBarang: int.parse(_jumlahController.text),
                              total: double.parse(_totalController.text),
                            ));

                            print('Data berhasil disimpan!');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
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
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
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
}
