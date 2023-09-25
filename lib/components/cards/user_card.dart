import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String cardNum;
  final String type;
  final String cardHolder;
  final String expMonth;
  final String expYear;
  final String service;

  const UserCard(
      {super.key,
      required this.cardNum,
      required this.type,
      required this.cardHolder,
      required this.expMonth,
      required this.expYear,
      required this.service});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(20),
      width: 300,
      height: 200,
      decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(
                  "assets/$service.png",
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                height: 40,
                child: Image.asset("assets/chip.png"),
              ),
              Text(cardNum,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("EXP: $expMonth/$expYear",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 260,
                child: Text(cardHolder,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
