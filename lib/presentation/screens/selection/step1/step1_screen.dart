import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import '../../../../core/utils/constants/app_assets.dart';
import '../../../../domain/entities/basic_model.dart';
import '../../../../data/models/book.dart';
import '../../../../core/utils/app_util.dart';
import '../../../blocs/step1/step1_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../../../navigator/route_names.dart';
import '../../../theme/theme_colors.dart';
import '../../../theme/theme_styles.dart';
import '../../../widgets/general/list_items.dart';
import '../../../widgets/progress/custom_snackbar.dart';
import '../../../widgets/progress/general_progress.dart';
import '../../../widgets/progress/skeleton.dart';

part 'widgets/step1_fab.dart';

class Step1Screen extends StatefulWidget {
  const Step1Screen({super.key});

  @override
  State<Step1Screen> createState() => Step1ScreenState();
}

class Step1ScreenState extends State<Step1Screen> {
  List<Book> booksSelected = [];
  List<Selectable<Book>> booksListing = [];

  void onBookSelected(int index, List<Selectable<Book>> listing) {
    try {
      setState(() {
        final book = listing[index];
        book.isSelected = !book.isSelected;
        if (book.isSelected) {
          booksSelected.add(book.data);
        } else {
          booksSelected.remove(book.data);
        }
      });
    } catch (e) {
      logger('Unable to update selection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => Step1Bloc()..add(FetchBooks()),
      child: BlocConsumer<Step1Bloc, Step1State>(
        listener: (context, state) {
          if (state is Step1SavedState) {
            Navigator.pushNamed(context, RouteNames.step2Selection);
          } else if (state is Step1FailureState) {
            CustomSnackbar.show(context, feedbackMessage(state.feedback, l10n));
          } else if (state is Step1FetchedState) {
            booksListing = state.booksListing;
            CustomSnackbar.show(context, l10n.availableBooks, isSuccess: true);
          }
        },
        builder: (context, state) {
          var bloc = context.read<Step1Bloc>();

          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.booksTitle),
              actions: [
                IconButton(
                  icon: Platform.isIOS
                      ? Icon(CupertinoIcons.refresh)
                      : Icon(Icons.refresh),
                  onPressed: () => bloc.add(const FetchBooks()),
                ),
              ],
            ),
            body: state.maybeWhen(
              orElse: () => SizedBox(),
              progress: () => const SelectionLoading(),
              failure: (feedback) => EmptyState(
                title: l10n.nothingHere,
                showRetry: true,
                onRetry: () => bloc.add(const FetchBooks()),
              ),
              fetched: (selectedBooksIds, books, booksListing) {
                var booksGridview = LayoutBuilder(
                  builder: (context, dimens) {
                    final axisCount = (dimens.maxWidth / 450).round();
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: axisCount,
                        childAspectRatio: 4,
                      ),
                      padding: const EdgeInsets.all(Sizes.xs),
                      itemCount: booksListing.length,
                      itemBuilder: (context, index) => BookItem(
                        item: booksListing[index],
                        onPressed: () => onBookSelected(index, booksListing),
                      ),
                    );
                  },
                );
                var booksListview = ListView.builder(
                  itemCount: booksListing.length,
                  padding: const EdgeInsets.all(Sizes.xs),
                  itemBuilder: (context, index) => BookItem(
                    item: booksListing[index],
                    onPressed: () => onBookSelected(index, booksListing),
                  ),
                );
                return size.shortestSide > 550 ? booksGridview : booksListview;
              },
            ),
            floatingActionButton: Step1Fab(parent: this),
          );
        },
      ),
    );
  }
}
