import 'package:flutter/material.dart';
import 'package:user/lib.dart';


///For two services
class Libra extends StatefulWidget {
  final List<int> selectedService;
  const Libra({super.key, this.selectedService = const []});

  @override
  State<Libra> createState() => _LibraState();
}

class _LibraState extends State<Libra> {
  List<dynamic> services = libraAquaServices;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap:  () {
              int maxCount = 2;
              if(widget.selectedService.contains(index)) {
                setState(() => widget.selectedService.remove(index));
              } else if(widget.selectedService.length == maxCount) {
                return;
              } else {
                setState(() => widget.selectedService.add(index));
              }
            },
            child: AnimatedContainer(
              margin: const EdgeInsets.symmetric(vertical: 5),
              duration: const Duration(milliseconds: 800),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
                border: Border.all(
                  color: widget.selectedService.contains(index) ? Colors.blue : Colors.white.withOpacity(0),
                  width: 2
                ),
                boxShadow: [
                  widget.selectedService.contains(index)
                  ? BoxShadow(color: Colors.blue.shade400, offset: const Offset(0, 1), blurRadius: 5)
                  : BoxShadow(color: Colors.grey.shade400, offset: const Offset(0, 1), blurRadius: 5)
                ]
              ),
              child: Row(
                children: [
                  widget.selectedService.contains(index)
                  ? Image.asset(services[index][0], width: 50,)
                  : Image.asset( services[index][1], width: 50,),
                  const SizedBox(width: 30,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.selectedService.contains(index)
                        ? const SText(text: "You chose well", color: SColors.green)
                        : Container(),
                        SText(
                          text: services[index][2],
                          color: Colors.grey.shade800,
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                        // Text(
                        //   services[index][2],
                        //   style: TextStyle(color: Colors.grey.shade800, fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                      ],
                    ),
                  ),
                  widget.selectedService.contains(index)
                  ? const Icon(Icons.check_circle, color: Colors.blue)
                  : Container()
                ],
              ),
            ),
          );
        })
      ),
    );
  }
}