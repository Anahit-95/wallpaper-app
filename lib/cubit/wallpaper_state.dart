// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wallpaper_cubit.dart';

@immutable
abstract class WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperLoaded extends WallpaperState {
  List<WallpaperModel> wallpapers;
  WallpaperLoaded({
    required this.wallpapers,
  });
}

class WallpaperError extends WallpaperState {
  final String message;
  WallpaperError({
    required this.message,
  });
}

class WallpaperAppliedSuccess extends WallpaperState {}

class WallpaperAppliedFailed extends WallpaperState {}
