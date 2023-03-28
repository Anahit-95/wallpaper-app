// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neomorphic_wallpaper/cubit/wallpaper_cubit.dart';

import './screens/wallpaper_screen.dart';
import 'extra/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperCubit()..getWallpapers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wall Print',
        theme: theme,
        home: const WallpaperScreen(),
      ),
    );
  }
}
