import 'package:flutter/material.dart';
import 'package:handshake/screen/scan_host_tab.dart';

import '../constants.dart';
import 'my_code_tab.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  _QrCodeScreen createState() => _QrCodeScreen();
}

class _QrCodeScreen extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).viewPadding.top;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          color: const Color(0xFFEFF5F4),
          child: Column(
            children: [
              Container(
                color: const Color.fromRGBO(31, 36, 41, 1),
                child: Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_left,
                                color: kwhite,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "QR Code",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(0),
                        child: TabBar(
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Colors.white54,
                          unselectedLabelStyle: TextStyle(
                            fontSize: 18,
                          ),
                          labelColor: Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 18,
                          ),
                          indicatorColor: kblue,
                          tabs: [
                            Tab(
                              child: Text(
                                "SCAN HOST",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "MY CODE",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ScanHostTab(),
                    MyCodeTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
