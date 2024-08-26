import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/provider/whist_list_provider.dart';
import 'package:provider/provider.dart';


class WhistListScreen extends StatelessWidget {
  const WhistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WhistListProvider>(builder: (_,provider,__)=>Scaffold(
        appBar: AppBar(
          title: const Text('WhistList'),
        ),
        body:  ListView.builder(
          itemCount:provider.whistList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      height: 110,
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color:Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              width: 100,
                              height: 110,
                              child: CachedNetworkImage(imageUrl: '${provider.whistList[index].image}',width: 100,height: 120,)),
                          const SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text('${provider.whistList[index].title}',style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),overflow: TextOverflow.ellipsis,maxLines: 1,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 23,
                    right: 25,
                    child: InkWell(
                        onTap: (){
                        },
                        child:Image.asset('assets/images/delete1.png',width: 20,height: 20,))),
              ],
            );
          },
        )
    ));
  }
}