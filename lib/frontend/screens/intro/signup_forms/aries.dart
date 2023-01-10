import 'package:flutter/material.dart';
import 'package:user/lib.dart';

///For one service
class Aries extends StatefulWidget {
  int selected;
  Aries({super.key, required this.selected});

  @override
  State<Aries> createState() => _AriesState();
}

class _AriesState extends State<Aries> {
  final services = ariesServices;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap:  () => setState(() => widget.selected = index),
              child: AnimatedContainer(
                margin: const EdgeInsets.symmetric(vertical: 5),
                duration: const Duration(milliseconds: 800),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  border: Border.all(
                    color: widget.selected == index ? Colors.blue : Colors.white.withOpacity(0),
                    width: 2
                  ),
                  boxShadow: [
                    widget.selected == index
                    ? BoxShadow(color: Colors.blue.shade400, offset: const Offset(0, 1), blurRadius: 5)
                    : BoxShadow(color: Colors.grey.shade400, offset: const Offset(0, 1), blurRadius: 5)
                  ]
                ),
                child: Row(
                  children: [
                    widget.selected == index
                    ? Image.asset(services[index]["image"], width: 50,)
                    : Image.asset(services[index]["selected_image"], width: 50,),
                    const SizedBox(width: 30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.selected == index
                          ? const SText(text: "You chose well", color: SColors.green)
                          : Container(),
                          SText(
                            text: services[index]["name"],
                            color: Colors.grey.shade800,
                            weight: FontWeight.bold,
                            size: 16,
                          ),
                          // Text(
                          //   services[index]["name"],
                          //   style: TextStyle(color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),
                    widget.selected == index
                    ? const Icon(Icons.check_circle, color: Colors.blue)
                    : Container()
                  ],
                ),
              ),
            );
          }
        )
      ),
    );
  }
}