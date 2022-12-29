import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'package:uts/1_onlineshop_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    return _database = await _initializeDb();
  }

  static const String _tableName = 'Onlineshops';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'onlineshop_db.db'),
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_tableName (idHp INTEGER PRIMARY KEY, merek TEXT, spesifikasi TEXT, harga TEXT)''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertOnlineshop(Onlineshop onlineshop) async {
    final Database db = await database;
    await db.insert(
      _tableName,
      onlineshop.toMap(),
    );
  }

  Future<List<Onlineshop>> getOnlineshops() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);

    return result.map((res) => Onlineshop.fromMap(res)).toList();
  }

  Future<void> deleteOnlineshop(int idHp) async {
    final Database db = await database;
    await db.delete(_tableName, where: 'idHp = ?', whereArgs: [idHp]);
  }

  Future<void> updateOnlineshop(Onlineshop onlineshop) async {
    final Database db = await database;
    await db.update(_tableName, onlineshop.toMap(),
        where: 'idHp = ?', whereArgs: [onlineshop.idHp]);
  }
}

class DbProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;
  List<Onlineshop> _onlineshops = [];
  List<Onlineshop> get onlineshops => _onlineshops;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllOnlineshops();
  }

  void _getAllOnlineshops() async {
    _onlineshops = await _dbHelper.getOnlineshops();
    notifyListeners();
  }

  Future<void> addOnlineshop(Onlineshop onlineshop) async {
    await _dbHelper.insertOnlineshop(onlineshop);
    _getAllOnlineshops();
  }

  Future<void> delOnlineshop(Onlineshop onlineshop, int position) async {
    await _dbHelper.deleteOnlineshop(onlineshop.idHp!);
    print(onlineshop.harga);
    _getAllOnlineshops();
  }

  Future<void> upOnlineshop(Onlineshop onlineshop) async {
    await _dbHelper.updateOnlineshop(onlineshop);
    _getAllOnlineshops();
  }
}

class FormCreate extends StatefulWidget {
  final Onlineshop? onlineshop;

  const FormCreate({Key? key, this.onlineshop}) : super(key: key);

  @override
  State<FormCreate> createState() => _FormCreateState();
}

class _FormCreateState extends State<FormCreate> {
  TextEditingController? merek;
  TextEditingController? spesifikasi;
  TextEditingController? harga;
  @override
  void initState() {
    merek = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.merek);
    spesifikasi = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.spesifikasi);
    harga = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.harga);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: merek,
              decoration: const InputDecoration(
                labelText: 'Merek',
              ),
            ),
            TextField(
              controller: spesifikasi,
              decoration: const InputDecoration(
                labelText: 'Spesifikasi',
              ),
            ),
            TextField(
              controller: harga,
              decoration: const InputDecoration(
                labelText: 'Harga',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () async {
                  final onlineshop = Onlineshop(
                    merek: merek!.text,
                    spesifikasi: spesifikasi!.text,
                    harga: harga!.text,
                  );
                  Provider.of<DbProvider>(context, listen: false)
                      .addOnlineshop(onlineshop);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    merek!.dispose();
    spesifikasi!.dispose();
    harga!.dispose();
    super.dispose();
  }
}

class FormUpdate extends StatefulWidget {
  final Onlineshop? onlineshop;

  const FormUpdate({Key? key, this.onlineshop}) : super(key: key);

  @override
  State<FormUpdate> createState() => _FormUpdateState();
}

class _FormUpdateState extends State<FormUpdate> {
  TextEditingController? merek;
  TextEditingController? spesifikasi;
  TextEditingController? harga;

  @override
  void initState() {
    merek = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.merek);
    spesifikasi = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.spesifikasi);
    harga = TextEditingController(
        text: widget.onlineshop == null ? '' : widget.onlineshop!.harga);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: merek,
              decoration: const InputDecoration(
                labelText: 'Merek',
              ),
            ),
            TextField(
              controller: spesifikasi,
              decoration: const InputDecoration(
                labelText: 'Spesifikasi',
              ),
            ),
            TextField(
              controller: harga,
              decoration: const InputDecoration(
                labelText: 'Harga',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () async {
                  final onlineshop = Onlineshop(
                    idHp: widget.onlineshop!.idHp!,
                    merek: merek!.text,
                    spesifikasi: spesifikasi!.text,
                    harga: harga!.text,
                  );
                  Provider.of<DbProvider>(context, listen: false)
                      .upOnlineshop(onlineshop);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    merek!.dispose();
    spesifikasi!.dispose();
    harga!.dispose();
    super.dispose();
  }
}
