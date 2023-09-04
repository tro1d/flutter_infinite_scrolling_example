import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/screens/basic/widgets/picture_card_horizontal_basic.dart';
import 'package:infinite_scrolling_example/screens/ui/infinite_vertical.dart';
import 'package:infinite_scrolling_example/services/basic_services.dart';

class InfiniteLocalScreenBasic extends StatefulWidget {
  const InfiniteLocalScreenBasic({super.key});

  @override
  State<InfiniteLocalScreenBasic> createState() => _InfiniteLocalScreenBasicState();
}

class _InfiniteLocalScreenBasicState extends State<InfiniteLocalScreenBasic> {
  final AppServicesBasic servicesBasic = AppServicesBasic();

  @override
  void initState() {
    super.initState();
    servicesBasic.scrollListener();
  }

  @override
  void dispose() {
    servicesBasic.scrollPicrtureCTRL.dispose();
    servicesBasic.scrollCTRL.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scrolling (Basic)'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InfiniteLocalScreen(),
              ),
            ),
            icon: const Icon(Icons.switch_access_shortcut),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: servicesBasic,
        builder: (context, child) => ListView(
          controller: servicesBasic.scrollCTRL,
          children: <Widget>[
            ScrollCardHorizontal(servicesBasic: servicesBasic),
            const Divider(),
            ...List.generate(
              servicesBasic.postList.length + 1,
              (index) {
                if (index < servicesBasic.postList.length) {
                  return ListTile(
                    title: Text(servicesBasic.postList[index]),
                    shape: const Border(bottom: BorderSide()),
                  );
                }
                if (servicesBasic.postList.isEmpty && servicesBasic.hasLimitPost) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text('Posts is Empty'),
                    ),
                  );
                } else {
                  if (!servicesBasic.hasLimitPost) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: OutlinedButton.icon(
                          icon: const Text('Back to Top'),
                          label: const Icon(Icons.arrow_upward),
                          onPressed: () {
                            servicesBasic.reloadPost();
                            servicesBasic.scrollCTRL.position.moveTo(
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
          ],
        ),
      ),
    );
  }
}
