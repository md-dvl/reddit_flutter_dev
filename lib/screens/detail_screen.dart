import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_flutter_dev/bloc/posts_bloc.dart';
import 'package:reddit_flutter_dev/theme/text_styles.dart';
import '../theme/colors.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 16),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: AppColors.colorEDEDED,
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        Text(state.models[id].ups ?? '0',
                            style: AppTextStyles.def15w),
                        const SizedBox(width: 14),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(state.models[id].title ?? '',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.def18wBold),
                                const SizedBox(height: 10),
                                Text(state.models[id].selftext ?? '',
                                    style: AppTextStyles.def15w)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
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
