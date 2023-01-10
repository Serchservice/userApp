import 'package:flutter/material.dart';
import 'package:user/lib.dart';

///For three services
class NewAqua extends StatefulWidget {
  final List<SelectedServiceModel> model;
  const NewAqua({super.key, this.model = const [],});

  @override
  State<NewAqua> createState() => _NewAquaState();
}

class _NewAquaState extends State<NewAqua> {
  List<dynamic> services = libraAquaServices;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: ((context, index) {
          // var selected = widget.model.where((element) => element == services[index][2]);
          // var selected = widget.model.contains(services[index][2]);
          // widget.model.map((e) => e.service.toString()).contains(services[index][2].toString())
          // widget.model.map((e) => e.service.toString()).any((element) => element == services[index][2].toString());
          var service = services[index][2];
          newword(){
            if(widget.model.any((element) => element.service == services[index][2].toString())){
              debugShow(service);
              return true;
            } else {
              debugShow(service);
              return false;
            }
          }
          bool newSelect = widget.model.any((element) => element.service == services[index][2].toString());
          debugShow("Oh: ${newword()}");
          return GestureDetector(
            onTap:  () {
              if(newSelect){
                setState(() => newSelect = !newSelect);
                debugShow(newSelect);
              }
              // int maxCount = 3;
              // if(widget.model.contains(index)) {
              //   setState(() => widget.model.remove(index));
              // } else if(widget.model.length == maxCount) {
              //   return;
              // } else {
              //   setState(() {widget.model.add(index);});
              // }
            },
            child: AnimatedContainer(
              margin: const EdgeInsets.symmetric(vertical: 5),
              duration: const Duration(milliseconds: 800),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
                border: Border.all(
                  color: newSelect ? Colors.blue : Colors.white.withOpacity(0),
                  width: 2
                ),
                boxShadow: [
                  newSelect
                  ? BoxShadow(color: Colors.blue.shade400, offset: const Offset(0, 1), blurRadius: 5)
                  : BoxShadow(color: Colors.grey.shade400, offset: const Offset(0, 1), blurRadius: 5)
                ]
              ),
              child: Row(
                children: [
                  newSelect
                  ? Image.asset(services[index][0], width: 50,)
                  : Image.asset( services[index][1], width: 50,),
                  const SizedBox(width: 30,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        newSelect
                        ? const SText(text: "You chose well", color: SColors.green)
                        : Container(),
                        SText(
                          text: services[index][2],
                          color: Colors.grey.shade800,
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  newSelect
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