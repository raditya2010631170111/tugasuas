import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts/1_onlineshop_model.dart';
import 'package:uts/2_database.dart';
import 'package:uts/4_onlineshop_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? merek = prefs.getString('merekHandphone');

  runApp(MyApp(merek: merek));
}

class MyApp extends StatelessWidget {
  final String? merek;
  const MyApp({super.key, required this.merek});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DbProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: username == null ? const SplashScreen() : const OnlineshopList(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(23, 23, 322, 12),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _merek = TextEditingController();
  TextEditingController _spesifikasi = TextEditingController();
  TextEditingController _harga = TextEditingController();

  bool passenable = true;

  saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('merekHandphone', _merek.text.toString());
    prefs.setString('spesifikasiHandphone', _spesifikasi.text.toString());
    prefs.setString('hargaHandphone', _harga.text.toString());

    final String? merekHandphone = prefs.getString('merekHandphone');

    if (_merek.text == "" && _spesifikasi.text == "" && _harga.text == "") {
      print("Gagal Isi Form!");
    } else if (_merek.text == "" ||
        _spesifikasi.text == "" ||
        _harga.text == "") {
      print("Gagal Isi Form!");
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnlineshopList()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: const Center(
                        child:
                            Icon(Icons.person, size: 50, color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Isi Data",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _merek,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          size: 40,
                        ),
                        hintText: "Masukkan Merek Handhpne",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Merek",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _spesifikasi,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          size: 40,
                        ),
                        hintText: "Masukkan Spek Handhpne",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Spesifikasi",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: passenable,
                    controller: _harga,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 40,
                      ),
                      hintText: "Masukkan Harga Handphone",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Harga",
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            if (passenable) {
                              passenable = false;
                            } else {
                              passenable = true;
                            }
                          });
                        },
                        icon: Icon(passenable == true
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.green,
                    elevation: 5,
                    child: SizedBox(
                      height: 50,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: saveData,
                        child: const Center(
                          child: Text(
                            "Masuk",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

String? username = '';

class OnlineshopList extends StatefulWidget {
  const OnlineshopList({super.key});

  @override
  State<OnlineshopList> createState() => _OnlineshopListState();
}

class _OnlineshopListState extends State<OnlineshopList> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('usernameUser') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello there $username'),
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove("usernameUser");
                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          final onlineshops = provider.onlineshops;

          return ListView.builder(
            itemCount: onlineshops.length,
            itemBuilder: (context, index) {
              final onlineshop = onlineshops[index];
              return Dismissible(
                key: Key(onlineshop.idHp.toString()),
                background: Container(color: Colors.pink),
                onDismissed: (direction) {
                  // ignore: todo
                  // TODO : Kode untuk menghapus note
                },
                child: Card(
                  child: ListTile(
                    title: Text(onlineshop.merek),
                    subtitle: Text(onlineshop.spesifikasi),
                    onTap: () async {
                      // ignore: todo
                      // TODO : Kode untuk mendapatkan note yang dipilih dan dikirimkan ke NoteAddUpdatePage
                    },
                    trailing: FittedBox(
                      fit: BoxFit.fill,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormUpdate(
                                            onlineshop: onlineshop)));
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                AlertDialog delete = AlertDialog(
                                  title: const Text("Information"),
                                  content: SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Text(
                                            "Are you sure to delete this data ${onlineshop.merek}")
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Provider.of<DbProvider>(context,
                                                  listen: false)
                                              .delOnlineshop(onlineshop, index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Yes")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No"))
                                  ],
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) => delete);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        //detail
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OnlineshopDetail(onlineshop)));
                      },
                      icon: Icon(Icons.visibility),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormCreate()));
        },
      ),
    );
  }
}
