import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../extra/wallpaper_model.dart';
import '../screens/set_wallpaper_screen.dart';

class ImageCard extends StatelessWidget {
  final WallpaperModel wallpaper;
  const ImageCard({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetWallpaperScreen(
              wallpaper: wallpaper,
            ),
          ),
        );
      },
      child: Neumorphic(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            wallpaper.thumbnail,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
