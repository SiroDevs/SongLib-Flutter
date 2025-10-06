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

  /// Label for feedback section or button
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'SongLib'**
  String get appName;

  /// Title for song lists section
  ///
  /// In en, this message translates to:
  /// **'Song Lists'**
  String get listTitle;

  /// Title for search songs section
  ///
  /// In en, this message translates to:
  /// **'Search Songs'**
  String get searchTitle;

  /// Title for liked songs section
  ///
  /// In en, this message translates to:
  /// **'Liked Songs'**
  String get likesTitle;

  /// Title for song history section
  ///
  /// In en, this message translates to:
  /// **'Histories'**
  String get historiesTitle;

  /// Title for song drafts section
  ///
  /// In en, this message translates to:
  /// **'Song Drafts'**
  String get draftTitle;

  /// Title for settings section
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Title for help desk section
  ///
  /// In en, this message translates to:
  /// **'Help Desk'**
  String get helpdeskTitle;

  /// Title for donation information section
  ///
  /// In en, this message translates to:
  /// **'How to Donate'**
  String get donateTitle;

  /// Title for merchandise section
  ///
  /// In en, this message translates to:
  /// **'Buy our Merchandise'**
  String get merchandiseTitle;

  /// Title for song book selection
  ///
  /// In en, this message translates to:
  /// **'Select Song Books'**
  String get booksTitle;

  /// Loading message while fetching song books data
  ///
  /// In en, this message translates to:
  /// **'Loading data ...'**
  String get booksTitleLoading;

  /// Title for home section
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Title for adding new song list
  ///
  /// In en, this message translates to:
  /// **'Adding a new list'**
  String get listedTitle;

  /// Title for song drafting/editing screen
  ///
  /// In en, this message translates to:
  /// **'Drafting a new song'**
  String get editorTitle;

  /// Placeholder for song title input
  ///
  /// In en, this message translates to:
  /// **'Your song in one line'**
  String get songTitle;

  /// Placeholder for song lyrics/content input
  ///
  /// In en, this message translates to:
  /// **'The rest of your song'**
  String get songText;

  /// Label for chorus toggle/checkbox
  ///
  /// In en, this message translates to:
  /// **'With a Chorus'**
  String get hasChorus;

  /// Label for song verses
  ///
  /// In en, this message translates to:
  /// **'Verse'**
  String get verses;

  /// Action to add song to a list
  ///
  /// In en, this message translates to:
  /// **'Add to a List'**
  String get addtoList;

  /// Action description for adding song to list
  ///
  /// In en, this message translates to:
  /// **'Add this song to a List'**
  String get addSongtoList;

  /// Action to like/favorite a song
  ///
  /// In en, this message translates to:
  /// **'Like this song'**
  String get likeSong;

  /// Action to edit a song
  ///
  /// In en, this message translates to:
  /// **'Edit this song'**
  String get editSong;

  /// Action to delete a song
  ///
  /// In en, this message translates to:
  /// **'Delete this song'**
  String get deleteSong;

  /// Action to copy a song
  ///
  /// In en, this message translates to:
  /// **'Copy this song'**
  String get copySong;

  /// Action to delete a song list
  ///
  /// In en, this message translates to:
  /// **'Delete this list'**
  String get deleteList;

  /// Action to share a song
  ///
  /// In en, this message translates to:
  /// **'Share this song'**
  String get shareSong;

  /// Success message when song is copied
  ///
  /// In en, this message translates to:
  /// **'song copied!'**
  String get songCopied;

  /// Action to copy a verse
  ///
  /// In en, this message translates to:
  /// **'Copy verse'**
  String get copyVerse;

  /// Success message when text is copied
  ///
  /// In en, this message translates to:
  /// **' copied!'**
  String get textCopied;

  /// Action to share a verse
  ///
  /// In en, this message translates to:
  /// **'Share verse'**
  String get shareVerse;

  /// Action to project/present a song
  ///
  /// In en, this message translates to:
  /// **'Project this Song'**
  String get projectSong;

  /// Success message when song is added to favorites
  ///
  /// In en, this message translates to:
  /// **'Song added to Favorites!'**
  String get songLiked;

  /// Message when song is removed from favorites
  ///
  /// In en, this message translates to:
  /// **'Song removed from Favorites!'**
  String get songDisliked;

  /// Tooltip or label for like action
  ///
  /// In en, this message translates to:
  /// **'Add this Song to Favorites!'**
  String get songLike;

  /// Tooltip or label for unlike action
  ///
  /// In en, this message translates to:
  /// **'Remove this Song from Favorites!'**
  String get songDislike;

  /// Success message when song is added to a list
  ///
  /// In en, this message translates to:
  /// **' added to '**
  String get songAddedToList;

  /// Success message when list is created
  ///
  /// In en, this message translates to:
  /// **'song list created!'**
  String get listCreated;

  /// Success message when list is updated
  ///
  /// In en, this message translates to:
  /// **'song list updated!'**
  String get listUpdated;

  /// Success message when item is deleted
  ///
  /// In en, this message translates to:
  /// **'deleted!'**
  String get deleted;

  /// Message indicating content is ready to share
  ///
  /// In en, this message translates to:
  /// **'Ready for sharing'**
  String get readyShare;

  /// Action to take screenshot of verse
  ///
  /// In en, this message translates to:
  /// **'Screenshot verse'**
  String get screenshotVerse;

  /// Success message when screenshot is taken
  ///
  /// In en, this message translates to:
  /// **'We have your screenshot!'**
  String get screenshoted;

  /// Title for app settings section
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// Title for display settings section
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get displayTitle;

  /// Title for user's collection section
  ///
  /// In en, this message translates to:
  /// **'Your Collection'**
  String get collectionTitle;

  /// Title for song presentation settings
  ///
  /// In en, this message translates to:
  /// **'Song Presentation'**
  String get presentationTitle;

  /// Label for app theme setting
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// Description showing current theme
  ///
  /// In en, this message translates to:
  /// **'Current Theme:'**
  String get appThemeDesc;

  /// Action to reselect songbooks
  ///
  /// In en, this message translates to:
  /// **'Select Songbooks Afresh'**
  String get reselectSongbooks;

  /// Description for reselecting songbooks
  ///
  /// In en, this message translates to:
  /// **'Restructure your collection once again'**
  String get reselectSongbooksDesc;

  /// Label for song presentation direction setting
  ///
  /// In en, this message translates to:
  /// **'Slide Scroll Direction'**
  String get songPresentation;

  /// Description for song presentation direction
  ///
  /// In en, this message translates to:
  /// **'Song slides to scroll vertically'**
  String get songPresentationDesc;

  /// Title for theme selection dialog
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// Option for system default theme
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeDefault;

  /// Option for light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Option for dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Confirmation button text
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Action to open app settings
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// Button to postpone reminder
  ///
  /// In en, this message translates to:
  /// **'Remind Me Later'**
  String get remind;

  /// Action to make donation
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// Action to continue/next
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// Attention-grabbing dialog title
  ///
  /// In en, this message translates to:
  /// **'Just a minute!'**
  String get justAMinute;

  /// Title for support/donation request
  ///
  /// In en, this message translates to:
  /// **'Support SongLib'**
  String get supportSongLib;

  /// Title for reminder dialog
  ///
  /// In en, this message translates to:
  /// **'Let\'s remind you'**
  String get notificationDialog;

  /// Error message when no song is selected
  ///
  /// In en, this message translates to:
  /// **'No song item has been selected'**
  String get noSongSelected;

  /// Action to select songs again
  ///
  /// In en, this message translates to:
  /// **'Select Songs Afresh'**
  String get selectSongsAfresh;

  /// Error message when songs cannot be displayed
  ///
  /// In en, this message translates to:
  /// **'Oops there is a problem displaying songs under the book you selected.\n\nYou can fix the issue by selecting them afresh'**
  String get problemDisplaySongs;

  /// Title for donation request
  ///
  /// In en, this message translates to:
  /// **'Donation Request'**
  String get donationRequest;

  /// Body text for donation request
  ///
  /// In en, this message translates to:
  /// **'SongLib has a lot in the pipelines and will need your support to accomplish that.'**
  String get donationRequestBody;

  /// Prompt to confirm selection completion
  ///
  /// In en, this message translates to:
  /// **'Done with selecting?'**
  String get doneSelecting;

  /// Body text for selection completion prompt
  ///
  /// In en, this message translates to:
  /// **'If you are done selecting please proceed ahead. We can always bring you back here to reselect afresh.'**
  String get doneSelectingBody;

  /// Error message when no selection is made
  ///
  /// In en, this message translates to:
  /// **'Oops! No selection found'**
  String get noSelection;

  /// Body text for no selection error
  ///
  /// In en, this message translates to:
  /// **'Please select at least 1 book to proceed to the next step.'**
  String get noSelectionBody;

  /// Title for unexpected error
  ///
  /// In en, this message translates to:
  /// **'Wueh! You weren\'t supposed to see this!'**
  String get errorOccurred;

  /// Body text for song presentation error
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred while trying to present the song to you. Please try again later or contact support'**
  String get errorOccurredBody1;

  /// Body text for server fetch error
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred while trying to fetch data from the server. Please try again later or contact support'**
  String get errorOccurredBody;

  /// Title for no internet connection error
  ///
  /// In en, this message translates to:
  /// **'No internet connection!'**
  String get noConnection;

  /// Body text for connection error with support email
  ///
  /// In en, this message translates to:
  /// **'If you have reliable internet connection, then it\'s our servers that are down or unaccessible.\n\nIf this situation persists, email us: futuristicken@gmail.com with a screenshot and your device info.'**
  String get noConnectionBody;

  /// Empty state title for general sections
  ///
  /// In en, this message translates to:
  /// **'Wueh! It\'s empty here'**
  String get itsEmptyHere;

  /// Empty state title for lists section
  ///
  /// In en, this message translates to:
  /// **'Wueh! No lists here yet'**
  String get itsEmptyHere1;

  /// Empty state body for song selection
  ///
  /// In en, this message translates to:
  /// **'All caught here, do a selection of songs once again'**
  String get itsEmptyHereBody;

  /// Empty state body with suggestions for lists
  ///
  /// In en, this message translates to:
  /// **'All caught here, please like a song, search or view a song or better still add a custom list to clear this emptiness here'**
  String get itsEmptyHereBody1;

  /// Empty state body for drafts section
  ///
  /// In en, this message translates to:
  /// **'All caught here, please add draft song to clear this emptiness here'**
  String get itsEmptyHereBody2;

  /// Empty state body for favorites section
  ///
  /// In en, this message translates to:
  /// **'All caught here, please like a song to clear this emptiness here'**
  String get itsEmptyHereBody3;

  /// Empty state body with suggestion for personal lists
  ///
  /// In en, this message translates to:
  /// **'All caught here, you can add personal lists and add songs to them'**
  String get itsEmptyHereBody4;

  /// Title for keyboard shortcuts section
  ///
  /// In en, this message translates to:
  /// **'Keyboard Shortcuts'**
  String get keyboardShortcuts;

  /// List of keyboard shortcuts with descriptions
  ///
  /// In en, this message translates to:
  /// **'Letter   I - Show keyboard shortcuts \nESC Key - Exit from Song Presentation \n\nDOWN Arrow - Go to Next Verse \nUP  Arrow     - Go to Previous Verse \n\nLetter C - Go to the Song Chorus \nLetter S - Go to Second Last Verse \nLetter L - Go to Last Verse \n\nNumpad 1, 2, 3, 4, 5, 6, 7 - Go to the Verse by Number'**
  String get keyboardShortcutsTexts;

  /// Title for current update highlights
  ///
  /// In en, this message translates to:
  /// **'In this Latest Update'**
  String get hintsCurrentUpdate;

  /// Text describing new features in current update
  ///
  /// In en, this message translates to:
  /// **'1. Search without worrying about commas or exclamations \n2. Search with words not following each other by using a comma in between them \n\t\tE.g \'Jesus, sin\' can be used to search the song \'Jesus paid it all\''**
  String get hintsCurrentUpdateText;

  /// Reminder text about supporting with donations
  ///
  /// In en, this message translates to:
  /// **'\n\nRemember to support our work with your donation from time to time.\nHead over to the Help Desk to Donate'**
  String get donationRequestReminder;

  /// Instruction text for book selection
  ///
  /// In en, this message translates to:
  /// **'Here are the available books, please select as many as you like to proceed'**
  String get availableBooks;

  /// Generic empty state message
  ///
  /// In en, this message translates to:
  /// **'Sorry nothing to show here at the moment.'**
  String get nothingHere;

  /// Message indicating redirection to song selection
  ///
  /// In en, this message translates to:
  /// **'Redirecting you to select songs afresh'**
  String get redirectingYou;

  /// Label for disabled state
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// Label for enabled state
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// Label for system default option
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// Option for vertical slide direction
  ///
  /// In en, this message translates to:
  /// **'Vertical (Up, Down)'**
  String get verticalSlide;

  /// Option for horizontal slide direction
  ///
  /// In en, this message translates to:
  /// **'Horizontal (Left, Right)'**
  String get horizontalSlide;

  /// Title for songbooks management section
  ///
  /// In en, this message translates to:
  /// **'Songbooks Management'**
  String get songbooksMgnt;

  /// Description for songbooks management
  ///
  /// In en, this message translates to:
  /// **'Reselect your songbooks afresh'**
  String get songbooksMgntText;

  /// Setting to keep screen awake during song presentation
  ///
  /// In en, this message translates to:
  /// **'Keep Screen On in Song View'**
  String get screenAwake;

  /// Label for slide direction setting
  ///
  /// In en, this message translates to:
  /// **'Song Slides Direction'**
  String get slideDirection;

  /// Message showing current slide direction with parameter
  ///
  /// In en, this message translates to:
  /// **'Direction: {direction}'**
  String setDirection(String direction);

  /// Label for theme mode setting
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// Message showing current theme with parameter
  ///
  /// In en, this message translates to:
  /// **'Theme: {theme}'**
  String setTheme(String theme);

  /// Label for default mode
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultMode;

  /// Label for light mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// Label for dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// Generic unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unknown error occured.'**
  String get labelError0;

  /// Error message for 404 (not found) server error
  ///
  /// In en, this message translates to:
  /// **'We\'re unable to connect you to our server at the moment.'**
  String get labelError404;

  /// Error message for 500 (server) error
  ///
  /// In en, this message translates to:
  /// **'You\'re unable to connect to our server at the moment.'**
  String get labelError500;

  /// Error message for 504 (timeout) error
  ///
  /// In en, this message translates to:
  /// **'Your request to our server has timed out.'**
  String get labelError504;

  /// Error message for invalid server response
  ///
  /// In en, this message translates to:
  /// **'Our server returned an invalid response.'**
  String get labelError999;

  /// Error message for request submission failure
  ///
  /// In en, this message translates to:
  /// **'We\'re unable to submit your request.'**
  String get labelError1000;

  /// Generic unknown error for feedback
  ///
  /// In en, this message translates to:
  /// **'An unknown error occured.'**
  String get labelFeedback0;

  /// Detailed 404 error message with support contact for feedback
  ///
  /// In en, this message translates to:
  /// **'We can\'t connect you to our server at the moment due to a technical issue on our end. Please try connecting again, if the issue persists contact us on: thesonglibapp@gmail.com'**
  String get labelFeedback404;

  /// Detailed 500 error message with troubleshooting steps for feedback
  ///
  /// In en, this message translates to:
  /// **'We can\'t connect you to our server at the moment due to a technical issue on your end. Please try switching to a reliable internet service and trying again. If the issue persists contact us on: thesonglibapp@gmail.com'**
  String get labelFeedback500;

  /// Timeout error message for feedback
  ///
  /// In en, this message translates to:
  /// **'Your request to our server has timed out.'**
  String get labelFeedback504;

  /// Invalid response error for feedback
  ///
  /// In en, this message translates to:
  /// **'Our server returned an invalid response.'**
  String get labelFeedback999;

  /// Request submission failure for feedback
  ///
  /// In en, this message translates to:
  /// **'We\'re unable to submit your request.'**
  String get labelFeedback1000;

  /// Title for permission request dialog
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get labelPermissionTitle;

  /// Explanation text for why permissions are needed
  ///
  /// In en, this message translates to:
  /// **'This app requires this permissions to function properly.'**
  String get labelPermissionText;

  /// Miscellaneous category label
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
