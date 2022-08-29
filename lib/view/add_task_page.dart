import 'package:flutter/material.dart';
import 'package:memo_app/component/card_button.dart';
import 'package:memo_app/view/home_page.dart';
import 'package:memo_app/utils/custom_page_route.dart';

class AddTaskPage extends StatefulWidget {
  static String id = 'add_task_page';

  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, AddTaskPage.id);
                  Navigator.of(context).pop(CustomPageRoute(
                    const HomePage(),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50.0,
                    horizontal: 50.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 5,
                        child: TextField(
                          autofocus: true,
                          maxLines: null,
                          minLines: 10,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'メモを入力してね',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 15.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: CardButton(
                          color: Colors.blue,
                          press: () {
                            Navigator.of(context).pop(CustomPageRoute(
                              const HomePage(),
                            ));
                          },
                          icon: Icons.check,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
