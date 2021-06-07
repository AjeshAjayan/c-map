import 'package:flutter/material.dart';
import 'package:map_poc/models/index.dart';
import 'package:map_poc/services/infrastucture.dart';
import 'package:map_poc/views/home.dart';

class InfrastructureList extends StatefulWidget {
  const InfrastructureList();

  @override
  _InfrastructureListState createState() => _InfrastructureListState();
}

class _InfrastructureListState extends State<InfrastructureList> {

  Future<List<dynamic>> getAllInfrastructure() async {
    return await InfrastructureService.getInfrastructure();
  }

  Future<dynamic> saveInfra(String title) async {
    return await InfrastructureService.addInfrastructure(title);
  }

  @override
  Widget build(BuildContext context) {

    bool refreshed = false;

    return Scaffold(
        appBar: AppBar(
          title: Text('Infrastructures'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final controller = new TextEditingController();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Give a title to infrastructure'),
                    content: TextFormField(
                      controller: controller,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          // call api
                          int id = await saveInfra(controller.text);
                          print(id);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HomeView(id)
                            )
                          );
                        },
                        child: Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('cancel'),
                      )
                    ],
                  )
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getAllInfrastructure(),
          builder: (_, snapshot) {
            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  final response = await getAllInfrastructure();
                  setState(() {
                    refreshed = !refreshed;
                  });
                },
                child: ListView(
                  children: snapshot.data?.map((e) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => HomeView(int.parse(e['id'])))
                      );
                    },
                    child: Card(
                      child: Container(
                        height: 50,
                          child: Center(child: Text(e['title']))
                      ),
                    ),
                  )).toList() ?? [],
                ),
              );
            }

            if(snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if(!snapshot.hasData) {
              return Center(child: Text('No records found'),);
            }
            return Center(child: CircularProgressIndicator());
          },
        )
    );
  }
}
