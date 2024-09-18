import 'package:blog_app/model/user_model.dart';
import 'package:flutter/material.dart';

class UserItemView extends StatelessWidget {
  final UserModel user;
   UserItemView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              user.avatar,
              width: 80,
              height: 80,
            ),
          ),
          Text(
            user.firstName,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
