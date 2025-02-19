import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo/config/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo app"),
        actions: [
          IconButton.outlined(
            onPressed: () {},
            icon: Icon(Icons.calendar_month),
            style: IconButton.styleFrom(
              side: BorderSide(width: 0.3, color: Colors.grey),
            ),
          ),
          SizedBox(width: 4),
          IconButton.outlined(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            style: IconButton.styleFrom(
              side: BorderSide(width: 0.3, color: Colors.grey),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildHorizontalOnProgressCard(),
            _buildTitle(
              title: "Completed",
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
            _buildListCompletedCard()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
        label: Text("Create New"),
        icon: Icon(Icons.add),
      ),
    );
  }

  ListView _buildListCompletedCard() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildCompletedCard();
      },
      itemCount: 5,
      shrinkWrap: true,
      primary: false,
    );
  }

  SizedBox _buildHorizontalOnProgressCard() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _buildOnProgressCard();
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Container _buildCompletedCard() {
    return Container(
      height: 130,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Container(
            width: 12,
            color: AppColors.pink,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Meeting with client",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Lorem ipsum",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Today",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 8)),
                        TextSpan(
                          text: "11:25 PM",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildTitle({
    String title = "On Progress",
    int? count,
    VoidCallback? onViewMoreTapped,
    EdgeInsets? padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                WidgetSpan(child: SizedBox(width: 4)),
                if (count != null)
                  TextSpan(
                    text: "($count)",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: onViewMoreTapped,
            child: Text(
              "View More",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Container _buildOnProgressCard() {
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
                          "Friday, 08 July 2022",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                          "https://picsum.photos/seed/picsum/200/300"),
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
                  "Design a simple home pages with clean layout and color based on guidelines based on guidelines",
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
                          "123hasd8123",
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
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
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "On Progress",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    )
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
