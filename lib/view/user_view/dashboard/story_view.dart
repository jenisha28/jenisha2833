import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/res/colors/app_colors.dart';
import 'package:social_media_app/utils/screen_utils.dart';
import 'package:social_media_app/view_model/user_view_model/dashboard_controller/dashboard_controller.dart';
import 'package:story_view/story_view.dart';

class Story extends StatefulWidget {
  const Story({super.key});

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> with TickerProviderStateMixin {
  final dashboard = Get.put(DashboardController());
  final StoryController controller = StoryController();
  late final PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    pageController =
        PageController(initialPage: dashboard.currStoryIndex.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: dashboard.story.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              SizedBox(
                height: ScreenUtils.screenHeight(context),
                child: StoryView(
                  onVerticalSwipeComplete: (p0) => Get.back(),
                  controller: controller,
                  storyItems: [
                    if (dashboard.storyData[index].storyText.isNotEmpty)
                      for (var i in dashboard.storyData[index].storyText)
                      StoryItem.text(
                        title: i,
                        backgroundColor:
                            AppColors.randomColor.withValues(alpha: 1.0),
                        roundedTop: true,
                      ),
                    if (dashboard.storyData[index].storyImg.isNotEmpty)
                      for (var i in dashboard.storyData[index].storyImg)
                        StoryItem.inlineImage(
                            imageFit: BoxFit.contain,
                            url: i,
                            controller: controller,
                            captionOuterPadding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                            caption: Text(
                                dashboard.storyData[index].caption.isNotEmpty
                                    ? dashboard.storyData[index].caption
                                    : ""),
                            loadingWidget: CircularProgressIndicator()),
                  ],
                  onStoryShow: (storyItem, index) {},
                  onComplete: () {
                    if (index == dashboard.storyData.length - 1) {
                      Get.back();
                    } else {
                      setState(() {
                        index++;
                        pageController.jumpToPage(index++);
                      });
                    }
                  },
                  progressPosition: ProgressPosition.top,
                  repeat: true,
                  inline: false,
                ),
              ),
              Positioned(
                top: 20,
                child: Container(
                  width: ScreenUtils.screenWidth(context),
                  padding: const EdgeInsets.only(
                      top: 24.0, left: 10, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(dashboard
                            .getUser(dashboard.storyData[index].uid)
                            .profImage),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dashboard
                                .getUser(dashboard.storyData[index].uid)
                                .username,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.white,
                                ),
                          ),
                          Text(
                            dashboard
                                .postTime(dashboard.storyData[index].storyTime),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.white,
                                ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: ScreenUtils.screenWidth(context) * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Type your comment here..",
                        hintStyle: TextStyle(color: AppColors.grey),
                        suffixIconColor: AppColors.blue,
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.send,
                                ),
                              ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
