import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/res/components/carousel_slider/carousel_slider.dart';
import 'package:social_media_app/res/routes/route_names.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final dashboard = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    PostModel post = widget.postModel;
    return Obx(
      () => Card(
        color: Get.isDarkMode ? AppColors.blueGrey : Colors.white,
        shadowColor: Color.fromARGB(255, 86, 86, 86),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            ListTile(
              title: Text(dashboard.getUser(post.uid).username),
              subtitle: Text(dashboard.postTime(post.postTime)),
              leading: GestureDetector(
                onTap: () {
                  dashboard.currUser.value = dashboard.getUser(post.uid);
                  Get.toNamed(RouteNames.usersProfile);
                },
                child: CircleAvatar(
                  radius: 20,
                  foregroundImage: CachedNetworkImageProvider(
                      dashboard.getUser(post.uid).profImage),
                ),
              ),
              trailing: PopupMenuButton<int>(
                itemBuilder: (context) => [
                  // PopupMenuItem 1
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.not_interested),
                        SizedBox(width: 10),
                        Text("Not Interested")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 10),
                        Text("Edit")
                      ],
                    ),
                  ),
                ],
                offset: Offset(0, 50),
                elevation: 2,
                onSelected: (value) {
                  if (value == 1) {
                    setState(() {
                      dashboard.posts.remove(post);
                    });
                  } else if (value == 2) {
                    dashboard.getImageSize('${'image_path'.tr}${'p5'.tr}');
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.postText.isNotEmpty)
                    Text(
                      post.postText,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  if (post.postImage.isNotEmpty && post.postText.isNotEmpty)
                    const SizedBox(height: 10),
                  if (post.postImage.isNotEmpty)
                    CarouselSlider(images: post.postImage)
                  else
                    Container(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // dashboard.likePost(post.postId, post.likes);
                      if (dashboard.likedPost.contains(post.postId)) {
                        dashboard.likedPost.remove(post.postId);
                        post.likes--;
                      } else {
                        dashboard.likedPost.add(post.postId);
                        post.likes++;
                      }
                    },
                    icon: Icon(
                      dashboard.likedPost.contains(post.postId)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.blue,
                    ),
                  ),
                  Text(post.likes.toString()),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      dashboard.currPost = post;
                      Get.toNamed(RouteNames.postDetailsScreen);
                    },
                    icon: ImageIcon(
                      size: 22,
                      color: AppColors.blue,
                      AssetImage('${'icon_path'.tr}${'comment'.tr}'),
                    ),
                  ),
                  Text(post.postComments.length.toString()),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      post.postImage.isNotEmpty
                          ? Share.shareUri(Uri.parse(post.postImage[0]))
                          : Share.share(post.postText);
                    },
                    icon: ImageIcon(
                      size: 30,
                      color: AppColors.blue,
                      AssetImage('${'icon_path'.tr}${'share'.tr}'),
                    ),
                  ),
                  Text(post.share.toString()),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        dashboard.bookmark(post.postId);
                      });
                    },
                    icon: Icon(
                      dashboard.savedPost.contains(post.postId)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
