import 'package:flutter/material.dart';

class CrurncyCard extends StatelessWidget {
  final String currency;
  final String credits;
  final String currencyAbbreviation;
  final IconData icon;
  final bool isInverted;
  final int cardLenght;

  const CrurncyCard(
      {super.key,
      required this.currency,
      required this.credits,
      required this.currencyAbbreviation,
      required this.icon,
      required this.isInverted,
      required this.cardLenght});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -cardLenght * 20),
      child: Container(
        clipBehavior: Clip.hardEdge, // 박스를 넘어선 엑스트라 부분을 어떻게 해야할지
        decoration: BoxDecoration(
            color: isInverted ? const Color(0xfff2b33a) : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency,
                    style: TextStyle(
                        fontSize: 20,
                        color: isInverted ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        credits,
                        style: TextStyle(
                            fontSize: 20,
                            color: isInverted ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      Text(
                        currencyAbbreviation,
                        style: TextStyle(
                          fontSize: 15,
                          color: isInverted
                              ? Colors.black.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 2.2,
              child: Transform.translate(
                offset: const Offset(-5, 8),
                child: Icon(
                  icon,
                  color: isInverted ? Colors.black : Colors.white,
                  size: 88,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
