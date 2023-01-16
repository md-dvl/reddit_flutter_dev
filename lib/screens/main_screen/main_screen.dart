import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_flutter_dev/bloc/posts_bloc.dart';
import 'package:reddit_flutter_dev/models/post_model.dart';
import 'package:reddit_flutter_dev/screens/detail_screen/detail_screen.dart';
import 'package:reddit_flutter_dev/theme/colors.dart';
import 'package:reddit_flutter_dev/theme/text_styles.dart';

part 'widgets/post_item.dart';
part 'widgets/app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color372323,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<PostsBloc, PostsStates>(
            builder: (context, state) {
              if (state is SuccessState) {
                return _buildBody(context, state);
              }
              if (state is ErrorState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<PostsBloc>(context).add(GetPosts());
                  },
                  child: Stack(children: [
                    ListView(),
                    const Center(
                      child: Text(
                        'No data. Check your internet connection',
                        style: AppTextStyles.def15w,
                      ),
                    ),
                  ]),
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

  Column _buildBody(BuildContext context, SuccessState state) {
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
              separatorBuilder: (context, index) => const SizedBox(height: 18),
              itemCount: state.models.length,
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
