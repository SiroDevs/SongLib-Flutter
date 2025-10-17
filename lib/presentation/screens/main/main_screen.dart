import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../../../core/di/injectable.dart';
import '../../../data/repositories/pref_repository.dart';
import '../../../data/sources/remote/api_service.dart';
import '../../../core/utils/app_util.dart';
import '../../../core/utils/constants/app_assets.dart';
import '../../../data/models/models.dart';
import '../../blocs/main/main_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../../navigator/route_names.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_data.dart';
import '../../theme/theme_fonts.dart';
import '../../theme/theme_styles.dart';
import '../../widgets/general/fading_index_stack.dart';
import '../../widgets/progress/custom_snackbar.dart';
import '../../widgets/progress/general_progress.dart';
import '../../widgets/progress/skeleton.dart';
import '../likes/likes_screen.dart';
import '../settings/settings_screen.dart';
import '../songs/songs_screen.dart';

part 'widgets/search_widget.dart';
part 'widgets/sidebar.dart';
part 'widgets/sidebar_btn.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<MainScreen> {
  late MainBloc _bloc;
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
      create: (context) => MainBloc()..add(FetchData()),
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          _bloc = context.read<MainBloc>();
          if (state is DataSyncedState) {
            books = state.books;
            songs = state.songs;
            _bloc.add(FilterData(books[selectedBook]));
          } else if (state is DataFetchedState) {
            books = state.books;
            songs = state.songs;
            _bloc.add(FilterData(books[selectedBook]));
            //if (!periodicSyncStarted) startPeriodicSync();
          } else if (state is FilteredState) {
            likes = state.likes;
            filtered = state.songs;
            selectedBook = books.indexOf(state.book);
            selectedSong = state.songs[0];
          } else if (state is FailureState) {
            CustomSnackbar.show(context, feedbackMessage(state.feedback, l10n));
          } else if (state is ResettedState) {
            CustomSnackbar.show(context, l10n.redirectingYou);
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.step1,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var homeView = Stack(
            children: [
              FadingIndexedStack(
                    duration: AppDurations.slow,
                    index: pages.indexOf(currentPage),
                    children: <Widget>[
                      //ListTabPc(vm),
                      SongsScreen(parent: this, isBigScreen: true),
                      LikesScreen(books: books),
                      //DraftsTabPc(vm),
                      //const HelpDeskScreen(),
                      const SettingsScreen(),
                    ],
                  )
                  .positioned(
                    left: 250,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    animate: true,
                  )
                  .animate(.35.seconds, Curves.bounceIn),
              Sidebar(
                    pageType: currentPage,
                    onSelect: (page) => {setState(() => currentPage = page)},
                  )
                  .positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: 250,
                    animate: true,
                  )
                  .animate(.35.seconds, Curves.easeOut),
            ],
          );
          return state.maybeWhen(
            failure: (feedback) => Scaffold(
              body: EmptyState(
                title: l10n.problemDisplaySongs,
                showRetry: true,
                titleRetry: l10n.selectSongsAfresh,
                onRetry: () => context.read<MainBloc>().add(const ResetData()),
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
