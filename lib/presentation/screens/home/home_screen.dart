import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../../../core/network/api_util.dart';
import '../../../core/utils/app_util.dart';
import '../../../core/utils/constants/app_assets.dart';
import '../../../data/models/models.dart';
import '../../blocs/home/home_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_fonts.dart';
import '../../theme/theme_styles.dart';
import '../../widgets/action/bottom_nav_bar.dart';
import '../../widgets/general/fading_index_stack.dart';
import '../../widgets/progress/custom_snackbar.dart';
import '../../widgets/progress/general_progress.dart';
import '../../widgets/progress/skeleton.dart';
import '../common/songs_search.dart';
import '../likes/likes_screen.dart';
import '../settings/settings_screen.dart';
import '../songs/songs_screen.dart';

part 'views/big_screen.dart';
part 'views/small_screen.dart';
part 'widgets/search_widget.dart';
part 'widgets/sidebar.dart';
part 'widgets/sidebar_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late HomeBloc _bloc;
  Timer? _syncTimer;

  bool periodicSyncStarted = false;
  int selectedPage = 0, selectedBook = 0;
  List<Book> books = [];
  late SongExt selectedSong;
  List<SongExt> songs = [], likes = [], filtered = [];
  PageController pageController = PageController();

  PageType currentPage = PageType.search;

  @override
  void initState() {
    super.initState();
    selectedSong = SongExt(0, 0, 0, 0, '', '', '', 0, 0, false, '');
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    super.dispose();
  }

  void startPeriodicSync() {
    periodicSyncStarted = true;
    _syncTimer = Timer.periodic(Duration(minutes: 5), (_) async {
      if (await isConnectedToInternet()) _bloc.add(SyncData());
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchData()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          _bloc = context.read<HomeBloc>();
          if (state is HomeDataSyncedState) {
            books = state.books;
            songs = state.songs;
            _bloc.add(FilterData(books[selectedBook]));
          } else if (state is HomeDataFetchedState) {
            books = state.books;
            songs = state.songs;
            _bloc.add(FilterData(books[selectedBook]));
            //if (!periodicSyncStarted) startPeriodicSync();
          } else if (state is HomeFilteredState) {
            likes = state.likes;
            filtered = state.songs;
            selectedBook = books.indexOf(state.book);
            selectedSong = state.songs[0];
          } else if (state is HomeFailureState) {
            CustomSnackbar.show(context, feedbackMessage(state.feedback, l10n));
          } else if (state is HomeResettedState) {
            CustomSnackbar.show(context, l10n.redirectingYou);
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.step1Selection,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var homeView = MediaQuery.of(context).size.shortestSide > 550
              ? BigScreen(parent: this)
              : SmallScreen(parent: this);
          return state.maybeWhen(
            failure: (feedback) => Scaffold(
              body: EmptyState(
                title: l10n.problemDisplaySongs,
                showRetry: true,
                titleRetry: l10n.selectSongsAfresh,
                onRetry: () => context.read<HomeBloc>().add(const ResetData()),
              ),
            ),
            fetching: () => Scaffold(body: HomeLoading()),
            orElse: () => homeView,
            filtered: (book, songs, likes) => homeView,
            synced: (book, songs) => homeView,
          );
        },
      ),
    );
  }
}
