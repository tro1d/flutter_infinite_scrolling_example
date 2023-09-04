import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/services/basic_services.dart';

class ScrollCardHorizontal extends StatelessWidget {
  const ScrollCardHorizontal({Key? key, required this.servicesBasic}) : super(key: key);

  final AppServicesBasic servicesBasic;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 160),
      child: ListenableBuilder(
        listenable: servicesBasic,
        builder: (context, child) => ListView.builder(
          controller: servicesBasic.scrollPicrtureCTRL,
          scrollDirection: Axis.horizontal,
          itemCount: servicesBasic.pictureList.length + 1,
          itemBuilder: (context, index) {
            if (index < servicesBasic.pictureList.length) {
              return pictureCard(
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    servicesBasic.pictureList[index],
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Colors.green.shade300,
              );
            }
            if (servicesBasic.pictureList.isEmpty && servicesBasic.hasLimitPicture) {
              return pictureCard(
                const Center(child: Text('Picture is Empty')),
                Colors.transparent,
              );
            } else {
              if (!servicesBasic.hasLimitPicture) {
                return pictureCard(
                  const Center(child: CircularProgressIndicator()),
                  Colors.green.shade300,
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: OutlinedButton.icon(
                      icon: const Text('Reload'),
                      label: const Icon(Icons.refresh),
                      onPressed: () {
                        servicesBasic.reloadPicture();
                        servicesBasic.scrollPicrtureCTRL.position.moveTo(
                          1,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInSine,
                        );
                      },
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget pictureCard(Widget child, Color color) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 160, maxWidth: 160),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(offset: Offset(2.0, 2.0), blurRadius: 2.0, color: Colors.black38),
        ],
      ),
      child: child,
    );
  }
}
