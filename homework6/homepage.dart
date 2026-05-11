import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud/tambahdata.dart';
import 'package:flutter_crud/editdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool isLoading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.0.110/flutterapi/conn.php"),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _listdata = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print("ERROR : $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _deletedata(String id) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.0.110/flutterapi/delete.php"),
        body: {"nisn": id},
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _listdata.isEmpty
              ? const Center(
                  child: Text("Tidak ada data"),
                )
              : ListView.builder(
                  itemCount: _listdata.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDataPage(
                                ListData: {
                                  "id": _listdata[index]['id'],
                                  "nisn": _listdata[index]['nisn'],
                                  "nama": _listdata[index]['nama'],
                                  "alamat": _listdata[index]['alamat'],
                                },
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(_listdata[index]['nama']),
                          subtitle: Text(_listdata[index]['alamat']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      "Yakin ingin menghapus data ${_listdata[index]['nama']}?",
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          bool success =
                                              await _deletedata(
                                            _listdata[index]['nisn'],
                                          );

                                          if (!mounted) return;

                                          Navigator.pop(context);

                                          if (success) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Data berhasil dihapus",
                                                ),
                                              ),
                                            );

                                            _getdata();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Gagal menghapus data",
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text("Ya"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Tidak"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahData(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
