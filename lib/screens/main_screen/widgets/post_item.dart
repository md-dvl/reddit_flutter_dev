part of '../main_screen.dart';

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
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
