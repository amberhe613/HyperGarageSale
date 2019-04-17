import 'package:flutter/material.dart';

class NewPostActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter title of the item'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter price'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter description of the item',
                contentPadding: const EdgeInsets.only(top:10.0, bottom: 400.0),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                    children: <Widget>[
                      Container(width: 10.0),
                      Expanded(child: Text('')),
                      RaisedButton(
                          onPressed: () {
                            final snackBar = SnackBar(
                              content: Text('A new post has been added!'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change!
                                },
                              ),
                            );

                            // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                          child: Text('POST')
                      )
                    ]
                )
            )
          ]
      ),
    );
  }
}