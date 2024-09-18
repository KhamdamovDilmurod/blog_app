import 'dart:ui';

import 'package:blog_app/utils/colors.dart';
import 'package:flutter/material.dart';

Future<void> showError(BuildContext context, String message, {Function? pressOk}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: kPrimaryColor.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withAlpha(500),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      gradient: const LinearGradient(
                          colors: [Colors.black45, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outlined,
                            size: 36,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Xatolik !!!",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(message,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                if (pressOk != null) {
                                  pressOk();
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                "Ha",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}