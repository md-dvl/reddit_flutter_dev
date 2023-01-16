part of '../main_screen.dart';

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
