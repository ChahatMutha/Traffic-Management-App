// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get viewOrEditProfile => 'View or edit your profile';

  @override
  String get profileTapped => 'Profile tapped';

  @override
  String get language => 'Language';

  @override
  String get changeLanguage => 'Change application language';

  @override
  String get chooseLanguage => 'Choose a language';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableOrDisableNotifications => 'Enable or disable notifications';

  @override
  String get on => 'On';

  @override
  String get off => 'Off';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get toggleDarkTheme => 'Toggle dark theme';

  @override
  String get logout => 'Logout';

  @override
  String get logoutTapped => 'Logout tapped';

  @override
  String get appTitle => 'Traffic360';

  @override
  String get roleTitle => 'Who are you?';

  @override
  String get user => 'User';

  @override
  String get police => 'Police';

  @override
  String get admin => 'Admin';

  @override
  String get loginTitle => 'Login with OTP';

  @override
  String get enterPhoneLabel => 'Enter your phone number';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String otpSentTo(Object phone) {
    return 'OTP sent to $phone';
  }

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get verifyAndContinue => 'Verify & Continue';

  @override
  String resendIn(Object seconds) {
    return 'Resend in $seconds seconds';
  }

  @override
  String get didNotReceiveCode => 'Didn’t receive the code?';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get pleaseEnterPhone => '📞 Please enter a phone number';

  @override
  String otpSentSuccess(Object phone) {
    return '✅ OTP sent successfully to $phone';
  }

  @override
  String otpFailedToSend(Object error) {
    return '❌ Failed to send OTP: $error';
  }

  @override
  String get enterValidOtp => 'Enter a valid 6-digit OTP';

  @override
  String otpVerificationFailed(Object error) {
    return 'OTP verification failed: $error';
  }

  @override
  String get invalidOtp => '❌ Invalid OTP';

  @override
  String get welcomeBack => '🎉 Welcome back!';

  @override
  String get newUserSignup => 'ℹ️ New user – proceed to signup';

  @override
  String get policeLoginSuccess => '✅ Police login successful!';

  @override
  String get waitingForApproval => '⏳ Waiting for approval.';

  @override
  String get registerAsPolice => '📝 Register as police.';

  @override
  String get redirectAdminLogin => '🔑 Redirecting to admin login';

  @override
  String get roleNotFound => '❌ Role not found';

  @override
  String get signup_title => 'Complete Signup';

  @override
  String get full_name => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get mobile => 'Mobile';

  @override
  String get submit_button => 'Submit & Continue';

  @override
  String get all_fields_required => 'All fields are required.';

  @override
  String get session_expired => 'Session expired. Please login again.';

  @override
  String get signup_failed => 'Signup failed';

  @override
  String get greeting_morning => 'Good Morning';

  @override
  String get greeting_afternoon => 'Good Afternoon';

  @override
  String get greeting_evening => 'Good Evening';

  @override
  String get greeting_night => 'Good Night';

  @override
  String greeting_user(Object userName) {
    return 'Hi! $userName';
  }

  @override
  String get menu_my_vehicles => 'My Vehicles';

  @override
  String get menu_my_challans => 'My Challans';

  @override
  String get menu_pay_challan => 'Pay E-Challan';

  @override
  String get menu_tow_clamp => 'Tow & Clamp';

  @override
  String get menu_grievance => 'Grievance';

  @override
  String get menu_report_violation => 'Report Violation';

  @override
  String get menu_traffic_alerts => 'Traffic Alerts';

  @override
  String get menu_road_signs_quiz => 'Road Signs Quiz';

  @override
  String get menu_offenses_fines => 'Offenses & Fines';

  @override
  String get menu_road_signs => 'Road Signs';

  @override
  String get menu_public_notices => 'Public Notices';

  @override
  String get bottom_home => 'Home';

  @override
  String get bottom_contact => 'Contact';

  @override
  String get bottom_settings => 'Settings';

  @override
  String get myVehicles => 'My Vehicles';

  @override
  String get addVehicle => 'Add Vehicle';

  @override
  String get vehicleNumber => 'Vehicle Number';

  @override
  String chassisNumber(Object number) {
    return 'Chassis No: $number';
  }

  @override
  String vehicleType(Object type) {
    return 'Type: $type';
  }

  @override
  String get uploadRcDocument => 'Upload RC Document';

  @override
  String get rcSelected => 'RC Selected';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add Vehicle';

  @override
  String get allFieldsRequired => 'All fields are required.';

  @override
  String get vehicleAdded => 'Vehicle added successfully';

  @override
  String uploadFailed(Object error) {
    return 'Upload failed: $error';
  }

  @override
  String deleteFailed(Object error) {
    return 'Delete failed: $error';
  }

  @override
  String get vehicleDeleted => 'Vehicle deleted successfully';

  @override
  String get noVehiclesFound => 'No vehicles found.';

  @override
  String get viewRC => 'View RC';

  @override
  String get deleteVehicle => 'Delete Vehicle';

  @override
  String type(Object type) {
    return 'Type: $type';
  }

  @override
  String chassisNo(Object chassis) {
    return 'Chassis No: $chassis';
  }

  @override
  String status(Object status) {
    return 'Status';
  }

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get statusPending => 'Pending';

  @override
  String get back => 'Back';

  @override
  String get eChallanDashboard => 'E-Challan Dashboard';

  @override
  String get challanDetails => 'Challan Details';

  @override
  String get noChallansFound => 'No challans found.';

  @override
  String get paid => 'Paid';

  @override
  String get unpaid => 'Unpaid';

  @override
  String amount(Object amount) {
    return 'Amount';
  }

  @override
  String reason(Object reason) {
    return 'Reason';
  }

  @override
  String challanNumber(Object number) {
    return 'Challan Number: $number';
  }

  @override
  String issuedOn(Object date) {
    return 'Issued On: $date';
  }

  @override
  String get locationUnknown => 'Location: Unknown';

  @override
  String get locationResolving => 'Location: Resolving...';

  @override
  String location(Object location) {
    return 'Location';
  }

  @override
  String get pay => 'Pay';

  @override
  String get viewReceipt => 'View Receipt';

  @override
  String get viewImage => 'View Image';

  @override
  String get unknownVehicle => 'Unknown Vehicle';

  @override
  String get notifications_title => 'Notifications';

  @override
  String get notifications_unread => 'Unread';

  @override
  String get notifications_all => 'All';

  @override
  String get notifications_empty => 'No notifications.';

  @override
  String notifications_error(Object error) {
    return 'Error: $error';
  }

  @override
  String get grievance_title => 'Grievance';

  @override
  String get grievance_challan_title => 'Challan';

  @override
  String get grievance_challan_subtitle => 'Against Challan';

  @override
  String get grievance_receipt_title => 'Grievance Receipt';

  @override
  String get grievance_receipt_subtitle => 'Against Receipt';

  @override
  String get submit_grievance => 'Submit Grievance';

  @override
  String get submitted_receipts => 'Submitted Receipts';

  @override
  String get receipt_grievance_form => 'Receipt Grievance Form';

  @override
  String get receipt_no => 'Receipt No';

  @override
  String get challan_no => 'Challan No';

  @override
  String get vehicle_no => 'Vehicle No';

  @override
  String get mobile_no => 'Mobile';

  @override
  String get wrong_vehicle_no => 'Wrong Vehicle';

  @override
  String get correct_vehicle_no => 'Correct Vehicle';

  @override
  String get chassis_last4 => 'Chassis Last 4';

  @override
  String get remarks => 'Remarks';

  @override
  String get no_grievances_yet => 'No grievance receipts submitted yet.';

  @override
  String get grievance_success_message => 'Grievance Receipt submitted.';

  @override
  String get title_grievance_challan => 'Grievance Challan';

  @override
  String get title_grievance_receipt => 'Grievance Receipt';

  @override
  String get tab_submit_grievance => 'Submit Grievance';

  @override
  String get tab_my_submissions => 'My Submissions';

  @override
  String get form_grievance_details => 'Grievance Details';

  @override
  String get form_receipt_grievance => 'Receipt Grievance Form';

  @override
  String get label_challan_no => 'CHALLAN NO';

  @override
  String get label_receipt_no => 'RECEIPT NO';

  @override
  String get label_vehicle_no => 'VEHICLE NO';

  @override
  String get label_wrong_vehicle_no => 'WRONG VEHICLE NO';

  @override
  String get label_correct_vehicle_no => 'CORRECT VEHICLE NO';

  @override
  String get label_mobile_no => 'MOBILE NO';

  @override
  String get label_chassis_last4 => 'CHASSIS LAST 4';

  @override
  String get label_email => 'EMAIL';

  @override
  String get label_reason => 'REASON';

  @override
  String get label_remarks => 'REMARKS';

  @override
  String get label_amount => 'AMOUNT';

  @override
  String get button_submit_grievance => 'Submit Grievance';

  @override
  String get snackbar_grievance_challan_submitted =>
      'Grievance Challan submitted.';

  @override
  String get snackbar_grievance_receipt_submitted =>
      'Grievance Receipt submitted.';

  @override
  String get no_grievances => 'No grievances submitted yet.';

  @override
  String get no_receipts => 'No grievance receipts found.';

  @override
  String get error => 'Error';

  @override
  String get civilian_report_title => 'Civilian Report';

  @override
  String get report_violation => 'Report Violation';

  @override
  String get violation_history => 'Violation History';

  @override
  String get report_incident => 'Report Incident';

  @override
  String get incident_history => 'Incident History';

  @override
  String get challan => 'Challan';

  @override
  String get challan_subtitle => 'Against Challan';

  @override
  String get receipt => 'Receipt';

  @override
  String get receipt_subtitle => 'Against Receipt';

  @override
  String get report_violation_title => 'Report Violation';

  @override
  String get report_violation_note =>
      'Note - Please capture image and number of vehicle and evidence details to help us take appropriate action.';

  @override
  String get report_violation_learn_more => 'Learn more';

  @override
  String get dropdown_violation_type => 'Violation Type';

  @override
  String get description => 'Description';

  @override
  String get vehicle_number => 'Vehicle Number';

  @override
  String get upload_images_hint => 'Upload up to 3 images:';

  @override
  String get submit => 'Submit';

  @override
  String get error_fill_all_fields =>
      'Fill all fields and upload at least 1 image.';

  @override
  String get success_report_submitted => '✅ Violation reported successfully.';

  @override
  String get error_submission_failed =>
      '❌ Submission failed. Please try again later.';

  @override
  String get menu_violation_history => 'Violation History';

  @override
  String get menu_report_incident => 'Report Incident';

  @override
  String get menu_incident_history => 'Incident History';

  @override
  String get offense_screen_title => '🚦 Offenses & Fines';

  @override
  String get offense_1_title => 'Riding without helmet by Driver (Owner)';

  @override
  String get offense_2_title => 'Riding without helmet by Pillion (Owner)';

  @override
  String get offense_3_title =>
      'Passenger Carrier MV without reflectors at front - white / both side - yellow & rear - red';

  @override
  String get offense_4_title => 'Driving without valid License';

  @override
  String get offense_5_title => 'Driving without valid License Below 16 years';

  @override
  String get offense_1_section => 'Sec 129/194(D) MVA';

  @override
  String get offense_2_section => 'Sec 129/194(D) MVA';

  @override
  String get offense_3_section => 'CMVR 104(1)(iv)/177 MVA';

  @override
  String get offense_4_section => 'Sec 3/181 MVA';

  @override
  String get offense_5_section => 'Sec 4/181 MVA';

  @override
  String get fine_1000 => 'Rs 1000';

  @override
  String get fine_5000 => 'Rs 5000';

  @override
  String get pay_challan_title => 'Pay E-Challan';

  @override
  String get challan_id => 'Challan ID';

  @override
  String get search_by_vehicle => 'Vehicle no';

  @override
  String get search_by_challan => 'Challan no';

  @override
  String get pay_button => 'PAY';

  @override
  String get payment_success => '✅ Payment successful! Receipt downloaded.';

  @override
  String payment_failed(Object error) {
    return '⚠️ Something went wrong: $error';
  }

  @override
  String get no_vehicle_found => '❌ Vehicle not found. Check inputs.';

  @override
  String get no_unpaid_challans => '✅ Vehicle found, but no unpaid challans.';

  @override
  String get invalid_challan_id => '❌ Invalid or already paid challan ID.';

  @override
  String get invalid_input_vehicle =>
      'Please enter valid vehicle number and last 4 digits of chassis.';

  @override
  String get invalid_input_challan => 'Please enter a valid challan ID.';

  @override
  String get receipt_title => 'E-Challan Receipt';

  @override
  String receipt_challan_id(Object id) {
    return 'Challan ID: $id';
  }

  @override
  String receipt_amount(Object amount) {
    return 'Amount Paid: ₹$amount';
  }

  @override
  String receipt_reason(Object reason) {
    return 'Reason: $reason';
  }

  @override
  String get receipt_status => 'Status: Paid';

  @override
  String receipt_issued_on(Object date) {
    return 'Issued On: $date';
  }

  @override
  String get receipt_thank_you => 'Thank you for your payment.';

  @override
  String get title_public_notices => 'Public Notices';

  @override
  String get label_read_more => 'Read More';

  @override
  String get tooltip_view_file => 'View File';

  @override
  String get tooltip_download_file => 'Download File';

  @override
  String message_downloaded(Object filePath) {
    return 'Downloaded to: $filePath';
  }

  @override
  String get message_download_failed => 'Download failed';

  @override
  String message_download_error(Object error) {
    return 'Download error: $error';
  }

  @override
  String get message_permission_denied => 'Storage permission denied';

  @override
  String get message_could_not_open_file => 'Could not open the file';

  @override
  String get dialog_close => 'Close';

  @override
  String get loading => 'Loading...';

  @override
  String get error_loading_notices => 'Error loading notices.';

  @override
  String get road_signs_title => 'Road Signs';

  @override
  String get stop => 'Stop';

  @override
  String get no_entry => 'No Entry';

  @override
  String get no_u_turn => 'U Turn Prohibited';

  @override
  String get no_overtaking => 'Overtaking Prohibited';

  @override
  String get speed_limit => 'Speed Limit';

  @override
  String get right_hand_curve => 'Right Hand Curve';

  @override
  String get pedestrian_crossing => 'Pedestrian Crossing';

  @override
  String get school_ahead => 'School Ahead';

  @override
  String get no_right_turn => 'Right Turn Prohibited';

  @override
  String get slippery_road => 'Slippery Road';

  @override
  String get y_intersection => 'Y - Intersection';

  @override
  String get narrow_bridge => 'Narrow Bridge Ahead';

  @override
  String get left_hand_curve => 'Left Hand Curve';

  @override
  String get railway_crossing => 'Railway Crossing';

  @override
  String get roundabout => 'Roundabout';

  @override
  String get no_horn => 'No Horn';

  @override
  String get cattle_crossing => 'Cattle Crossing';

  @override
  String get quiz_title => '🚦 Road Sign Quiz';

  @override
  String get error_loading => 'Error loading quiz.';

  @override
  String get no_questions => 'No quiz questions found.';

  @override
  String get quiz_completed => '🎉 Quiz Completed!';

  @override
  String your_score(Object score, Object total) {
    return 'Your Score: $score / $total';
  }

  @override
  String get restart_quiz => 'Restart Quiz';

  @override
  String get correct => 'Correct';

  @override
  String incorrect(Object answer) {
    return '❌ Incorrect. Correct answer: $answer';
  }

  @override
  String explanation(Object text) {
    return 'Explanation';
  }

  @override
  String get next => 'Next';

  @override
  String get contact_title => 'Contact Us';

  @override
  String get contact_help => 'Need Help or Support?';

  @override
  String get contact_helpline => 'Traffic Helpline';

  @override
  String get contact_phone => '1800-123-456';

  @override
  String get contact_email_label => 'Email Us';

  @override
  String get contact_email => 'support@traffic360.in';

  @override
  String get contact_office_label => 'Office Address';

  @override
  String get contact_office => 'Traffic Control HQ, Mumbai\nMaharashtra, India';

  @override
  String get contact_hours_label => 'Working Hours';

  @override
  String get contact_hours => 'Mon–Sat: 9 AM to 6 PM';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_contact => 'Contact';

  @override
  String get nav_settings => 'Settings';

  @override
  String get challan_title => 'E-Challan';

  @override
  String get paid_challans => 'Paid Challans';

  @override
  String get unpaid_challans => 'Unpaid Challans';

  @override
  String get no_challans => 'No grievances found.';

  @override
  String get loading_challans => 'Loading challans...';

  @override
  String get challan_details => 'Challan Details';

  @override
  String get filter_all => 'All';

  @override
  String get filter_paid => 'Paid';

  @override
  String get filter_unpaid => 'Unpaid';

  @override
  String get issued_on => 'Issued On';

  @override
  String get no_challans_found => 'No challans found';

  @override
  String get no_notifications => 'No notifications found';

  @override
  String get mark_as_read => 'Mark as read';

  @override
  String get new_notification => 'New Notification';

  @override
  String get read => 'Read';

  @override
  String get unread => 'Unread';

  @override
  String get search_by => 'Search by';

  @override
  String get chassis_last_4 => 'Last 4 digits of Chassis No';

  @override
  String get challan_number => 'Challan #:';

  @override
  String get vehicle => 'Vehicle';

  @override
  String get search => 'Search';

  @override
  String get enter_vehicle_number => 'Enter vehicle number';

  @override
  String get enter_chassis_last_4 => 'Enter last 4 digits of chassis';

  @override
  String get enter_challan_number => 'Enter challan number';

  @override
  String get violation_type => 'Violation Type';

  @override
  String get upload_photo => 'Upload Photo (optional)';

  @override
  String get enter_description => 'Enter description';

  @override
  String get select_violation_type => 'Select violation type';

  @override
  String get violation_submitted => 'Violation report submitted successfully';

  @override
  String get police_login_title => 'Police Login with OTP';

  @override
  String get enter_phone => 'Enter your police phone number';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get send_otp => 'Send OTP';

  @override
  String get otp_sent_to => 'OTP sent to';

  @override
  String get enter_otp => 'Enter OTP';

  @override
  String get verify_continue => 'Verify & Continue';

  @override
  String get resend_code_question => 'Didn’t receive the code?';

  @override
  String get resend_otp => 'Resend OTP';

  @override
  String get otp_sent_success => 'OTP sent successfully to';

  @override
  String get otp_failed => 'Failed to send OTP';

  @override
  String get otp_verification_failed => 'OTP verification failed';

  @override
  String get otp_invalid => 'Invalid OTP, try again.';

  @override
  String get otp_required => 'Enter a valid 6-digit OTP';

  @override
  String get otp_pending_approval => 'Your account is pending approval.';

  @override
  String get otp_complete_registration =>
      'Please complete police registration.';

  @override
  String get otp_welcome => 'Welcome back, Officer!';

  @override
  String get please_enter_phone => 'Please enter your phone number';

  @override
  String get police_waiting_title => 'Awaiting Approval';

  @override
  String get police_waiting_message =>
      'Your account is pending approval by the admin.\nPlease check back later.';

  @override
  String get police_signup_title => 'Police Signup';

  @override
  String get police_id => 'Police ID';

  @override
  String get station_code => 'Station Code';

  @override
  String get region => 'Region';

  @override
  String get submit_continue => 'Submit & Continue';

  @override
  String get signup_error_required => 'All fields are required.';

  @override
  String get signup_error_session => 'Session expired. Please login again.';

  @override
  String get signup_error_failed => 'Signup failed';

  @override
  String get policeSignupTitle => 'Police Signup';

  @override
  String get policeId => 'Police ID';

  @override
  String get stationCode => 'Station Code';

  @override
  String get submitContinue => 'Submit & Continue';

  @override
  String get sessionExpired => 'Session expired. Please login again.';

  @override
  String get signupFailed => 'Signup failed';

  @override
  String get hello_officer => 'Hello, Officer';

  @override
  String get good_morning => 'Good morning!';

  @override
  String get good_afternoon => 'Good afternoon!';

  @override
  String get good_evening => 'Good evening!';

  @override
  String get what_todo => 'What would you like to do today?';

  @override
  String get create_challan => 'Create Challan';

  @override
  String get search_vehicle => 'Search Vehicle';

  @override
  String get all_challans => 'All Challans';

  @override
  String get civil_report => 'Civil Report';

  @override
  String get tow_clamp => 'Tow & Clamp';

  @override
  String get awaiting_approval => 'Awaiting Approval';

  @override
  String get pending_approval_msg =>
      'Your account is pending approval by the admin.\nPlease check back later.';

  @override
  String get police_challans_title => 'My Issued Challans';

  @override
  String get status_unpaid => 'Unpaid';

  @override
  String get status_paid => 'Paid';

  @override
  String get status_cancelled => 'Cancelled';

  @override
  String get destination => 'Destination';

  @override
  String get penalty => 'Penalty';

  @override
  String get towed => 'Towed';

  @override
  String get clamped => 'Clamped';

  @override
  String get released => 'Released';

  @override
  String get pick_image => 'Pick Image';

  @override
  String get no_image_selected => 'No image selected.';

  @override
  String get location_disabled => 'Location services are disabled.';

  @override
  String get location_denied => 'Location permission denied.';

  @override
  String get location_denied_permanently =>
      'Location permission permanently denied.';

  @override
  String get fetch_location_failed => 'Failed to fetch location';

  @override
  String get fill_all_fields => 'Please fill all fields and select an image.';

  @override
  String get entry_added => 'Tow/Clamp entry added.';

  @override
  String get upload_failed => 'Upload failed';

  @override
  String get past_entries => 'Past Tow/Clamp Entries';

  @override
  String get no_entries_found => 'No entries found.';

  @override
  String get memo => 'Memo';

  @override
  String get pending_approval_message =>
      'Your account is pending approval by the admin.\nPlease check back later.';

  @override
  String get admin_greeting_title => 'Hey! Admin';

  @override
  String get admin_loading_greeting => 'Loading your greeting…';

  @override
  String get admin_good_morning => 'Good Morning';

  @override
  String get admin_good_afternoon => 'Good Afternoon';

  @override
  String get admin_good_evening => 'Good Evening';

  @override
  String get menu_approve_vehicle => 'Approve Vehicle';

  @override
  String get menu_manage_users => 'Manage Users';

  @override
  String get menu_all_challans => 'All Challans';

  @override
  String get menu_handle_grievances => 'Handle Grievances';

  @override
  String get menu_reported_violations => 'Reported Violations';

  @override
  String get menu_add_quiz => 'Add Quiz';

  @override
  String get menu_manage_police => 'Manage Police';

  @override
  String get menu_app_settings => 'App Settings';

  @override
  String get menu_alert_traffic => 'Alert Traffic';

  @override
  String get menu_incident => 'Incident';

  @override
  String get menu_report => 'Report';

  @override
  String get menu_grievance_challan => 'Grievance Challan';

  @override
  String get menu_grievance_receipt => 'Grievance Receipt';

  @override
  String get vehicle_approvals => 'Vehicle Approvals';

  @override
  String get search_hint => 'Search by ID, station, or region';

  @override
  String get filter_pending => 'Pending';

  @override
  String get filter_approved => 'Approved';

  @override
  String get filter_rejected => 'Rejected';

  @override
  String get label_vehicle_number => 'Number';

  @override
  String get label_owner => 'Owner';

  @override
  String get label_vehicle_type => 'Type';

  @override
  String get label_added_on => 'Added On';

  @override
  String get button_view_rc => 'View RC Document';

  @override
  String get button_approve => 'Approve';

  @override
  String get button_reject => 'Reject';

  @override
  String get no_vehicles_found => 'No vehicles found.';

  @override
  String get rc_open_error => 'Unable to open RC document';

  @override
  String get manage_police => 'Manage Police Officers';

  @override
  String get pending => 'Pending';

  @override
  String get approved => 'Approved';

  @override
  String get rejected => 'Rejected';

  @override
  String get station => 'Station';

  @override
  String get applied_on => 'Applied On';

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get no_officers => 'No police officers found.';

  @override
  String get all_reported_violations => 'All Reported Violations';

  @override
  String get no_violations => 'No violations reported yet.';

  @override
  String get date => 'Date';

  @override
  String get image => 'Image';

  @override
  String get manage_notices => 'Manage Notices';

  @override
  String get add_public_notice => 'Add Public Notice';

  @override
  String get my_notices => 'My Notices';

  @override
  String get title => 'Title';

  @override
  String get enter_title => 'Enter a title';

  @override
  String get pick_photo => 'Pick Photo';

  @override
  String get post_notice => 'Post Notice';

  @override
  String get notice_added => '✅ Public Notice Added';

  @override
  String get notice_deleted => '🗑️ Notice Deleted';

  @override
  String get delete_notice => 'Delete Notice';

  @override
  String get delete_notice_confirm =>
      'Are you sure you want to delete this notice?';

  @override
  String get delete => 'Delete';

  @override
  String get no_my_notices => 'No notices posted by you yet';

  @override
  String get could_not_open_image => 'Could not open image';

  @override
  String get reported_incidents => 'Reported Incidents';

  @override
  String get no_incidents => 'No incidents reported.';

  @override
  String get incident_type => 'Incident Type';

  @override
  String get vehicle_type => 'Vehicle Type';

  @override
  String get issued_by => 'Issued By';

  @override
  String get all => 'All';

  @override
  String get admin_quiz_upload => 'Admin Quiz Upload';

  @override
  String get add_quiz => 'Add Quiz';

  @override
  String get question => 'Question';

  @override
  String get option => 'Option';

  @override
  String get correct_option => 'Correct: Option';

  @override
  String get select_image => 'Select Image';

  @override
  String get no_quizzes => 'No quizzes found';

  @override
  String get answer => 'Answer';

  @override
  String get no_question => 'No question';

  @override
  String get image_not_supported => 'Image not supported';

  @override
  String get traffic_alerts => 'Traffic Alerts';

  @override
  String get alert_type => 'Alert Type';

  @override
  String get pick_datetime => 'Pick Alert Date & Time';

  @override
  String get submit_alert => 'Submit Alert';

  @override
  String get alert_created => 'Alert Created!';

  @override
  String get no_alerts => 'No alerts created yet.';

  @override
  String get time => 'Time';

  @override
  String get admin_receipts_title => 'Admin - Grievance Receipts';

  @override
  String get admin_challans_title => 'Admin - Grievance Challans';

  @override
  String get user_id => 'User ID';

  @override
  String get submitted => 'Submitted';

  @override
  String get fill_details => 'Fill the details below';

  @override
  String get reason_offense => 'Reason / Offense';

  @override
  String get location_autofilled => 'Location (autofilled)';

  @override
  String get upload_photo_proof => 'Upload Photo Proof';

  @override
  String get selected_proof_image => 'Selected proof image:';

  @override
  String get submit_challan => 'Submit Challan';

  @override
  String get fetch_location_error => 'Failed to fetch location';

  @override
  String get please_fill_fields => '⚠️ Please fill all fields.';

  @override
  String get not_logged_in => '⚠️ You are not logged in.';

  @override
  String get vehicle_not_found => 'No verified vehicle found with this number';

  @override
  String get challan_created => '✅ Challan created successfully!';

  @override
  String get error_occurred => '❌ Error occurred';
}
