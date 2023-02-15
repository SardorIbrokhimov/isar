import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:test1/pages/user.dart';

void main() async {
  final isar = await Isar.open([UserSchema]);

  runApp(MaterialApp(
    home: HomePage(isar),
  ));
}

class HomePage extends StatefulWidget {
  final Isar isar;

  const HomePage(this.isar, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Isar get isar => widget.isar;

  final newUser = User()
    ..id = 1
    ..name = 'Jane Doe'
    ..age = 36;

  void write() async {
    await isar.writeTxn(() async {
      await isar.users.put(newUser); // insert & update
    });
  }

  void read() async {
    final existingUser = await isar.users.get(newUser.id); // get
    print(existingUser?.id);
    print(existingUser?.name);
    print(existingUser?.age);
  }

  void delete() async {
    await isar.writeTxn(() async {
      await isar.users.delete(1); // delete
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => write(), child: Text("Write")),
            ElevatedButton(onPressed: () => read(), child: Text("Read")),
            ElevatedButton(onPressed: () => delete(), child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
