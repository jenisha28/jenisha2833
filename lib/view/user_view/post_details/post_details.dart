import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/data/dummy_data/dummy_data.dart';
import 'package:social_media_app/model/post_model/post_model.dart';
import 'package:social_media_app/repository/post_repository/post_repository.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view/user_view/dashboard/post_card.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final dashboard = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    dashboard.sortedComments = dashboard.currPost.postComments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Get.isDarkMode ? AppColors.blue : AppColors.black,
          style: IconButton.styleFrom(
              backgroundColor:
                  Get.isDarkMode ? AppColors.blueGrey : AppColors.white),
        ),
        title: Text(
          "VIEW POST",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Get.isDarkMode ? AppColors.blue : AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => SafeArea(
          child: SizedBox(
            height: ScreenUtils.screenHeight(context),
            width: ScreenUtils.screenWidth(context),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 70),
                    child: Column(
                      children: [
                        PostCard(postModel: dashboard.currPost),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "COMMENTS (${dashboard.currPost.postComments.length})",
                            ),
                            Spacer(),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  if (dashboard.isSorted.value == false) {
                                    dashboard.isSorted.value = true;
                                    dashboard.sortCommentsAsc();
                                  } else {
                                    dashboard.isSorted.value = false;
                                    dashboard.sortCommentsDesc();
                                  }
                                });
                              },
                              style: IconButton.styleFrom(
                                foregroundColor: AppColors.blue,
                              ),
                              iconAlignment: IconAlignment.end,
                              label: Text("Recent"),
                              icon: Icon(
                                dashboard.isSorted.value == true
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                        for (var i in dashboard.sortedComments)
                          Card(
                            color: Get.isDarkMode
                                ? AppColors.blueGrey
                                : Colors.white,
                            shadowColor: Color.fromARGB(255, 86, 86, 86),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    foregroundImage: NetworkImage(
                                        dashboard.getUser(i.uid).profImage),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dashboard.getUser(i.uid).username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        i.cmtText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: dashboard.postTime(i.cmtTime),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: AppColors.grey,
                                                ),
                                          ),
                                          TextSpan(
                                              text: ' • ',
                                              style: TextStyle(
                                                  color: AppColors.grey)),
                                          TextSpan(
                                            text: "${i.likes} likes",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: AppColors.blue,
                                                ),
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (dashboard.likedComments
                                              .contains(i.commentId)) {
                                            dashboard.likedComments
                                                .remove(i.commentId);
                                            i.likes--;
                                            return;
                                          } else {
                                            dashboard.likedComments
                                                .add(i.commentId);
                                            i.likes++;
                                            return;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        dashboard.likedComments
                                                .contains(i.commentId)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.blue,
                                      ))
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    height: 50,
                    width: ScreenUtils.screenWidth(context) * 0.9,
                    child: TextField(
                      controller: dashboard.commentController,
                      style: TextStyle(color: AppColors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.isDarkMode
                                  ? AppColors.blue
                                  : AppColors.white,
                              width: 3,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.isDarkMode
                                  ? AppColors.blue
                                  : AppColors.white,
                              width: 3,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        filled: true,
                        fillColor:
                            Get.isDarkMode ? AppColors.blue : AppColors.white,
                        hintText: "Type your comment here..",
                        hintStyle: TextStyle(
                            color: Get.isDarkMode
                                ? AppColors.lightBlack
                                : AppColors.grey),
                        suffixIconColor:
                            Get.isDarkMode ? AppColors.black : AppColors.blue,
                        suffixIcon: SizedBox(
                          width: ScreenUtils.screenWidth(context) * 0.35,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.mic,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  PostComment postComment = PostComment(
                                    cmtText: dashboard.commentController.text,
                                    commentId: '51',
                                    uid: '3',
                                    cmtTime: DateTime.now().toString(),
                                  );
                                  // await PostRepository().addComment('1743069654840363', postComment);
                                  // await PostRepository().getPost('1743070528640708');

                                  setState(() {
                                    DummyData
                                        .postDetails[DummyData.postDetails
                                            .indexWhere((post) =>
                                                post.postId ==
                                                dashboard.currPost.postId)]
                                        .postComments
                                        .add(postComment);
                                    dashboard.commentController.text = "";
                                  });
                                },
                                icon: Icon(Icons.send),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
