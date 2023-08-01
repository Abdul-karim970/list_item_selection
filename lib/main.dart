import 'package:flutter/material.dart';
import 'package:flutter_/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const pageTitle = 'Selectable List';
  static const selectedText = 'Selected';
  int selectedItemCount = 0;
  bool showSelectedItemCount = false;
  List<Item> itemDataList = [for (int i = 1; i <= 50; i++) Item('Item $i', i)];
  String title = pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          title,
          style: TextStyle(color: Colors.blueGrey.shade100),
        ),
        actions: [
          showSelectedItemCount
              ? Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    selectedItemCount.toString(),
                    style: TextStyle(
                        color: Colors.blueGrey.shade100, fontSize: 20),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notification_important_rounded,
                        color: Colors.blueGrey.shade100,
                      )),
                )
        ],
      ),
      body: Center(
          child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: itemDataList.length,
        itemExtent: 80,
        itemBuilder: selectableItemBuilder,
      )),
    );
  }

  Widget? selectableItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (itemDataList.every((element) => element.isSelected == false)) {
            itemDataList[index].isSelected = true;
            showSelectedItemCount = true;
            selectedItemCount++;
            title = selectedText;
          }
        });
      },
      onTap: () {
        setState(() {
          if (itemDataList[index].isSelected == false &&
              itemDataList.any((element) => element.isSelected == true)) {
            itemDataList[index].isSelected = true;
            showSelectedItemCount = true;
            selectedItemCount++;
            title = selectedText;
          } else {
            itemDataList[index].isSelected = false;
            selectedItemCount--;
            if (selectedItemCount <= 0) {
              showSelectedItemCount = false;
              title = pageTitle;
            }
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: itemDataList[index].isSelected
                      ? Colors.transparent
                      : Colors.black38,
                  blurRadius: 5,
                  offset: const Offset(3, 3))
            ],
            borderRadius: BorderRadius.circular(15),
            color: itemDataList[index].isSelected
                ? Colors.blueGrey.shade200
                : Colors.blueGrey.shade100,
          ),
          child: ListTile(
            title: Text(
              itemDataList[index].data,
              style: const TextStyle(color: Colors.blueGrey),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                itemDataList[index].dataCount.toString(),
                style: TextStyle(color: Colors.blueGrey.shade100),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
