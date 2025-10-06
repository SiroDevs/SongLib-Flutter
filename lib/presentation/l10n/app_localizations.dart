import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sw'),
  ];

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'SongLib'**
  String get appName;

  /// No description provided for @listTitle.
  ///
  /// In en, this message translates to:
  /// **'Song Lists'**
  String get listTitle;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Songs'**
  String get searchTitle;

  /// No description provided for @likesTitle.
  ///
  /// In en, this message translates to:
  /// **'Liked Songs'**
  String get likesTitle;

  /// No description provided for @historiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Histories'**
  String get historiesTitle;

  /// No description provided for @draftTitle.
  ///
  /// In en, this message translates to:
  /// **'Song Drafts'**
  String get draftTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @helpdeskTitle.
  ///
  /// In en, this message translates to:
  /// **'Help Desk'**
  String get helpdeskTitle;

  /// No description provided for @donateTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Donate'**
  String get donateTitle;

  /// No description provided for @merchandiseTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy our Merchandise'**
  String get merchandiseTitle;

  /// No description provided for @booksTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Song Books'**
  String get booksTitle;

  /// No description provided for @booksTitleLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading data ...'**
  String get booksTitleLoading;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @listedTitle.
  ///
  /// In en, this message translates to:
  /// **'Adding a new list'**
  String get listedTitle;

  /// No description provided for @editorTitle.
  ///
  /// In en, this message translates to:
  /// **'Drafting a new song'**
  String get editorTitle;

  /// No description provided for @songTitle.
  ///
  /// In en, this message translates to:
  /// **'Your song in one line'**
  String get songTitle;

  /// No description provided for @songText.
  ///
  /// In en, this message translates to:
  /// **'The rest of your song'**
  String get songText;

  /// No description provided for @hasChorus.
  ///
  /// In en, this message translates to:
  /// **'With a Chorus'**
  String get hasChorus;

  /// No description provided for @verses.
  ///
  /// In en, this message translates to:
  /// **'Verse'**
  String get verses;

  /// No description provided for @addtoList.
  ///
  /// In en, this message translates to:
  /// **'Add to a List'**
  String get addtoList;

  /// No description provided for @addSongtoList.
  ///
  /// In en, this message translates to:
  /// **'Add this song to a List'**
  String get addSongtoList;

  /// No description provided for @likeSong.
  ///
  /// In en, this message translates to:
  /// **'Like this song'**
  String get likeSong;

  /// No description provided for @editSong.
  ///
  /// In en, this message translates to:
  /// **'Edit this song'**
  String get editSong;

  /// No description provided for @deleteSong.
  ///
  /// In en, this message translates to:
  /// **'Delete this song'**
  String get deleteSong;

  /// No description provided for @copySong.
  ///
  /// In en, this message translates to:
  /// **'Copy this song'**
  String get copySong;

  /// No description provided for @deleteList.
  ///
  /// In en, this message translates to:
  /// **'Delete this list'**
  String get deleteList;

  /// No description provided for @shareSong.
  ///
  /// In en, this message translates to:
  /// **'Share this song'**
  String get shareSong;

  /// No description provided for @songCopied.
  ///
  /// In en, this message translates to:
  /// **'song copied!'**
  String get songCopied;

  /// No description provided for @copyVerse.
  ///
  /// In en, this message translates to:
  /// **'Copy verse'**
  String get copyVerse;

  /// No description provided for @textCopied.
  ///
  /// In en, this message translates to:
  /// **' copied!'**
  String get textCopied;

  /// No description provided for @shareVerse.
  ///
  /// In en, this message translates to:
  /// **'Share verse'**
  String get shareVerse;

  /// No description provided for @projectSong.
  ///
  /// In en, this message translates to:
  /// **'Project this Song'**
  String get projectSong;

  /// No description provided for @songLiked.
  ///
  /// In en, this message translates to:
  /// **'Song added to Favorites!'**
  String get songLiked;

  /// No description provided for @songDisliked.
  ///
  /// In en, this message translates to:
  /// **'Song removed from Favorites!'**
  String get songDisliked;

  /// No description provided for @songLike.
  ///
  /// In en, this message translates to:
  /// **'Add this Song to Favorites!'**
  String get songLike;

  /// No description provided for @songDislike.
  ///
  /// In en, this message translates to:
  /// **'Remove this Song from Favorites!'**
  String get songDislike;

  /// No description provided for @songAddedToList.
  ///
  /// In en, this message translates to:
  /// **' added to '**
  String get songAddedToList;

  /// No description provided for @listCreated.
  ///
  /// In en, this message translates to:
  /// **'song list created!'**
  String get listCreated;

  /// No description provided for @listUpdated.
  ///
  /// In en, this message translates to:
  /// **'song list updated!'**
  String get listUpdated;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'deleted!'**
  String get deleted;

  /// No description provided for @readyShare.
  ///
  /// In en, this message translates to:
  /// **'Ready for sharing'**
  String get readyShare;

  /// No description provided for @screenshotVerse.
  ///
  /// In en, this message translates to:
  /// **'Screenshot verse'**
  String get screenshotVerse;

  /// No description provided for @screenshoted.
  ///
  /// In en, this message translates to:
  /// **'We have your screenshot!'**
  String get screenshoted;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @displayTitle.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get displayTitle;

  /// No description provided for @collectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Collection'**
  String get collectionTitle;

  /// No description provided for @presentationTitle.
  ///
  /// In en, this message translates to:
  /// **'Song Presentation'**
  String get presentationTitle;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @appThemeDesc.
  ///
  /// In en, this message translates to:
  /// **'Current Theme:'**
  String get appThemeDesc;

  /// No description provided for @reselectSongbooks.
  ///
  /// In en, this message translates to:
  /// **'Select Songbooks Afresh'**
  String get reselectSongbooks;

  /// No description provided for @reselectSongbooksDesc.
  ///
  /// In en, this message translates to:
  /// **'Restructure your collection once again'**
  String get reselectSongbooksDesc;

  /// No description provided for @songPresentation.
  ///
  /// In en, this message translates to:
  /// **'Slide Scroll Direction'**
  String get songPresentation;

  /// No description provided for @songPresentationDesc.
  ///
  /// In en, this message translates to:
  /// **'Song slides to scroll vertically'**
  String get songPresentationDesc;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// No description provided for @themeDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeDefault;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @remind.
  ///
  /// In en, this message translates to:
  /// **'Remind Me Later'**
  String get remind;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @justAMinute.
  ///
  /// In en, this message translates to:
  /// **'Just a minute!'**
  String get justAMinute;

  /// No description provided for @supportSongLib.
  ///
  /// In en, this message translates to:
  /// **'Support SongLib'**
  String get supportSongLib;

  /// No description provided for @notificationDialog.
  ///
  /// In en, this message translates to:
  /// **'Let\'s remind you'**
  String get notificationDialog;

  /// No description provided for @noSongSelected.
  ///
  /// In en, this message translates to:
  /// **'No song item has been selected'**
  String get noSongSelected;

  /// No description provided for @selectSongsAfresh.
  ///
  /// In en, this message translates to:
  /// **'Select Songs Afresh'**
  String get selectSongsAfresh;

  /// No description provided for @problemDisplaySongs.
  ///
  /// In en, this message translates to:
  /// **'Oops there is a problem displaying songs under the book you selected.\n\nYou can fix the issue by selecting them afresh'**
  String get problemDisplaySongs;

  /// No description provided for @donationRequest.
  ///
  /// In en, this message translates to:
  /// **'Donation Request'**
  String get donationRequest;

  /// No description provided for @donationRequestBody.
  ///
  /// In en, this message translates to:
  /// **'SongLib has a lot in the pipelines and will need your support to accomplish that.'**
  String get donationRequestBody;

  /// No description provided for @doneSelecting.
  ///
  /// In en, this message translates to:
  /// **'Done with selecting?'**
  String get doneSelecting;

  /// No description provided for @doneSelectingBody.
  ///
  /// In en, this message translates to:
  /// **'If you are done selecting please proceed ahead. We can always bring you back here to reselect afresh.'**
  String get doneSelectingBody;

  /// No description provided for @noSelection.
  ///
  /// In en, this message translates to:
  /// **'Oops! No selection found'**
  String get noSelection;

  /// No description provided for @noSelectionBody.
  ///
  /// In en, this message translates to:
  /// **'Please select at least 1 book to proceed to the next step.'**
  String get noSelectionBody;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Wueh! You weren\'t supposed to see this!'**
  String get errorOccurred;

  /// No description provided for @errorOccurredBody1.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred while trying to present the song to you. Please try again later or contact support'**
  String get errorOccurredBody1;

  /// No description provided for @errorOccurredBody.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred while trying to fetch data from the server. Please try again later or contact support'**
  String get errorOccurredBody;

  /// No description provided for @noConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection!'**
  String get noConnection;

  /// No description provided for @noConnectionBody.
  ///
  /// In en, this message translates to:
  /// **'If you have reliable internet connection, then it\'s our servers that are down or unaccessible.\n\nIf this situation persists, email us: futuristicken@gmail.com with a screenshot and your device info.'**
  String get noConnectionBody;

  /// No description provided for @itsEmptyHere.
  ///
  /// In en, this message translates to:
  /// **'Wueh! It\'s empty here'**
  String get itsEmptyHere;

  /// No description provided for @itsEmptyHere1.
  ///
  /// In en, this message translates to:
  /// **'Wueh! No lists here yet'**
  String get itsEmptyHere1;

  /// No description provided for @itsEmptyHereBody.
  ///
  /// In en, this message translates to:
  /// **'All caught here, do a selection of songs once again'**
  String get itsEmptyHereBody;

  /// No description provided for @itsEmptyHereBody1.
  ///
  /// In en, this message translates to:
  /// **'All caught here, please like a song, search or view a song or better still add a custom list to clear this emptiness here'**
  String get itsEmptyHereBody1;

  /// No description provided for @itsEmptyHereBody2.
  ///
  /// In en, this message translates to:
  /// **'All caught here, please add draft song to clear this emptiness here'**
  String get itsEmptyHereBody2;

  /// No description provided for @itsEmptyHereBody3.
  ///
  /// In en, this message translates to:
  /// **'All caught here, please like a song to clear this emptiness here'**
  String get itsEmptyHereBody3;

  /// No description provided for @itsEmptyHereBody4.
  ///
  /// In en, this message translates to:
  /// **'All caught here, you can add personal lists and add songs to them'**
  String get itsEmptyHereBody4;

  /// No description provided for @keyboardShortcuts.
  ///
  /// In en, this message translates to:
  /// **'Keyboard Shortcuts'**
  String get keyboardShortcuts;

  /// No description provided for @keyboardShortcutsTexts.
  ///
  /// In en, this message translates to:
  /// **'Letter   I - Show keyboard shortcuts \nESC Key - Exit from Song Presentation \n\nDOWN Arrow - Go to Next Verse \nUP  Arrow     - Go to Previous Verse \n\nLetter C - Go to the Song Chorus \nLetter S - Go to Second Last Verse \nLetter L - Go to Last Verse \n\nNumpad 1, 2, 3, 4, 5, 6, 7 - Go to the Verse by Number'**
  String get keyboardShortcutsTexts;

  /// No description provided for @hintsCurrentUpdate.
  ///
  /// In en, this message translates to:
  /// **'In this Latest Update'**
  String get hintsCurrentUpdate;

  /// No description provided for @hintsCurrentUpdateText.
  ///
  /// In en, this message translates to:
  /// **'1. Search without worrying about commas or exclamations \n2. Search with words not following each other by using a comma in between them \n\t\tE.g \'Jesus, sin\' can be used to search the song \'Jesus paid it all\''**
  String get hintsCurrentUpdateText;

  /// No description provided for @donationRequestReminder.
  ///
  /// In en, this message translates to:
  /// **'\n\nRemember to support our work with your donation from time to time.\nHead over to the Help Desk to Donate'**
  String get donationRequestReminder;

  /// No description provided for @availableBooks.
  ///
  /// In en, this message translates to:
  /// **'Here are the available books, please select as many as you like to proceed'**
  String get availableBooks;

  /// No description provided for @nothingHere.
  ///
  /// In en, this message translates to:
  /// **'Sorry nothing to show here at the moment.'**
  String get nothingHere;

  /// No description provided for @redirectingYou.
  ///
  /// In en, this message translates to:
  /// **'Redirecting you to select songs afresh'**
  String get redirectingYou;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @verticalSlide.
  ///
  /// In en, this message translates to:
  /// **'Vertical (Up, Down)'**
  String get verticalSlide;

  /// No description provided for @horizontalSlide.
  ///
  /// In en, this message translates to:
  /// **'Horizontal (Left, Right)'**
  String get horizontalSlide;

  /// No description provided for @songbooksMgnt.
  ///
  /// In en, this message translates to:
  /// **'Songbooks Management'**
  String get songbooksMgnt;

  /// No description provided for @songbooksMgntText.
  ///
  /// In en, this message translates to:
  /// **'Reselect your songbooks afresh'**
  String get songbooksMgntText;

  /// No description provided for @screenAwake.
  ///
  /// In en, this message translates to:
  /// **'Keep Screen On in Song View'**
  String get screenAwake;

  /// No description provided for @slideDirection.
  ///
  /// In en, this message translates to:
  /// **'Song Slides Direction'**
  String get slideDirection;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Direction: {direction}'**
  String setDirection(String direction);

  ///
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Theme: {theme}'**
  String setTheme(String theme);

  /// No description provided for @defaultMode.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// No description provided for @labelError0.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occured.'**
  String get labelError0;

  /// No description provided for @labelError404.
  ///
  /// In en, this message translates to:
  /// **'We\'re unable to connect you to our server at the moment.'**
  String get labelError404;

  /// No description provided for @labelError500.
  ///
  /// In en, this message translates to:
  /// **'You\'re unable to connect to our server at the moment.'**
  String get labelError500;

  /// No description provided for @labelError504.
  ///
  /// In en, this message translates to:
  /// **'Your request to our server has timed out.'**
  String get labelError504;

  /// No description provided for @labelError999.
  ///
  /// In en, this message translates to:
  /// **'Our server returned an invalid response.'**
  String get labelError999;

  /// No description provided for @labelError1000.
  ///
  /// In en, this message translates to:
  /// **'We\'re unable to submit your request.'**
  String get labelError1000;

  /// No description provided for @labelFeedback0.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occured.'**
  String get labelFeedback0;

  /// No description provided for @labelFeedback404.
  ///
  /// In en, this message translates to:
  /// **'We can\'t connect you to our server at the moment due to a technical issue on our end. Please try connecting again, if the issue persists contact us on: thesonglibapp@gmail.com'**
  String get labelFeedback404;

  /// No description provided for @labelFeedback500.
  ///
  /// In en, this message translates to:
  /// **'We can\'t connect you to our server at the moment due to a technical issue on your end. Please try switching to a reliable internet service and trying again. If the issue persists contact us on: thesonglibapp@gmail.com'**
  String get labelFeedback500;

  /// No description provided for @labelFeedback504.
  ///
  /// In en, this message translates to:
  /// **'Your request to our server has timed out.'**
  String get labelFeedback504;

  /// No description provided for @labelFeedback999.
  ///
  /// In en, this message translates to:
  /// **'Our server returned an invalid response.'**
  String get labelFeedback999;

  /// No description provided for @labelFeedback1000.
  ///
  /// In en, this message translates to:
  /// **'We\'re unable to submit your request.'**
  String get labelFeedback1000;

  /// No description provided for @labelPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get labelPermissionTitle;

  /// No description provided for @labelPermissionText.
  ///
  /// In en, this message translates to:
  /// **'This app requires this permissions to function properly.'**
  String get labelPermissionText;

  /// No description provided for @misc.
  ///
  /// In en, this message translates to:
  /// **'misc'**
  String get misc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
