import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_flutter_dev/bloc/posts_bloc.dart';
import 'package:reddit_flutter_dev/models/post_model.dart';
import 'package:reddit_flutter_dev/screens/detail_screen.dart';

import 'package:reddit_flutter_dev/theme/text_styles.dart';

import '../theme/colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color372323,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: BlocBuilder<PostsBloc, PostsStates>(
            builder: (context, state) {
              if (state is SuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const _AppBar(),
                    const SizedBox(height: 20),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<PostsBloc>(context).add(GetPosts());
                        },
                        child: ListView.separated(
                          itemBuilder: (context, index) => _PostItem(
                            post: state.models[index],
                            isImage: state.models[index].isImage ?? false,
                            index: index,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 18),
                          itemCount: state.models.length,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18)
                  ],
                );
              }
              if (state is ErrorState) {
                return const Center(
                  child: Text(
                    'No data. Check your internet connection',
                    style: AppTextStyles.def15w,
                  ),
                );
              }
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({
    Key? key,
    required this.post,
    required this.isImage,
    required this.index,
  }) : super(key: key);

  final PostModel post;
  final bool isImage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(id: index),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.color43403F,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isImage
            ? Row(children: [
                Expanded(
                  child: Text(
                    post.title ?? '',
                    style: AppTextStyles.def15w,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: post.thumbnail ??
                      'https://rickandmortyapi.com/api/character/avatar/7.jpeg',
                  placeholder: (context, url) => const SizedBox(
                    height: 60,
                    width: 85,
                    child: Padding(
                      padding: EdgeInsets.all(36.0),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    height: 60,
                    width: 85,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ])
            : Text(
                post.title ?? '',
                style: AppTextStyles.def15w,
                // maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text('Reddit /FlutterDev', style: AppTextStyles.def36wBold),
        ],
      ),
    );
  }
}
