import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/admin/provider/admin_provider.dart';
import 'package:student_project/gallery/provider/gallery_provider.dart';

import '../../utils/constants.dart';

class GalleryPage extends ConsumerWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
        ),
        body: state.when(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Row(
                    children: [
                      10.width,
                      CachedNetworkImage(
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        imageUrl: data[index].link!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      10.width,
                      Text(data[index].name!.split(".").first)
                    ],
                  );
                }),
            error: (_, __) => Center(child: const Text('An error occurred')),
            loading: () => Center(child: const CircularProgressIndicator())));
  }
}
