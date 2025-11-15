import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

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
    Locale('hi'),
    Locale('mr'),
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @viewOrEditProfile.
  ///
  /// In en, this message translates to:
  /// **'View or edit your profile'**
  String get viewOrEditProfile;

  /// No description provided for @profileTapped.
  ///
  /// In en, this message translates to:
  /// **'Profile tapped'**
  String get profileTapped;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change application language'**
  String get changeLanguage;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose a language'**
  String get chooseLanguage;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableOrDisableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable notifications'**
  String get enableOrDisableNotifications;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @toggleDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle dark theme'**
  String get toggleDarkTheme;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutTapped.
  ///
  /// In en, this message translates to:
  /// **'Logout tapped'**
  String get logoutTapped;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Traffic360'**
  String get appTitle;

  /// No description provided for @roleTitle.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get roleTitle;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @police.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get police;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login with OTP'**
  String get loginTitle;

  /// No description provided for @enterPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneLabel;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to {phone}'**
  String otpSentTo(Object phone);

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @verifyAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify & Continue'**
  String get verifyAndContinue;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds} seconds'**
  String resendIn(Object seconds);

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the code?'**
  String get didNotReceiveCode;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'📞 Please enter a phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @otpSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ OTP sent successfully to {phone}'**
  String otpSentSuccess(Object phone);

  /// No description provided for @otpFailedToSend.
  ///
  /// In en, this message translates to:
  /// **'❌ Failed to send OTP: {error}'**
  String otpFailedToSend(Object error);

  /// No description provided for @enterValidOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 6-digit OTP'**
  String get enterValidOtp;

  /// No description provided for @otpVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'OTP verification failed: {error}'**
  String otpVerificationFailed(Object error);

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'❌ Invalid OTP'**
  String get invalidOtp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'🎉 Welcome back!'**
  String get welcomeBack;

  /// No description provided for @newUserSignup.
  ///
  /// In en, this message translates to:
  /// **'ℹ️ New user – proceed to signup'**
  String get newUserSignup;

  /// No description provided for @policeLoginSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ Police login successful!'**
  String get policeLoginSuccess;

  /// No description provided for @waitingForApproval.
  ///
  /// In en, this message translates to:
  /// **'⏳ Waiting for approval.'**
  String get waitingForApproval;

  /// No description provided for @registerAsPolice.
  ///
  /// In en, this message translates to:
  /// **'📝 Register as police.'**
  String get registerAsPolice;

  /// No description provided for @redirectAdminLogin.
  ///
  /// In en, this message translates to:
  /// **'🔑 Redirecting to admin login'**
  String get redirectAdminLogin;

  /// No description provided for @roleNotFound.
  ///
  /// In en, this message translates to:
  /// **'❌ Role not found'**
  String get roleNotFound;

  /// No description provided for @signup_title.
  ///
  /// In en, this message translates to:
  /// **'Complete Signup'**
  String get signup_title;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @submit_button.
  ///
  /// In en, this message translates to:
  /// **'Submit & Continue'**
  String get submit_button;

  /// No description provided for @all_fields_required.
  ///
  /// In en, this message translates to:
  /// **'All fields are required.'**
  String get all_fields_required;

  /// No description provided for @session_expired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get session_expired;

  /// No description provided for @signup_failed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed'**
  String get signup_failed;

  /// No description provided for @greeting_morning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get greeting_morning;

  /// No description provided for @greeting_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get greeting_afternoon;

  /// No description provided for @greeting_evening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get greeting_evening;

  /// No description provided for @greeting_night.
  ///
  /// In en, this message translates to:
  /// **'Good Night'**
  String get greeting_night;

  /// No description provided for @greeting_user.
  ///
  /// In en, this message translates to:
  /// **'Hi! {userName}'**
  String greeting_user(Object userName);

  /// No description provided for @menu_my_vehicles.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get menu_my_vehicles;

  /// No description provided for @menu_my_challans.
  ///
  /// In en, this message translates to:
  /// **'My Challans'**
  String get menu_my_challans;

  /// No description provided for @menu_pay_challan.
  ///
  /// In en, this message translates to:
  /// **'Pay E-Challan'**
  String get menu_pay_challan;

  /// No description provided for @menu_tow_clamp.
  ///
  /// In en, this message translates to:
  /// **'Tow & Clamp'**
  String get menu_tow_clamp;

  /// No description provided for @menu_grievance.
  ///
  /// In en, this message translates to:
  /// **'Grievance'**
  String get menu_grievance;

  /// No description provided for @menu_report_violation.
  ///
  /// In en, this message translates to:
  /// **'Report Violation'**
  String get menu_report_violation;

  /// No description provided for @menu_traffic_alerts.
  ///
  /// In en, this message translates to:
  /// **'Traffic Alerts'**
  String get menu_traffic_alerts;

  /// No description provided for @menu_road_signs_quiz.
  ///
  /// In en, this message translates to:
  /// **'Road Signs Quiz'**
  String get menu_road_signs_quiz;

  /// No description provided for @menu_offenses_fines.
  ///
  /// In en, this message translates to:
  /// **'Offenses & Fines'**
  String get menu_offenses_fines;

  /// No description provided for @menu_road_signs.
  ///
  /// In en, this message translates to:
  /// **'Road Signs'**
  String get menu_road_signs;

  /// No description provided for @menu_public_notices.
  ///
  /// In en, this message translates to:
  /// **'Public Notices'**
  String get menu_public_notices;

  /// No description provided for @bottom_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottom_home;

  /// No description provided for @bottom_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get bottom_contact;

  /// No description provided for @bottom_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottom_settings;

  /// No description provided for @myVehicles.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get myVehicles;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get addVehicle;

  /// No description provided for @vehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number'**
  String get vehicleNumber;

  /// No description provided for @chassisNumber.
  ///
  /// In en, this message translates to:
  /// **'Chassis No: {number}'**
  String chassisNumber(Object number);

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}'**
  String vehicleType(Object type);

  /// No description provided for @uploadRcDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload RC Document'**
  String get uploadRcDocument;

  /// No description provided for @rcSelected.
  ///
  /// In en, this message translates to:
  /// **'RC Selected'**
  String get rcSelected;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add Vehicle'**
  String get add;

  /// No description provided for @allFieldsRequired.
  ///
  /// In en, this message translates to:
  /// **'All fields are required.'**
  String get allFieldsRequired;

  /// No description provided for @vehicleAdded.
  ///
  /// In en, this message translates to:
  /// **'Vehicle added successfully'**
  String get vehicleAdded;

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed: {error}'**
  String uploadFailed(Object error);

  /// No description provided for @deleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String deleteFailed(Object error);

  /// No description provided for @vehicleDeleted.
  ///
  /// In en, this message translates to:
  /// **'Vehicle deleted successfully'**
  String get vehicleDeleted;

  /// No description provided for @noVehiclesFound.
  ///
  /// In en, this message translates to:
  /// **'No vehicles found.'**
  String get noVehiclesFound;

  /// No description provided for @viewRC.
  ///
  /// In en, this message translates to:
  /// **'View RC'**
  String get viewRC;

  /// No description provided for @deleteVehicle.
  ///
  /// In en, this message translates to:
  /// **'Delete Vehicle'**
  String get deleteVehicle;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}'**
  String type(Object type);

  /// No description provided for @chassisNo.
  ///
  /// In en, this message translates to:
  /// **'Chassis No: {chassis}'**
  String chassisNo(Object chassis);

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String status(Object status);

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @eChallanDashboard.
  ///
  /// In en, this message translates to:
  /// **'E-Challan Dashboard'**
  String get eChallanDashboard;

  /// No description provided for @challanDetails.
  ///
  /// In en, this message translates to:
  /// **'Challan Details'**
  String get challanDetails;

  /// No description provided for @noChallansFound.
  ///
  /// In en, this message translates to:
  /// **'No challans found.'**
  String get noChallansFound;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String amount(Object amount);

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String reason(Object reason);

  /// No description provided for @challanNumber.
  ///
  /// In en, this message translates to:
  /// **'Challan Number: {number}'**
  String challanNumber(Object number);

  /// No description provided for @issuedOn.
  ///
  /// In en, this message translates to:
  /// **'Issued On: {date}'**
  String issuedOn(Object date);

  /// No description provided for @locationUnknown.
  ///
  /// In en, this message translates to:
  /// **'Location: Unknown'**
  String get locationUnknown;

  /// No description provided for @locationResolving.
  ///
  /// In en, this message translates to:
  /// **'Location: Resolving...'**
  String get locationResolving;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String location(Object location);

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @viewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View Receipt'**
  String get viewReceipt;

  /// No description provided for @viewImage.
  ///
  /// In en, this message translates to:
  /// **'View Image'**
  String get viewImage;

  /// No description provided for @unknownVehicle.
  ///
  /// In en, this message translates to:
  /// **'Unknown Vehicle'**
  String get unknownVehicle;

  /// No description provided for @notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_title;

  /// No description provided for @notifications_unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notifications_unread;

  /// No description provided for @notifications_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notifications_all;

  /// No description provided for @notifications_empty.
  ///
  /// In en, this message translates to:
  /// **'No notifications.'**
  String get notifications_empty;

  /// No description provided for @notifications_error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String notifications_error(Object error);

  /// No description provided for @grievance_title.
  ///
  /// In en, this message translates to:
  /// **'Grievance'**
  String get grievance_title;

  /// No description provided for @grievance_challan_title.
  ///
  /// In en, this message translates to:
  /// **'Challan'**
  String get grievance_challan_title;

  /// No description provided for @grievance_challan_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Against Challan'**
  String get grievance_challan_subtitle;

  /// No description provided for @grievance_receipt_title.
  ///
  /// In en, this message translates to:
  /// **'Grievance Receipt'**
  String get grievance_receipt_title;

  /// No description provided for @grievance_receipt_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Against Receipt'**
  String get grievance_receipt_subtitle;

  /// No description provided for @submit_grievance.
  ///
  /// In en, this message translates to:
  /// **'Submit Grievance'**
  String get submit_grievance;

  /// No description provided for @submitted_receipts.
  ///
  /// In en, this message translates to:
  /// **'Submitted Receipts'**
  String get submitted_receipts;

  /// No description provided for @receipt_grievance_form.
  ///
  /// In en, this message translates to:
  /// **'Receipt Grievance Form'**
  String get receipt_grievance_form;

  /// No description provided for @receipt_no.
  ///
  /// In en, this message translates to:
  /// **'Receipt No'**
  String get receipt_no;

  /// No description provided for @challan_no.
  ///
  /// In en, this message translates to:
  /// **'Challan No'**
  String get challan_no;

  /// No description provided for @vehicle_no.
  ///
  /// In en, this message translates to:
  /// **'Vehicle No'**
  String get vehicle_no;

  /// No description provided for @mobile_no.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile_no;

  /// No description provided for @wrong_vehicle_no.
  ///
  /// In en, this message translates to:
  /// **'Wrong Vehicle'**
  String get wrong_vehicle_no;

  /// No description provided for @correct_vehicle_no.
  ///
  /// In en, this message translates to:
  /// **'Correct Vehicle'**
  String get correct_vehicle_no;

  /// No description provided for @chassis_last4.
  ///
  /// In en, this message translates to:
  /// **'Chassis Last 4'**
  String get chassis_last4;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get remarks;

  /// No description provided for @no_grievances_yet.
  ///
  /// In en, this message translates to:
  /// **'No grievance receipts submitted yet.'**
  String get no_grievances_yet;

  /// No description provided for @grievance_success_message.
  ///
  /// In en, this message translates to:
  /// **'Grievance Receipt submitted.'**
  String get grievance_success_message;

  /// No description provided for @title_grievance_challan.
  ///
  /// In en, this message translates to:
  /// **'Grievance Challan'**
  String get title_grievance_challan;

  /// No description provided for @title_grievance_receipt.
  ///
  /// In en, this message translates to:
  /// **'Grievance Receipt'**
  String get title_grievance_receipt;

  /// No description provided for @tab_submit_grievance.
  ///
  /// In en, this message translates to:
  /// **'Submit Grievance'**
  String get tab_submit_grievance;

  /// No description provided for @tab_my_submissions.
  ///
  /// In en, this message translates to:
  /// **'My Submissions'**
  String get tab_my_submissions;

  /// No description provided for @form_grievance_details.
  ///
  /// In en, this message translates to:
  /// **'Grievance Details'**
  String get form_grievance_details;

  /// No description provided for @form_receipt_grievance.
  ///
  /// In en, this message translates to:
  /// **'Receipt Grievance Form'**
  String get form_receipt_grievance;

  /// No description provided for @label_challan_no.
  ///
  /// In en, this message translates to:
  /// **'CHALLAN NO'**
  String get label_challan_no;

  /// No description provided for @label_receipt_no.
  ///
  /// In en, this message translates to:
  /// **'RECEIPT NO'**
  String get label_receipt_no;

  /// No description provided for @label_vehicle_no.
  ///
  /// In en, this message translates to:
  /// **'VEHICLE NO'**
  String get label_vehicle_no;

  /// No description provided for @label_wrong_vehicle_no.
  ///
  /// In en, this message translates to:
  /// **'WRONG VEHICLE NO'**
  String get label_wrong_vehicle_no;

  /// No description provided for @label_correct_vehicle_no.
  ///
  /// In en, this message translates to:
  /// **'CORRECT VEHICLE NO'**
  String get label_correct_vehicle_no;

  /// No description provided for @label_mobile_no.
  ///
  /// In en, this message translates to:
  /// **'MOBILE NO'**
  String get label_mobile_no;

  /// No description provided for @label_chassis_last4.
  ///
  /// In en, this message translates to:
  /// **'CHASSIS LAST 4'**
  String get label_chassis_last4;

  /// No description provided for @label_email.
  ///
  /// In en, this message translates to:
  /// **'EMAIL'**
  String get label_email;

  /// No description provided for @label_reason.
  ///
  /// In en, this message translates to:
  /// **'REASON'**
  String get label_reason;

  /// No description provided for @label_remarks.
  ///
  /// In en, this message translates to:
  /// **'REMARKS'**
  String get label_remarks;

  /// No description provided for @label_amount.
  ///
  /// In en, this message translates to:
  /// **'AMOUNT'**
  String get label_amount;

  /// No description provided for @button_submit_grievance.
  ///
  /// In en, this message translates to:
  /// **'Submit Grievance'**
  String get button_submit_grievance;

  /// No description provided for @snackbar_grievance_challan_submitted.
  ///
  /// In en, this message translates to:
  /// **'Grievance Challan submitted.'**
  String get snackbar_grievance_challan_submitted;

  /// No description provided for @snackbar_grievance_receipt_submitted.
  ///
  /// In en, this message translates to:
  /// **'Grievance Receipt submitted.'**
  String get snackbar_grievance_receipt_submitted;

  /// No description provided for @no_grievances.
  ///
  /// In en, this message translates to:
  /// **'No grievances submitted yet.'**
  String get no_grievances;

  /// No description provided for @no_receipts.
  ///
  /// In en, this message translates to:
  /// **'No grievance receipts found.'**
  String get no_receipts;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @civilian_report_title.
  ///
  /// In en, this message translates to:
  /// **'Civilian Report'**
  String get civilian_report_title;

  /// No description provided for @report_violation.
  ///
  /// In en, this message translates to:
  /// **'Report Violation'**
  String get report_violation;

  /// No description provided for @violation_history.
  ///
  /// In en, this message translates to:
  /// **'Violation History'**
  String get violation_history;

  /// No description provided for @report_incident.
  ///
  /// In en, this message translates to:
  /// **'Report Incident'**
  String get report_incident;

  /// No description provided for @incident_history.
  ///
  /// In en, this message translates to:
  /// **'Incident History'**
  String get incident_history;

  /// No description provided for @challan.
  ///
  /// In en, this message translates to:
  /// **'Challan'**
  String get challan;

  /// No description provided for @challan_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Against Challan'**
  String get challan_subtitle;

  /// No description provided for @receipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receipt;

  /// No description provided for @receipt_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Against Receipt'**
  String get receipt_subtitle;

  /// No description provided for @report_violation_title.
  ///
  /// In en, this message translates to:
  /// **'Report Violation'**
  String get report_violation_title;

  /// No description provided for @report_violation_note.
  ///
  /// In en, this message translates to:
  /// **'Note - Please capture image and number of vehicle and evidence details to help us take appropriate action.'**
  String get report_violation_note;

  /// No description provided for @report_violation_learn_more.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get report_violation_learn_more;

  /// No description provided for @dropdown_violation_type.
  ///
  /// In en, this message translates to:
  /// **'Violation Type'**
  String get dropdown_violation_type;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @vehicle_number.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number'**
  String get vehicle_number;

  /// No description provided for @upload_images_hint.
  ///
  /// In en, this message translates to:
  /// **'Upload up to 3 images:'**
  String get upload_images_hint;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @error_fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Fill all fields and upload at least 1 image.'**
  String get error_fill_all_fields;

  /// No description provided for @success_report_submitted.
  ///
  /// In en, this message translates to:
  /// **'✅ Violation reported successfully.'**
  String get success_report_submitted;

  /// No description provided for @error_submission_failed.
  ///
  /// In en, this message translates to:
  /// **'❌ Submission failed. Please try again later.'**
  String get error_submission_failed;

  /// No description provided for @menu_violation_history.
  ///
  /// In en, this message translates to:
  /// **'Violation History'**
  String get menu_violation_history;

  /// No description provided for @menu_report_incident.
  ///
  /// In en, this message translates to:
  /// **'Report Incident'**
  String get menu_report_incident;

  /// No description provided for @menu_incident_history.
  ///
  /// In en, this message translates to:
  /// **'Incident History'**
  String get menu_incident_history;

  /// No description provided for @offense_screen_title.
  ///
  /// In en, this message translates to:
  /// **'🚦 Offenses & Fines'**
  String get offense_screen_title;

  /// No description provided for @offense_1_title.
  ///
  /// In en, this message translates to:
  /// **'Riding without helmet by Driver (Owner)'**
  String get offense_1_title;

  /// No description provided for @offense_2_title.
  ///
  /// In en, this message translates to:
  /// **'Riding without helmet by Pillion (Owner)'**
  String get offense_2_title;

  /// No description provided for @offense_3_title.
  ///
  /// In en, this message translates to:
  /// **'Passenger Carrier MV without reflectors at front - white / both side - yellow & rear - red'**
  String get offense_3_title;

  /// No description provided for @offense_4_title.
  ///
  /// In en, this message translates to:
  /// **'Driving without valid License'**
  String get offense_4_title;

  /// No description provided for @offense_5_title.
  ///
  /// In en, this message translates to:
  /// **'Driving without valid License Below 16 years'**
  String get offense_5_title;

  /// No description provided for @offense_1_section.
  ///
  /// In en, this message translates to:
  /// **'Sec 129/194(D) MVA'**
  String get offense_1_section;

  /// No description provided for @offense_2_section.
  ///
  /// In en, this message translates to:
  /// **'Sec 129/194(D) MVA'**
  String get offense_2_section;

  /// No description provided for @offense_3_section.
  ///
  /// In en, this message translates to:
  /// **'CMVR 104(1)(iv)/177 MVA'**
  String get offense_3_section;

  /// No description provided for @offense_4_section.
  ///
  /// In en, this message translates to:
  /// **'Sec 3/181 MVA'**
  String get offense_4_section;

  /// No description provided for @offense_5_section.
  ///
  /// In en, this message translates to:
  /// **'Sec 4/181 MVA'**
  String get offense_5_section;

  /// No description provided for @fine_1000.
  ///
  /// In en, this message translates to:
  /// **'Rs 1000'**
  String get fine_1000;

  /// No description provided for @fine_5000.
  ///
  /// In en, this message translates to:
  /// **'Rs 5000'**
  String get fine_5000;

  /// No description provided for @pay_challan_title.
  ///
  /// In en, this message translates to:
  /// **'Pay E-Challan'**
  String get pay_challan_title;

  /// No description provided for @challan_id.
  ///
  /// In en, this message translates to:
  /// **'Challan ID'**
  String get challan_id;

  /// No description provided for @search_by_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle no'**
  String get search_by_vehicle;

  /// No description provided for @search_by_challan.
  ///
  /// In en, this message translates to:
  /// **'Challan no'**
  String get search_by_challan;

  /// No description provided for @pay_button.
  ///
  /// In en, this message translates to:
  /// **'PAY'**
  String get pay_button;

  /// No description provided for @payment_success.
  ///
  /// In en, this message translates to:
  /// **'✅ Payment successful! Receipt downloaded.'**
  String get payment_success;

  /// No description provided for @payment_failed.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Something went wrong: {error}'**
  String payment_failed(Object error);

  /// No description provided for @no_vehicle_found.
  ///
  /// In en, this message translates to:
  /// **'❌ Vehicle not found. Check inputs.'**
  String get no_vehicle_found;

  /// No description provided for @no_unpaid_challans.
  ///
  /// In en, this message translates to:
  /// **'✅ Vehicle found, but no unpaid challans.'**
  String get no_unpaid_challans;

  /// No description provided for @invalid_challan_id.
  ///
  /// In en, this message translates to:
  /// **'❌ Invalid or already paid challan ID.'**
  String get invalid_challan_id;

  /// No description provided for @invalid_input_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid vehicle number and last 4 digits of chassis.'**
  String get invalid_input_vehicle;

  /// No description provided for @invalid_input_challan.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid challan ID.'**
  String get invalid_input_challan;

  /// No description provided for @receipt_title.
  ///
  /// In en, this message translates to:
  /// **'E-Challan Receipt'**
  String get receipt_title;

  /// No description provided for @receipt_challan_id.
  ///
  /// In en, this message translates to:
  /// **'Challan ID: {id}'**
  String receipt_challan_id(Object id);

  /// No description provided for @receipt_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount Paid: ₹{amount}'**
  String receipt_amount(Object amount);

  /// No description provided for @receipt_reason.
  ///
  /// In en, this message translates to:
  /// **'Reason: {reason}'**
  String receipt_reason(Object reason);

  /// No description provided for @receipt_status.
  ///
  /// In en, this message translates to:
  /// **'Status: Paid'**
  String get receipt_status;

  /// No description provided for @receipt_issued_on.
  ///
  /// In en, this message translates to:
  /// **'Issued On: {date}'**
  String receipt_issued_on(Object date);

  /// No description provided for @receipt_thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your payment.'**
  String get receipt_thank_you;

  /// No description provided for @title_public_notices.
  ///
  /// In en, this message translates to:
  /// **'Public Notices'**
  String get title_public_notices;

  /// No description provided for @label_read_more.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get label_read_more;

  /// No description provided for @tooltip_view_file.
  ///
  /// In en, this message translates to:
  /// **'View File'**
  String get tooltip_view_file;

  /// No description provided for @tooltip_download_file.
  ///
  /// In en, this message translates to:
  /// **'Download File'**
  String get tooltip_download_file;

  /// No description provided for @message_downloaded.
  ///
  /// In en, this message translates to:
  /// **'Downloaded to: {filePath}'**
  String message_downloaded(Object filePath);

  /// No description provided for @message_download_failed.
  ///
  /// In en, this message translates to:
  /// **'Download failed'**
  String get message_download_failed;

  /// No description provided for @message_download_error.
  ///
  /// In en, this message translates to:
  /// **'Download error: {error}'**
  String message_download_error(Object error);

  /// No description provided for @message_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Storage permission denied'**
  String get message_permission_denied;

  /// No description provided for @message_could_not_open_file.
  ///
  /// In en, this message translates to:
  /// **'Could not open the file'**
  String get message_could_not_open_file;

  /// No description provided for @dialog_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get dialog_close;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error_loading_notices.
  ///
  /// In en, this message translates to:
  /// **'Error loading notices.'**
  String get error_loading_notices;

  /// No description provided for @road_signs_title.
  ///
  /// In en, this message translates to:
  /// **'Road Signs'**
  String get road_signs_title;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @no_entry.
  ///
  /// In en, this message translates to:
  /// **'No Entry'**
  String get no_entry;

  /// No description provided for @no_u_turn.
  ///
  /// In en, this message translates to:
  /// **'U Turn Prohibited'**
  String get no_u_turn;

  /// No description provided for @no_overtaking.
  ///
  /// In en, this message translates to:
  /// **'Overtaking Prohibited'**
  String get no_overtaking;

  /// No description provided for @speed_limit.
  ///
  /// In en, this message translates to:
  /// **'Speed Limit'**
  String get speed_limit;

  /// No description provided for @right_hand_curve.
  ///
  /// In en, this message translates to:
  /// **'Right Hand Curve'**
  String get right_hand_curve;

  /// No description provided for @pedestrian_crossing.
  ///
  /// In en, this message translates to:
  /// **'Pedestrian Crossing'**
  String get pedestrian_crossing;

  /// No description provided for @school_ahead.
  ///
  /// In en, this message translates to:
  /// **'School Ahead'**
  String get school_ahead;

  /// No description provided for @no_right_turn.
  ///
  /// In en, this message translates to:
  /// **'Right Turn Prohibited'**
  String get no_right_turn;

  /// No description provided for @slippery_road.
  ///
  /// In en, this message translates to:
  /// **'Slippery Road'**
  String get slippery_road;

  /// No description provided for @y_intersection.
  ///
  /// In en, this message translates to:
  /// **'Y - Intersection'**
  String get y_intersection;

  /// No description provided for @narrow_bridge.
  ///
  /// In en, this message translates to:
  /// **'Narrow Bridge Ahead'**
  String get narrow_bridge;

  /// No description provided for @left_hand_curve.
  ///
  /// In en, this message translates to:
  /// **'Left Hand Curve'**
  String get left_hand_curve;

  /// No description provided for @railway_crossing.
  ///
  /// In en, this message translates to:
  /// **'Railway Crossing'**
  String get railway_crossing;

  /// No description provided for @roundabout.
  ///
  /// In en, this message translates to:
  /// **'Roundabout'**
  String get roundabout;

  /// No description provided for @no_horn.
  ///
  /// In en, this message translates to:
  /// **'No Horn'**
  String get no_horn;

  /// No description provided for @cattle_crossing.
  ///
  /// In en, this message translates to:
  /// **'Cattle Crossing'**
  String get cattle_crossing;

  /// No description provided for @quiz_title.
  ///
  /// In en, this message translates to:
  /// **'🚦 Road Sign Quiz'**
  String get quiz_title;

  /// No description provided for @error_loading.
  ///
  /// In en, this message translates to:
  /// **'Error loading quiz.'**
  String get error_loading;

  /// No description provided for @no_questions.
  ///
  /// In en, this message translates to:
  /// **'No quiz questions found.'**
  String get no_questions;

  /// No description provided for @quiz_completed.
  ///
  /// In en, this message translates to:
  /// **'🎉 Quiz Completed!'**
  String get quiz_completed;

  /// No description provided for @your_score.
  ///
  /// In en, this message translates to:
  /// **'Your Score: {score} / {total}'**
  String your_score(Object score, Object total);

  /// No description provided for @restart_quiz.
  ///
  /// In en, this message translates to:
  /// **'Restart Quiz'**
  String get restart_quiz;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'❌ Incorrect. Correct answer: {answer}'**
  String incorrect(Object answer);

  /// No description provided for @explanation.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String explanation(Object text);

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @contact_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_title;

  /// No description provided for @contact_help.
  ///
  /// In en, this message translates to:
  /// **'Need Help or Support?'**
  String get contact_help;

  /// No description provided for @contact_helpline.
  ///
  /// In en, this message translates to:
  /// **'Traffic Helpline'**
  String get contact_helpline;

  /// No description provided for @contact_phone.
  ///
  /// In en, this message translates to:
  /// **'1800-123-456'**
  String get contact_phone;

  /// No description provided for @contact_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get contact_email_label;

  /// No description provided for @contact_email.
  ///
  /// In en, this message translates to:
  /// **'support@traffic360.in'**
  String get contact_email;

  /// No description provided for @contact_office_label.
  ///
  /// In en, this message translates to:
  /// **'Office Address'**
  String get contact_office_label;

  /// No description provided for @contact_office.
  ///
  /// In en, this message translates to:
  /// **'Traffic Control HQ, Mumbai\nMaharashtra, India'**
  String get contact_office;

  /// No description provided for @contact_hours_label.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get contact_hours_label;

  /// No description provided for @contact_hours.
  ///
  /// In en, this message translates to:
  /// **'Mon–Sat: 9 AM to 6 PM'**
  String get contact_hours;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get nav_contact;

  /// No description provided for @nav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nav_settings;

  /// No description provided for @challan_title.
  ///
  /// In en, this message translates to:
  /// **'E-Challan'**
  String get challan_title;

  /// No description provided for @paid_challans.
  ///
  /// In en, this message translates to:
  /// **'Paid Challans'**
  String get paid_challans;

  /// No description provided for @unpaid_challans.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Challans'**
  String get unpaid_challans;

  /// No description provided for @no_challans.
  ///
  /// In en, this message translates to:
  /// **'No grievances found.'**
  String get no_challans;

  /// No description provided for @loading_challans.
  ///
  /// In en, this message translates to:
  /// **'Loading challans...'**
  String get loading_challans;

  /// No description provided for @challan_details.
  ///
  /// In en, this message translates to:
  /// **'Challan Details'**
  String get challan_details;

  /// No description provided for @filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filter_all;

  /// No description provided for @filter_paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get filter_paid;

  /// No description provided for @filter_unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get filter_unpaid;

  /// No description provided for @issued_on.
  ///
  /// In en, this message translates to:
  /// **'Issued On'**
  String get issued_on;

  /// No description provided for @no_challans_found.
  ///
  /// In en, this message translates to:
  /// **'No challans found'**
  String get no_challans_found;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications found'**
  String get no_notifications;

  /// No description provided for @mark_as_read.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get mark_as_read;

  /// No description provided for @new_notification.
  ///
  /// In en, this message translates to:
  /// **'New Notification'**
  String get new_notification;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @search_by.
  ///
  /// In en, this message translates to:
  /// **'Search by'**
  String get search_by;

  /// No description provided for @chassis_last_4.
  ///
  /// In en, this message translates to:
  /// **'Last 4 digits of Chassis No'**
  String get chassis_last_4;

  /// No description provided for @challan_number.
  ///
  /// In en, this message translates to:
  /// **'Challan #:'**
  String get challan_number;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @enter_vehicle_number.
  ///
  /// In en, this message translates to:
  /// **'Enter vehicle number'**
  String get enter_vehicle_number;

  /// No description provided for @enter_chassis_last_4.
  ///
  /// In en, this message translates to:
  /// **'Enter last 4 digits of chassis'**
  String get enter_chassis_last_4;

  /// No description provided for @enter_challan_number.
  ///
  /// In en, this message translates to:
  /// **'Enter challan number'**
  String get enter_challan_number;

  /// No description provided for @violation_type.
  ///
  /// In en, this message translates to:
  /// **'Violation Type'**
  String get violation_type;

  /// No description provided for @upload_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo (optional)'**
  String get upload_photo;

  /// No description provided for @enter_description.
  ///
  /// In en, this message translates to:
  /// **'Enter description'**
  String get enter_description;

  /// No description provided for @select_violation_type.
  ///
  /// In en, this message translates to:
  /// **'Select violation type'**
  String get select_violation_type;

  /// No description provided for @violation_submitted.
  ///
  /// In en, this message translates to:
  /// **'Violation report submitted successfully'**
  String get violation_submitted;

  /// No description provided for @police_login_title.
  ///
  /// In en, this message translates to:
  /// **'Police Login with OTP'**
  String get police_login_title;

  /// No description provided for @enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter your police phone number'**
  String get enter_phone;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @send_otp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get send_otp;

  /// No description provided for @otp_sent_to.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to'**
  String get otp_sent_to;

  /// No description provided for @enter_otp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enter_otp;

  /// No description provided for @verify_continue.
  ///
  /// In en, this message translates to:
  /// **'Verify & Continue'**
  String get verify_continue;

  /// No description provided for @resend_code_question.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the code?'**
  String get resend_code_question;

  /// No description provided for @resend_otp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resend_otp;

  /// No description provided for @otp_sent_success.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully to'**
  String get otp_sent_success;

  /// No description provided for @otp_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP'**
  String get otp_failed;

  /// No description provided for @otp_verification_failed.
  ///
  /// In en, this message translates to:
  /// **'OTP verification failed'**
  String get otp_verification_failed;

  /// No description provided for @otp_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP, try again.'**
  String get otp_invalid;

  /// No description provided for @otp_required.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 6-digit OTP'**
  String get otp_required;

  /// No description provided for @otp_pending_approval.
  ///
  /// In en, this message translates to:
  /// **'Your account is pending approval.'**
  String get otp_pending_approval;

  /// No description provided for @otp_complete_registration.
  ///
  /// In en, this message translates to:
  /// **'Please complete police registration.'**
  String get otp_complete_registration;

  /// No description provided for @otp_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, Officer!'**
  String get otp_welcome;

  /// No description provided for @please_enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get please_enter_phone;

  /// No description provided for @police_waiting_title.
  ///
  /// In en, this message translates to:
  /// **'Awaiting Approval'**
  String get police_waiting_title;

  /// No description provided for @police_waiting_message.
  ///
  /// In en, this message translates to:
  /// **'Your account is pending approval by the admin.\nPlease check back later.'**
  String get police_waiting_message;

  /// No description provided for @police_signup_title.
  ///
  /// In en, this message translates to:
  /// **'Police Signup'**
  String get police_signup_title;

  /// No description provided for @police_id.
  ///
  /// In en, this message translates to:
  /// **'Police ID'**
  String get police_id;

  /// No description provided for @station_code.
  ///
  /// In en, this message translates to:
  /// **'Station Code'**
  String get station_code;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @submit_continue.
  ///
  /// In en, this message translates to:
  /// **'Submit & Continue'**
  String get submit_continue;

  /// No description provided for @signup_error_required.
  ///
  /// In en, this message translates to:
  /// **'All fields are required.'**
  String get signup_error_required;

  /// No description provided for @signup_error_session.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get signup_error_session;

  /// No description provided for @signup_error_failed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed'**
  String get signup_error_failed;

  /// No description provided for @policeSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Police Signup'**
  String get policeSignupTitle;

  /// No description provided for @policeId.
  ///
  /// In en, this message translates to:
  /// **'Police ID'**
  String get policeId;

  /// No description provided for @stationCode.
  ///
  /// In en, this message translates to:
  /// **'Station Code'**
  String get stationCode;

  /// No description provided for @submitContinue.
  ///
  /// In en, this message translates to:
  /// **'Submit & Continue'**
  String get submitContinue;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get sessionExpired;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed'**
  String get signupFailed;

  /// No description provided for @hello_officer.
  ///
  /// In en, this message translates to:
  /// **'Hello, Officer'**
  String get hello_officer;

  /// No description provided for @good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning!'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon!'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening!'**
  String get good_evening;

  /// No description provided for @what_todo.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do today?'**
  String get what_todo;

  /// No description provided for @create_challan.
  ///
  /// In en, this message translates to:
  /// **'Create Challan'**
  String get create_challan;

  /// No description provided for @search_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Search Vehicle'**
  String get search_vehicle;

  /// No description provided for @all_challans.
  ///
  /// In en, this message translates to:
  /// **'All Challans'**
  String get all_challans;

  /// No description provided for @civil_report.
  ///
  /// In en, this message translates to:
  /// **'Civil Report'**
  String get civil_report;

  /// No description provided for @tow_clamp.
  ///
  /// In en, this message translates to:
  /// **'Tow & Clamp'**
  String get tow_clamp;

  /// No description provided for @awaiting_approval.
  ///
  /// In en, this message translates to:
  /// **'Awaiting Approval'**
  String get awaiting_approval;

  /// No description provided for @pending_approval_msg.
  ///
  /// In en, this message translates to:
  /// **'Your account is pending approval by the admin.\nPlease check back later.'**
  String get pending_approval_msg;

  /// No description provided for @police_challans_title.
  ///
  /// In en, this message translates to:
  /// **'My Issued Challans'**
  String get police_challans_title;

  /// No description provided for @status_unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get status_unpaid;

  /// No description provided for @status_paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get status_paid;

  /// No description provided for @status_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get status_cancelled;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @penalty.
  ///
  /// In en, this message translates to:
  /// **'Penalty'**
  String get penalty;

  /// No description provided for @towed.
  ///
  /// In en, this message translates to:
  /// **'Towed'**
  String get towed;

  /// No description provided for @clamped.
  ///
  /// In en, this message translates to:
  /// **'Clamped'**
  String get clamped;

  /// No description provided for @released.
  ///
  /// In en, this message translates to:
  /// **'Released'**
  String get released;

  /// No description provided for @pick_image.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pick_image;

  /// No description provided for @no_image_selected.
  ///
  /// In en, this message translates to:
  /// **'No image selected.'**
  String get no_image_selected;

  /// No description provided for @location_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled.'**
  String get location_disabled;

  /// No description provided for @location_denied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied.'**
  String get location_denied;

  /// No description provided for @location_denied_permanently.
  ///
  /// In en, this message translates to:
  /// **'Location permission permanently denied.'**
  String get location_denied_permanently;

  /// No description provided for @fetch_location_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch location'**
  String get fetch_location_failed;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields and select an image.'**
  String get fill_all_fields;

  /// No description provided for @entry_added.
  ///
  /// In en, this message translates to:
  /// **'Tow/Clamp entry added.'**
  String get entry_added;

  /// No description provided for @upload_failed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get upload_failed;

  /// No description provided for @past_entries.
  ///
  /// In en, this message translates to:
  /// **'Past Tow/Clamp Entries'**
  String get past_entries;

  /// No description provided for @no_entries_found.
  ///
  /// In en, this message translates to:
  /// **'No entries found.'**
  String get no_entries_found;

  /// No description provided for @memo.
  ///
  /// In en, this message translates to:
  /// **'Memo'**
  String get memo;

  /// No description provided for @pending_approval_message.
  ///
  /// In en, this message translates to:
  /// **'Your account is pending approval by the admin.\nPlease check back later.'**
  String get pending_approval_message;

  /// No description provided for @admin_greeting_title.
  ///
  /// In en, this message translates to:
  /// **'Hey! Admin'**
  String get admin_greeting_title;

  /// No description provided for @admin_loading_greeting.
  ///
  /// In en, this message translates to:
  /// **'Loading your greeting…'**
  String get admin_loading_greeting;

  /// No description provided for @admin_good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get admin_good_morning;

  /// No description provided for @admin_good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get admin_good_afternoon;

  /// No description provided for @admin_good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get admin_good_evening;

  /// No description provided for @menu_approve_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Approve Vehicle'**
  String get menu_approve_vehicle;

  /// No description provided for @menu_manage_users.
  ///
  /// In en, this message translates to:
  /// **'Manage Users'**
  String get menu_manage_users;

  /// No description provided for @menu_all_challans.
  ///
  /// In en, this message translates to:
  /// **'All Challans'**
  String get menu_all_challans;

  /// No description provided for @menu_handle_grievances.
  ///
  /// In en, this message translates to:
  /// **'Handle Grievances'**
  String get menu_handle_grievances;

  /// No description provided for @menu_reported_violations.
  ///
  /// In en, this message translates to:
  /// **'Reported Violations'**
  String get menu_reported_violations;

  /// No description provided for @menu_add_quiz.
  ///
  /// In en, this message translates to:
  /// **'Add Quiz'**
  String get menu_add_quiz;

  /// No description provided for @menu_manage_police.
  ///
  /// In en, this message translates to:
  /// **'Manage Police'**
  String get menu_manage_police;

  /// No description provided for @menu_app_settings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get menu_app_settings;

  /// No description provided for @menu_alert_traffic.
  ///
  /// In en, this message translates to:
  /// **'Alert Traffic'**
  String get menu_alert_traffic;

  /// No description provided for @menu_incident.
  ///
  /// In en, this message translates to:
  /// **'Incident'**
  String get menu_incident;

  /// No description provided for @menu_report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get menu_report;

  /// No description provided for @menu_grievance_challan.
  ///
  /// In en, this message translates to:
  /// **'Grievance Challan'**
  String get menu_grievance_challan;

  /// No description provided for @menu_grievance_receipt.
  ///
  /// In en, this message translates to:
  /// **'Grievance Receipt'**
  String get menu_grievance_receipt;

  /// No description provided for @vehicle_approvals.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Approvals'**
  String get vehicle_approvals;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search by ID, station, or region'**
  String get search_hint;

  /// No description provided for @filter_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get filter_pending;

  /// No description provided for @filter_approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get filter_approved;

  /// No description provided for @filter_rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get filter_rejected;

  /// No description provided for @label_vehicle_number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get label_vehicle_number;

  /// No description provided for @label_owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get label_owner;

  /// No description provided for @label_vehicle_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get label_vehicle_type;

  /// No description provided for @label_added_on.
  ///
  /// In en, this message translates to:
  /// **'Added On'**
  String get label_added_on;

  /// No description provided for @button_view_rc.
  ///
  /// In en, this message translates to:
  /// **'View RC Document'**
  String get button_view_rc;

  /// No description provided for @button_approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get button_approve;

  /// No description provided for @button_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get button_reject;

  /// No description provided for @no_vehicles_found.
  ///
  /// In en, this message translates to:
  /// **'No vehicles found.'**
  String get no_vehicles_found;

  /// No description provided for @rc_open_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to open RC document'**
  String get rc_open_error;

  /// No description provided for @manage_police.
  ///
  /// In en, this message translates to:
  /// **'Manage Police Officers'**
  String get manage_police;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @station.
  ///
  /// In en, this message translates to:
  /// **'Station'**
  String get station;

  /// No description provided for @applied_on.
  ///
  /// In en, this message translates to:
  /// **'Applied On'**
  String get applied_on;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @no_officers.
  ///
  /// In en, this message translates to:
  /// **'No police officers found.'**
  String get no_officers;

  /// No description provided for @all_reported_violations.
  ///
  /// In en, this message translates to:
  /// **'All Reported Violations'**
  String get all_reported_violations;

  /// No description provided for @no_violations.
  ///
  /// In en, this message translates to:
  /// **'No violations reported yet.'**
  String get no_violations;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @manage_notices.
  ///
  /// In en, this message translates to:
  /// **'Manage Notices'**
  String get manage_notices;

  /// No description provided for @add_public_notice.
  ///
  /// In en, this message translates to:
  /// **'Add Public Notice'**
  String get add_public_notice;

  /// No description provided for @my_notices.
  ///
  /// In en, this message translates to:
  /// **'My Notices'**
  String get my_notices;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @enter_title.
  ///
  /// In en, this message translates to:
  /// **'Enter a title'**
  String get enter_title;

  /// No description provided for @pick_photo.
  ///
  /// In en, this message translates to:
  /// **'Pick Photo'**
  String get pick_photo;

  /// No description provided for @post_notice.
  ///
  /// In en, this message translates to:
  /// **'Post Notice'**
  String get post_notice;

  /// No description provided for @notice_added.
  ///
  /// In en, this message translates to:
  /// **'✅ Public Notice Added'**
  String get notice_added;

  /// No description provided for @notice_deleted.
  ///
  /// In en, this message translates to:
  /// **'🗑️ Notice Deleted'**
  String get notice_deleted;

  /// No description provided for @delete_notice.
  ///
  /// In en, this message translates to:
  /// **'Delete Notice'**
  String get delete_notice;

  /// No description provided for @delete_notice_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this notice?'**
  String get delete_notice_confirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @no_my_notices.
  ///
  /// In en, this message translates to:
  /// **'No notices posted by you yet'**
  String get no_my_notices;

  /// No description provided for @could_not_open_image.
  ///
  /// In en, this message translates to:
  /// **'Could not open image'**
  String get could_not_open_image;

  /// No description provided for @reported_incidents.
  ///
  /// In en, this message translates to:
  /// **'Reported Incidents'**
  String get reported_incidents;

  /// No description provided for @no_incidents.
  ///
  /// In en, this message translates to:
  /// **'No incidents reported.'**
  String get no_incidents;

  /// No description provided for @incident_type.
  ///
  /// In en, this message translates to:
  /// **'Incident Type'**
  String get incident_type;

  /// No description provided for @vehicle_type.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get vehicle_type;

  /// No description provided for @issued_by.
  ///
  /// In en, this message translates to:
  /// **'Issued By'**
  String get issued_by;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @admin_quiz_upload.
  ///
  /// In en, this message translates to:
  /// **'Admin Quiz Upload'**
  String get admin_quiz_upload;

  /// No description provided for @add_quiz.
  ///
  /// In en, this message translates to:
  /// **'Add Quiz'**
  String get add_quiz;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @option.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get option;

  /// No description provided for @correct_option.
  ///
  /// In en, this message translates to:
  /// **'Correct: Option'**
  String get correct_option;

  /// No description provided for @select_image.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get select_image;

  /// No description provided for @no_quizzes.
  ///
  /// In en, this message translates to:
  /// **'No quizzes found'**
  String get no_quizzes;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @no_question.
  ///
  /// In en, this message translates to:
  /// **'No question'**
  String get no_question;

  /// No description provided for @image_not_supported.
  ///
  /// In en, this message translates to:
  /// **'Image not supported'**
  String get image_not_supported;

  /// No description provided for @traffic_alerts.
  ///
  /// In en, this message translates to:
  /// **'Traffic Alerts'**
  String get traffic_alerts;

  /// No description provided for @alert_type.
  ///
  /// In en, this message translates to:
  /// **'Alert Type'**
  String get alert_type;

  /// No description provided for @pick_datetime.
  ///
  /// In en, this message translates to:
  /// **'Pick Alert Date & Time'**
  String get pick_datetime;

  /// No description provided for @submit_alert.
  ///
  /// In en, this message translates to:
  /// **'Submit Alert'**
  String get submit_alert;

  /// No description provided for @alert_created.
  ///
  /// In en, this message translates to:
  /// **'Alert Created!'**
  String get alert_created;

  /// No description provided for @no_alerts.
  ///
  /// In en, this message translates to:
  /// **'No alerts created yet.'**
  String get no_alerts;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @admin_receipts_title.
  ///
  /// In en, this message translates to:
  /// **'Admin - Grievance Receipts'**
  String get admin_receipts_title;

  /// No description provided for @admin_challans_title.
  ///
  /// In en, this message translates to:
  /// **'Admin - Grievance Challans'**
  String get admin_challans_title;

  /// No description provided for @user_id.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get user_id;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @fill_details.
  ///
  /// In en, this message translates to:
  /// **'Fill the details below'**
  String get fill_details;

  /// No description provided for @reason_offense.
  ///
  /// In en, this message translates to:
  /// **'Reason / Offense'**
  String get reason_offense;

  /// No description provided for @location_autofilled.
  ///
  /// In en, this message translates to:
  /// **'Location (autofilled)'**
  String get location_autofilled;

  /// No description provided for @upload_photo_proof.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo Proof'**
  String get upload_photo_proof;

  /// No description provided for @selected_proof_image.
  ///
  /// In en, this message translates to:
  /// **'Selected proof image:'**
  String get selected_proof_image;

  /// No description provided for @submit_challan.
  ///
  /// In en, this message translates to:
  /// **'Submit Challan'**
  String get submit_challan;

  /// No description provided for @fetch_location_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch location'**
  String get fetch_location_error;

  /// No description provided for @please_fill_fields.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please fill all fields.'**
  String get please_fill_fields;

  /// No description provided for @not_logged_in.
  ///
  /// In en, this message translates to:
  /// **'⚠️ You are not logged in.'**
  String get not_logged_in;

  /// No description provided for @vehicle_not_found.
  ///
  /// In en, this message translates to:
  /// **'No verified vehicle found with this number'**
  String get vehicle_not_found;

  /// No description provided for @challan_created.
  ///
  /// In en, this message translates to:
  /// **'✅ Challan created successfully!'**
  String get challan_created;

  /// No description provided for @error_occurred.
  ///
  /// In en, this message translates to:
  /// **'❌ Error occurred'**
  String get error_occurred;
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
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
