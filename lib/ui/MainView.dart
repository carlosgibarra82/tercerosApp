import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tercerosApp/core/models/Nits.dart';
import 'package:tercerosApp/core/services/api.dart';
import 'package:tercerosApp/core/services/app_state.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  MainView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainViewState createState() => new _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController editingController = TextEditingController();
  Future<Nit> futureNit;
  List<Nit> duplicateItems;
  var items = List<Nit>();
  AppState appState;

  @override
  void initState() {
    load();
    appState = Provider.of<AppState>(context, listen: false);
    super.initState();
  }

  void load() async {
    duplicateItems = await fetchNits();
    setState(() {
      items.clear();
      items.addAll(duplicateItems);
    });
  }

  void filterSearchResults(String query) {
    List<Nit> dummySearchList = List<Nit>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<Nit> dummyListData = List<Nit>();
      dummySearchList.forEach((item) {
        if (item.ape1.contains(query) ||
            item.ape2.contains(query) ||
            item.nom1.contains(query) ||
            item.nom2.contains(query) ||
            item.nom.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        leading: null,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Búsqueda",
                          hintText: "Búsqueda",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      height: 55,
                      child: RaisedButton(
                        child: Center(
                          child: Icon(
                            Icons.plus_one,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          appState.setId(null);
                          Navigator.pushNamed(context, 'detail');
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        appState.setId('${items[index].id}');
                        Navigator.pushNamed(context, 'detail');
                      },
                      title: Row(children: <Widget>[
                        Expanded(child: Text('${items[index].nIde}')),
                        Expanded(child: Text('${items[index].ide}')),
                        Expanded(
                          child: Text(
                              '${items[index].ape1 ?? ''} ${items[index].ape2 ?? ''} ${items[index].nom1 ?? ''} ${items[index].nom2 ?? ''} ${items[index].nom ?? ''}'),
                        ),
                      ]),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
