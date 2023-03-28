import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:neomorphic_wallpaper/widgets/not_found.dart';

import '../cubit/wallpaper_cubit.dart';
import '../extra/snackbar.dart';
import '../extra/wallpaper_model.dart';
import '../widgets/loading_indicator.dart';
import '../extra/constants.dart';
import '../widgets/image_card.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: creamWhite,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: black,
      ),
      body: Column(
        children: [
          const Text(
            'Wall Print',
            style: TextStyle(
              fontSize: 40,
              fontFamily: handlee,
            ),
          ),
          Neumorphic(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: InputBorder.none,
                hintText: 'Search Wallpaper',
                hintStyle: const TextStyle(
                  color: grey,
                ),
                suffixIcon: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context
                        .read<WallpaperCubit>()
                        .getWallpapers(_controller.text);
                  },
                  child: const Icon(Icons.search),
                ),
              ),
              onSubmitted: (value) {
                context.read<WallpaperCubit>().getWallpapers(value);
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<WallpaperCubit, WallpaperState>(
              listener: (_, state) {
                if (state is WallpaperError) {
                  Snackbar.show(
                      context, 'Unable to get wallpapers', ContentType.failure);
                }
              },
              builder: (_, state) {
                if (state is WallpaperLoading) {
                  return const LoadingIndicator();
                } else if (state is WallpaperError) {
                  return const NotFoundIllustration();
                }
                List<WallpaperModel> wallpapers = [];
                if (state is WallpaperLoaded) {
                  wallpapers = state.wallpapers;
                } else {
                  wallpapers = context.read<WallpaperCubit>().wallpapers;
                }
                return MasonryGridView.count(
                  padding: const EdgeInsets.only(top: 10),
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  itemCount: wallpapers.length,
                  itemBuilder: (_, index) {
                    return ImageCard(
                      wallpaper: wallpapers[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
