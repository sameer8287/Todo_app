import 'package:flutter/material.dart';
import 'package:hiivee_tutorial/boxs/boxes.dart';
import 'package:hiivee_tutorial/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? xyz;
  TextEditingController titlecont = TextEditingController();
  TextEditingController descriptioncont = TextEditingController();

  void delete(DataModel dataModel) async {
    await dataModel.delete();
  }

  Future<void> editDailog(
      DataModel dataModel, String title, String description) async {
    titlecont.text = title;
    descriptioncont.text = description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [Text('Edit Details')],
                  ),
                  TextFormField(
                    controller: titlecont,
                    decoration: InputDecoration(
                        label: Text('Title'), border: OutlineInputBorder()),
                  ),
                  TextFormField(
                    controller: descriptioncont,
                    decoration: InputDecoration(
                        label: Text("Description"),
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              TextButton(
                  onPressed: () {
                    dataModel.title = titlecont.text.toString();
                    dataModel.description = descriptioncont.text.toString();

                    dataModel.save();
                    Navigator.of(context).pop();
                  },
                  child: Text('Edit'))
            ],
          );
        });
  }

  void showdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [Text('Add Details')],
                  ),
                  TextFormField(
                    controller: titlecont,
                    decoration: InputDecoration(
                        label: Text('Title'), border: OutlineInputBorder()),
                  ),
                  TextFormField(
                    controller: descriptioncont,
                    decoration: InputDecoration(
                        label: Text("Description"),
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              TextButton(
                  onPressed: () {
                    final data = DataModel(
                        title: titlecont.text.toString(),
                        description: descriptioncont.text.toString());

                    final box = Boxes.getData();
                    box.add(data);
                    data.save();
                    titlecont.clear();
                    descriptioncont.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Save'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO APP'),
      ),
      body: ValueListenableBuilder<Box<DataModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (BuildContext context, dynamic value, Widget? child) {
          var data = value.values.toList().cast<DataModel>();
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data[index].title.toString()),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    delete(data[index]);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    editDailog(
                                        data[index],
                                        data[index].title.toString(),
                                        data[index].description.toString());
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Text(data[index].description)
                    ],
                  ),
                ),
              );
              // ListTile(
              //   title: Text(data[index].title.toString()),
              //   subtitle: Text(data[index].description.toString()),
              // );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showdialog(context);
          // var box = await Hive.openBox('container');

          // box.put('name', 'Hamdan');

          // // setState(() {
          // //   xyz = box.get('name');
          // // });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
