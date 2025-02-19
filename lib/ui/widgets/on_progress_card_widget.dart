import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../config/app_colors.dart';

class OnProgressCardWidget extends StatelessWidget {
  OnProgressCardWidget({super.key});
  final fakeDateTime = DateFormat('EEEE, dd MMMM yyyy')
      .format(faker.date.dateTimeBetween(DateTime(2025, 1, 1), DateTime.now()));
  final fakeImage = "https://picsum.photos/seed/picsum/200/300";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 8,
            color: AppColors.yellow,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Design UI Todo App",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          fakeDateTime,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(fakeImage),
                      backgroundColor: AppColors.green,
                    )
                  ],
                ),
                Divider(height: 42),
                Text(
                  "Description :",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  faker.lorem.sentence(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User :",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          faker.person.name(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "On Progress",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    )
                        .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true))
                        .fadeOut(duration: Duration(seconds: 2))
                  ],
                ),
                SizedBox(height: 12)
              ],
            ),
          )
        ],
      ),
    );
  }
}
