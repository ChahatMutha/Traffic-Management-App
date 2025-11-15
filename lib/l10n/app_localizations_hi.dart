// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get viewOrEditProfile => 'अपनी प्रोफ़ाइल देखें या संपादित करें';

  @override
  String get profileTapped => 'प्रोफ़ाइल टैप की गई';

  @override
  String get language => 'भाषा';

  @override
  String get changeLanguage => 'एप्लिकेशन की भाषा बदलें';

  @override
  String get chooseLanguage => 'भाषा चुनें';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get enableOrDisableNotifications => 'सूचनाएं चालू या बंद करें';

  @override
  String get on => 'चालू';

  @override
  String get off => 'बंद';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get toggleDarkTheme => 'डार्क थीम टॉगल करें';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get logoutTapped => 'लॉगआउट पर टैप किया गया';

  @override
  String get appTitle => 'ट्रॅफिक360';

  @override
  String get roleTitle => 'आप कौन हैं?';

  @override
  String get user => 'उपयोगकर्ता';

  @override
  String get police => 'पुलिस';

  @override
  String get admin => 'व्यवस्थापक';

  @override
  String get loginTitle => 'ओटीपी से लॉगिन करें';

  @override
  String get enterPhoneLabel => 'अपना फ़ोन नंबर दर्ज करें';

  @override
  String get phoneNumber => 'फ़ोन नंबर';

  @override
  String get sendOtp => 'ओटीपी भेजें';

  @override
  String otpSentTo(Object phone) {
    return '$phone पर ओटीपी भेजा गया';
  }

  @override
  String get enterOtp => 'ओटीपी दर्ज करें';

  @override
  String get verifyAndContinue => 'सत्यापित करें और आगे बढ़ें';

  @override
  String resendIn(Object seconds) {
    return '$seconds सेकंड में पुनः भेजें';
  }

  @override
  String get didNotReceiveCode => 'कोड नहीं मिला?';

  @override
  String get resendOtp => 'ओटीपी पुनः भेजें';

  @override
  String get pleaseEnterPhone => '📞 कृपया फ़ोन नंबर दर्ज करें';

  @override
  String otpSentSuccess(Object phone) {
    return '✅ $phone पर ओटीपी सफलतापूर्वक भेजा गया';
  }

  @override
  String otpFailedToSend(Object error) {
    return '❌ ओटीपी भेजने में विफल: $error';
  }

  @override
  String get enterValidOtp => '6-अंकीय वैध ओटीपी दर्ज करें';

  @override
  String otpVerificationFailed(Object error) {
    return 'ओटीपी सत्यापन विफल: $error';
  }

  @override
  String get invalidOtp => '❌ अमान्य ओटीपी';

  @override
  String get welcomeBack => '🎉 फिर से स्वागत है!';

  @override
  String get newUserSignup => 'ℹ️ नया उपयोगकर्ता – साइनअप करें';

  @override
  String get policeLoginSuccess => '✅ पुलिस लॉगिन सफल!';

  @override
  String get waitingForApproval => '⏳ अनुमोदन की प्रतीक्षा कर रहे हैं।';

  @override
  String get registerAsPolice => '📝 पुलिस के रूप में पंजीकरण करें।';

  @override
  String get redirectAdminLogin => '🔑 एडमिन लॉगिन पर जा रहे हैं';

  @override
  String get roleNotFound => '❌ भूमिका नहीं मिली';

  @override
  String get signup_title => 'साइनअप पूरा करें';

  @override
  String get full_name => 'पूरा नाम';

  @override
  String get email => 'ईमेल';

  @override
  String get mobile => 'मोबाइल';

  @override
  String get submit_button => 'सबमिट करें और जारी रखें';

  @override
  String get all_fields_required => 'सभी फ़ील्ड अनिवार्य हैं।';

  @override
  String get session_expired =>
      'सत्र समाप्त हो गया है। कृपया फिर से लॉगिन करें।';

  @override
  String get signup_failed => 'साइनअप विफल हुआ';

  @override
  String get greeting_morning => 'सुप्रभात';

  @override
  String get greeting_afternoon => 'शुभ अपराह्न';

  @override
  String get greeting_evening => 'शुभ संध्या';

  @override
  String get greeting_night => 'शुभ रात्रि';

  @override
  String greeting_user(Object userName) {
    return 'नमस्ते! $userName';
  }

  @override
  String get menu_my_vehicles => 'मेरी गाड़ियाँ';

  @override
  String get menu_my_challans => 'मेरे चालान';

  @override
  String get menu_pay_challan => 'ई-चालान भुगतान करें';

  @override
  String get menu_tow_clamp => 'टो क्लैम्प';

  @override
  String get menu_grievance => 'शिकायत';

  @override
  String get menu_report_violation => 'उल्लंघन की रिपोर्ट करें';

  @override
  String get menu_traffic_alerts => 'ट्रैफिक अलर्ट्स';

  @override
  String get menu_road_signs_quiz => 'सड़क संकेत क्विज';

  @override
  String get menu_offenses_fines => 'अपराध और जुर्माने';

  @override
  String get menu_road_signs => 'सड़क संकेत';

  @override
  String get menu_public_notices => 'सार्वजनिक नोटिस';

  @override
  String get bottom_home => 'होम';

  @override
  String get bottom_contact => 'संपर्क';

  @override
  String get bottom_settings => 'सेटिंग्स';

  @override
  String get myVehicles => 'मेरी गाड़ियाँ';

  @override
  String get addVehicle => 'गाड़ी जोड़ें';

  @override
  String get vehicleNumber => 'गाड़ी नंबर';

  @override
  String chassisNumber(Object number) {
    return 'चेसिस नंबर';
  }

  @override
  String vehicleType(Object type) {
    return 'प्रकार: $type';
  }

  @override
  String get uploadRcDocument => 'आरसी दस्तावेज़ अपलोड करें';

  @override
  String get rcSelected => 'आरसी चुनी गई';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get add => 'गाड़ी जोड़ें';

  @override
  String get allFieldsRequired => 'सभी फ़ील्ड आवश्यक हैं';

  @override
  String get vehicleAdded => 'गाड़ी सफलतापूर्वक जोड़ी गई';

  @override
  String uploadFailed(Object error) {
    return 'अपलोड विफल: $error';
  }

  @override
  String deleteFailed(Object error) {
    return 'हटाना विफल: $error';
  }

  @override
  String get vehicleDeleted => 'गाड़ी सफलतापूर्वक हटाई गई';

  @override
  String get noVehiclesFound => 'कोई गाड़ी नहीं मिली।';

  @override
  String get viewRC => 'आरसी देखें';

  @override
  String get deleteVehicle => 'गाड़ी हटाएं';

  @override
  String type(Object type) {
    return 'प्रकार: $type';
  }

  @override
  String chassisNo(Object chassis) {
    return 'चेसिस नंबर: $chassis';
  }

  @override
  String status(Object status) {
    return 'स्थिति: $status';
  }

  @override
  String get statusApproved => 'स्वीकृत';

  @override
  String get statusRejected => 'अस्वीकृत';

  @override
  String get statusPending => 'प्रतीक्षा में';

  @override
  String get back => 'वापस';

  @override
  String get eChallanDashboard => 'ई-चालान डैशबोर्ड';

  @override
  String get challanDetails => 'चालान विवरण';

  @override
  String get noChallansFound => 'कोई चालान नहीं मिला।';

  @override
  String get paid => 'भुगतान किया गया';

  @override
  String get unpaid => 'बकाया';

  @override
  String amount(Object amount) {
    return '₹$amount';
  }

  @override
  String reason(Object reason) {
    return '$reason';
  }

  @override
  String challanNumber(Object number) {
    return 'चालान नंबर: $number';
  }

  @override
  String issuedOn(Object date) {
    return 'जारी किया गया: $date';
  }

  @override
  String get locationUnknown => 'स्थान: अज्ञात';

  @override
  String get locationResolving => 'स्थान: खोजा जा रहा है...';

  @override
  String location(Object location) {
    return 'स्थान: $location';
  }

  @override
  String get pay => 'भुगतान करें';

  @override
  String get viewReceipt => 'रसीद देखें';

  @override
  String get viewImage => 'छवि देखें';

  @override
  String get unknownVehicle => 'अज्ञात वाहन';

  @override
  String get notifications_title => 'सूचनाएं';

  @override
  String get notifications_unread => 'अपठित';

  @override
  String get notifications_all => 'सभी';

  @override
  String get notifications_empty => 'कोई सूचना नहीं।';

  @override
  String notifications_error(Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get grievance_title => 'शिकायत';

  @override
  String get grievance_challan_title => 'चालान';

  @override
  String get grievance_challan_subtitle => 'चालान के खिलाफ';

  @override
  String get grievance_receipt_title => 'रसीद शिकायत';

  @override
  String get grievance_receipt_subtitle => 'रसीद के खिलाफ';

  @override
  String get submit_grievance => 'शिकायत दर्ज करें';

  @override
  String get submitted_receipts => 'दर्ज की गई रसीदें';

  @override
  String get receipt_grievance_form => 'रसीद शिकायत फॉर्म';

  @override
  String get receipt_no => 'रसीद नंबर';

  @override
  String get challan_no => 'चालान नंबर';

  @override
  String get vehicle_no => 'वाहन नंबर';

  @override
  String get mobile_no => 'मोबाइल नंबर';

  @override
  String get wrong_vehicle_no => 'गलत वाहन नंबर';

  @override
  String get correct_vehicle_no => 'सही वाहन नंबर';

  @override
  String get chassis_last4 => 'चेसिस के अंतिम 4 अंक';

  @override
  String get remarks => 'टिप्पणी';

  @override
  String get no_grievances_yet => 'अभी तक कोई रसीद शिकायत दर्ज नहीं की गई है।';

  @override
  String get grievance_success_message => 'रसीद शिकायत सफलतापूर्वक दर्ज की गई।';

  @override
  String get title_grievance_challan => 'शिकायत चालान';

  @override
  String get title_grievance_receipt => 'शिकायत रसीद';

  @override
  String get tab_submit_grievance => 'शिकायत दर्ज करें';

  @override
  String get tab_my_submissions => 'मेरी शिकायतें';

  @override
  String get form_grievance_details => 'शिकायत विवरण';

  @override
  String get form_receipt_grievance => 'रसीद शिकायत फॉर्म';

  @override
  String get label_challan_no => 'चालान नंबर';

  @override
  String get label_receipt_no => 'रसीद नंबर';

  @override
  String get label_vehicle_no => 'वाहन नंबर';

  @override
  String get label_wrong_vehicle_no => 'गलत वाहन नंबर';

  @override
  String get label_correct_vehicle_no => 'सही वाहन नंबर';

  @override
  String get label_mobile_no => 'मोबाइल नंबर';

  @override
  String get label_chassis_last4 => 'चेसिस के अंतिम 4 अंक';

  @override
  String get label_email => 'ईमेल';

  @override
  String get label_reason => 'कारण';

  @override
  String get label_remarks => 'टिप्पणी';

  @override
  String get label_amount => 'राशि';

  @override
  String get button_submit_grievance => 'शिकायत सबमिट करें';

  @override
  String get snackbar_grievance_challan_submitted =>
      'शिकायत चालान सबमिट किया गया।';

  @override
  String get snackbar_grievance_receipt_submitted => 'शिकायत रसीद सबमिट की गई।';

  @override
  String get no_grievances => 'कोई शिकायत सबमिट नहीं की गई है।';

  @override
  String get no_receipts => 'कोई शिकायत रसीद सबमिट नहीं की गई है।';

  @override
  String get error => 'त्रुटि';

  @override
  String get civilian_report_title => 'नागरिक रिपोर्ट';

  @override
  String get report_violation => 'उल्लंघन रिपोर्ट करें';

  @override
  String get violation_history => 'उल्लंघन इतिहास';

  @override
  String get report_incident => 'घटना रिपोर्ट करें';

  @override
  String get incident_history => 'घटना इतिहास';

  @override
  String get challan => 'चालान';

  @override
  String get challan_subtitle => 'चालान के खिलाफ';

  @override
  String get receipt => 'रसीद';

  @override
  String get receipt_subtitle => 'रसीद के खिलाफ';

  @override
  String get report_violation_title => 'उल्लंघन रिपोर्ट करें';

  @override
  String get report_violation_note =>
      'नोट - कृपया उपयुक्त कार्रवाई के लिए वाहन की छवि और नंबर के साथ साक्ष्य विवरण कैप्चर करें।';

  @override
  String get report_violation_learn_more => 'और जानें';

  @override
  String get dropdown_violation_type => 'उल्लंघन प्रकार';

  @override
  String get description => 'विवरण';

  @override
  String get vehicle_number => 'वाहन नंबर';

  @override
  String get upload_images_hint => 'अधिकतम 3 चित्र अपलोड करें:';

  @override
  String get submit => 'जमा करें';

  @override
  String get error_fill_all_fields =>
      'सभी फ़ील्ड भरें और कम से कम 1 चित्र अपलोड करें।';

  @override
  String get success_report_submitted =>
      '✅ उल्लंघन सफलतापूर्वक रिपोर्ट किया गया।';

  @override
  String get error_submission_failed =>
      '❌ सबमिशन विफल रहा। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get menu_violation_history => 'उल्लंघन इतिहास';

  @override
  String get menu_report_incident => 'Report Incident';

  @override
  String get menu_incident_history => 'घटना इतिहास';

  @override
  String get offense_screen_title => '🚦 अपराध और जुर्माने';

  @override
  String get offense_1_title =>
      'ड्राइवर (मालिक) द्वारा बिना हेलमेट के सवारी करना';

  @override
  String get offense_2_title =>
      'पिलियन (मालिक) द्वारा बिना हेलमेट के सवारी करना';

  @override
  String get offense_3_title =>
      'यात्री वाहनों में सामने-सफेद / दोनों तरफ-पीला और पीछे-लाल रिफ्लेक्टर नहीं';

  @override
  String get offense_4_title => 'मान्य ड्राइविंग लाइसेंस के बिना गाड़ी चलाना';

  @override
  String get offense_5_title =>
      '16 वर्ष से कम उम्र में बिना लाइसेंस के गाड़ी चलाना';

  @override
  String get offense_1_section => 'धारा 129/194(D) मोटर वाहन अधिनियम';

  @override
  String get offense_2_section => 'धारा 129/194(D) मोटर वाहन अधिनियम';

  @override
  String get offense_3_section => 'CMVR 104(1)(iv)/177 मोटर वाहन अधिनियम';

  @override
  String get offense_4_section => 'धारा 3/181 मोटर वाहन अधिनियम';

  @override
  String get offense_5_section => 'धारा 4/181 मोटर वाहन अधिनियम';

  @override
  String get fine_1000 => '₹1000';

  @override
  String get fine_5000 => '₹5000';

  @override
  String get pay_challan_title => 'ई-चालान का भुगतान करें';

  @override
  String get challan_id => 'चालान आईडी';

  @override
  String get search_by_vehicle => 'वाहन नंबर';

  @override
  String get search_by_challan => 'चालान नंबर';

  @override
  String get pay_button => 'भुगतान करें';

  @override
  String get payment_success => '✅ भुगतान सफल! रसीद डाउनलोड की गई।';

  @override
  String payment_failed(Object error) {
    return '⚠️ कुछ गलत हो गया: $error';
  }

  @override
  String get no_vehicle_found => '❌ वाहन नहीं मिला। कृपया इनपुट जांचें।';

  @override
  String get no_unpaid_challans => '✅ वाहन मिला, लेकिन कोई अवैतनिक चालान नहीं।';

  @override
  String get invalid_challan_id =>
      '❌ अवैध या पहले से भुगतान किया गया चालान ID।';

  @override
  String get invalid_input_vehicle =>
      'कृपया मान्य वाहन नंबर और चेसिस के अंतिम 4 अंक दर्ज करें।';

  @override
  String get invalid_input_challan => 'कृपया मान्य चालान ID दर्ज करें।';

  @override
  String get receipt_title => 'ई-चालान रसीद';

  @override
  String receipt_challan_id(Object id) {
    return 'चालान ID: $id';
  }

  @override
  String receipt_amount(Object amount) {
    return 'भुगतान राशि: ₹$amount';
  }

  @override
  String receipt_reason(Object reason) {
    return 'कारण: $reason';
  }

  @override
  String get receipt_status => 'स्थिति: भुगतान हो गया';

  @override
  String receipt_issued_on(Object date) {
    return 'जारी दिनांक: $date';
  }

  @override
  String get receipt_thank_you => 'आपके भुगतान के लिए धन्यवाद।';

  @override
  String get title_public_notices => 'सार्वजनिक सूचनाएं';

  @override
  String get label_read_more => 'और पढ़ें';

  @override
  String get tooltip_view_file => 'फ़ाइल देखें';

  @override
  String get tooltip_download_file => 'फ़ाइल डाउनलोड करें';

  @override
  String message_downloaded(Object filePath) {
    return '$filePath पर डाउनलोड किया गया';
  }

  @override
  String get message_download_failed => 'डाउनलोड विफल';

  @override
  String message_download_error(Object error) {
    return 'डाउनलोड त्रुटि: $error';
  }

  @override
  String get message_permission_denied => 'स्टोरेज अनुमति अस्वीकृत';

  @override
  String get message_could_not_open_file => 'फ़ाइल नहीं खोल सके';

  @override
  String get dialog_close => 'बंद करें';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get error_loading_notices => 'सूचनाएं लोड करने में त्रुटि।';

  @override
  String get road_signs_title => 'सड़क संकेत';

  @override
  String get stop => 'रुको';

  @override
  String get no_entry => 'प्रवेश निषेध';

  @override
  String get no_u_turn => 'यू टर्न निषेध';

  @override
  String get no_overtaking => 'ओवरटेकिंग निषेध';

  @override
  String get speed_limit => 'गति सीमा';

  @override
  String get right_hand_curve => 'दाहिनी ओर मोड़';

  @override
  String get pedestrian_crossing => 'पैदल पार पथ';

  @override
  String get school_ahead => 'आगे स्कूल है';

  @override
  String get no_right_turn => 'दायाँ मोड़ निषेध';

  @override
  String get slippery_road => 'फिसलन भरी सड़क';

  @override
  String get y_intersection => 'Y-जंक्शन';

  @override
  String get narrow_bridge => 'संकीर्ण पुल आगे';

  @override
  String get left_hand_curve => 'बाईं ओर मोड़';

  @override
  String get railway_crossing => 'रेलवे क्रॉसिंग';

  @override
  String get roundabout => 'राउंडअबाउट';

  @override
  String get no_horn => 'हॉर्न निषेध';

  @override
  String get cattle_crossing => 'पशु पार पथ';

  @override
  String get quiz_title => '🚦 सड़क संकेत प्रश्नोत्तरी';

  @override
  String get error_loading => 'प्रश्नोत्तरी लोड करने में त्रुटि।';

  @override
  String get no_questions => 'कोई प्रश्न नहीं मिले।';

  @override
  String get quiz_completed => '🎉 प्रश्नोत्तरी समाप्त!';

  @override
  String your_score(Object score, Object total) {
    return 'आपका स्कोर: $score / $total';
  }

  @override
  String get restart_quiz => 'पुनः प्रयास करें';

  @override
  String get correct => '✅ सही!';

  @override
  String incorrect(Object answer) {
    return '❌ गलत। सही उत्तर: $answer';
  }

  @override
  String explanation(Object text) {
    return '📝 स्पष्टीकरण: $text';
  }

  @override
  String get next => 'अगला';

  @override
  String get contact_title => 'संपर्क करें';

  @override
  String get contact_help => 'मदद या सहायता चाहिए?';

  @override
  String get contact_helpline => 'ट्रैफिक हेल्पलाइन';

  @override
  String get contact_phone => '1800-123-456';

  @override
  String get contact_email_label => 'हमें ईमेल करें';

  @override
  String get contact_email => 'support@traffic360.in';

  @override
  String get contact_office_label => 'कार्यालय का पता';

  @override
  String get contact_office =>
      'ट्रैफिक कंट्रोल मुख्यालय, मुंबई\nमहाराष्ट्र, भारत';

  @override
  String get contact_hours_label => 'कार्य समय';

  @override
  String get contact_hours => 'सोम–शनिवार: सुबह 9 बजे से शाम 6 बजे तक';

  @override
  String get nav_home => 'मुखपृष्ठ';

  @override
  String get nav_contact => 'संपर्क';

  @override
  String get nav_settings => 'सेटिंग्स';

  @override
  String get challan_title => 'ई-चालान';

  @override
  String get paid_challans => 'भरे गए चालान';

  @override
  String get unpaid_challans => 'बकाया चालान';

  @override
  String get no_challans => 'कोई चालान नहीं मिला';

  @override
  String get loading_challans => 'चालान लोड हो रहे हैं...';

  @override
  String get challan_details => 'चालान विवरण';

  @override
  String get filter_all => 'सभी';

  @override
  String get filter_paid => 'भरे गए';

  @override
  String get filter_unpaid => 'बकाया';

  @override
  String get issued_on => 'जारी करने की तिथि';

  @override
  String get no_challans_found => 'कोई चालान नहीं मिला';

  @override
  String get no_notifications => 'कोई सूचना नहीं मिली';

  @override
  String get mark_as_read => 'पढ़ा हुआ चिह्नित करें';

  @override
  String get new_notification => 'नई सूचना';

  @override
  String get read => 'पढ़ा गया';

  @override
  String get unread => 'अपढ़';

  @override
  String get search_by => 'खोजें';

  @override
  String get chassis_last_4 => 'चेसिस नंबर के अंतिम 4 अंक';

  @override
  String get challan_number => 'चालान नंबर';

  @override
  String get vehicle => 'वाहन';

  @override
  String get search => 'खोजें';

  @override
  String get enter_vehicle_number => 'वाहन क्रमांक दर्ज करें';

  @override
  String get enter_chassis_last_4 => 'चेसिस के अंतिम 4 अंक दर्ज करें';

  @override
  String get enter_challan_number => 'चालान नंबर दर्ज करें';

  @override
  String get violation_type => 'उल्लंघन प्रकार';

  @override
  String get upload_photo => 'फ़ोटो अपलोड करें (वैकल्पिक)';

  @override
  String get enter_description => 'विवरण दर्ज करें';

  @override
  String get select_violation_type => 'उल्लंघन प्रकार चुनें';

  @override
  String get violation_submitted => 'उल्लंघन रिपोर्ट सफलतापूर्वक सबमिट की गई';

  @override
  String get police_login_title => 'पुलिस लॉगिन (OTP द्वारा)';

  @override
  String get enter_phone => 'अपना पुलिस फ़ोन नंबर दर्ज करें';

  @override
  String get phone_number => 'फ़ोन नंबर';

  @override
  String get send_otp => 'OTP भेजें';

  @override
  String get otp_sent_to => 'OTP भेजा गया';

  @override
  String get enter_otp => 'OTP दर्ज करें';

  @override
  String get verify_continue => 'सत्यापित करें और जारी रखें';

  @override
  String get resend_code_question => 'कोड प्राप्त नहीं हुआ?';

  @override
  String get resend_otp => 'OTP पुनः भेजें';

  @override
  String get otp_sent_success => 'OTP सफलतापूर्वक भेजा गया';

  @override
  String get otp_failed => 'OTP भेजने में विफल';

  @override
  String get otp_verification_failed => 'OTP सत्यापन विफल';

  @override
  String get otp_invalid => 'अमान्य OTP, फिर प्रयास करें।';

  @override
  String get otp_required => '6-अंकों का मान्य OTP दर्ज करें';

  @override
  String get otp_pending_approval => 'आपका खाता अनुमोदन की प्रतीक्षा में है।';

  @override
  String get otp_complete_registration => 'कृपया पुलिस पंजीकरण पूरा करें।';

  @override
  String get otp_welcome => 'स्वागत है, अधिकारी!';

  @override
  String get please_enter_phone => 'कृपया अपना फ़ोन नंबर दर्ज करें';

  @override
  String get police_waiting_title => 'प्रमाणन की प्रतीक्षा';

  @override
  String get police_waiting_message =>
      'आपका खाता व्यवस्थापक द्वारा अनुमोदन की प्रतीक्षा कर रहा है।\nकृपया बाद में पुनः जाँच करें।';

  @override
  String get police_signup_title => 'पुलिस पंजीकरण';

  @override
  String get police_id => 'पुलिस आईडी';

  @override
  String get station_code => 'स्टेशन कोड';

  @override
  String get region => 'क्षेत्र';

  @override
  String get submit_continue => 'सबमिट करें और आगे बढ़ें';

  @override
  String get signup_error_required => 'सभी फ़ील्ड आवश्यक हैं।';

  @override
  String get signup_error_session =>
      'सत्र समाप्त हो गया है। कृपया फिर से लॉगिन करें।';

  @override
  String get signup_error_failed => 'पंजीकरण विफल';

  @override
  String get policeSignupTitle => 'पुलिस साइनअप';

  @override
  String get policeId => 'पुलिस आईडी';

  @override
  String get stationCode => 'स्टेशन कोड';

  @override
  String get submitContinue => 'जमा करें और जारी रखें';

  @override
  String get sessionExpired => 'सत्र समाप्त हो गया। कृपया फिर से लॉगिन करें।';

  @override
  String get signupFailed => 'साइनअप विफल रहा';

  @override
  String get hello_officer => 'नमस्ते, अधिकारी';

  @override
  String get good_morning => 'शुभ प्रभात!';

  @override
  String get good_afternoon => 'शुभ अपराह्न!';

  @override
  String get good_evening => 'शुभ संध्या!';

  @override
  String get what_todo => 'आज आप क्या करना चाहेंगे?';

  @override
  String get create_challan => 'चालान बनाएं';

  @override
  String get search_vehicle => 'वाहन खोजें';

  @override
  String get all_challans => 'सभी चालान';

  @override
  String get civil_report => 'नागरिक रिपोर्ट';

  @override
  String get tow_clamp => 'टो और क्लैम्प';

  @override
  String get awaiting_approval => 'अनुमोदन की प्रतीक्षा';

  @override
  String get pending_approval_msg =>
      'आपका खाता प्रशासक द्वारा अनुमोदन की प्रतीक्षा कर रहा है।\nकृपया बाद में पुनः प्रयास करें।';

  @override
  String get police_challans_title => 'मेरे द्वारा जारी चालान';

  @override
  String get status_unpaid => 'बकाया';

  @override
  String get status_paid => 'भुगतान किया गया';

  @override
  String get status_cancelled => 'रद्द किया गया';

  @override
  String get destination => 'गंतव्य';

  @override
  String get penalty => 'जुर्माना';

  @override
  String get towed => 'टो किया गया';

  @override
  String get clamped => 'क्लैम्प किया गया';

  @override
  String get released => 'रिहा किया गया';

  @override
  String get pick_image => 'छवि चुनें';

  @override
  String get no_image_selected => 'कोई छवि चयनित नहीं की गई।';

  @override
  String get location_disabled => 'स्थान सेवाएं अक्षम हैं।';

  @override
  String get location_denied => 'स्थान की अनुमति अस्वीकार की गई।';

  @override
  String get location_denied_permanently =>
      'स्थान की अनुमति स्थायी रूप से अस्वीकार की गई है।';

  @override
  String get fetch_location_failed => 'स्थान प्राप्त करने में विफल';

  @override
  String get fill_all_fields => 'कृपया सभी फ़ील्ड भरें और छवि चुनें।';

  @override
  String get entry_added => 'टो/क्लैम्प प्रविष्टि जोड़ी गई।';

  @override
  String get upload_failed => 'अपलोड विफल';

  @override
  String get past_entries => 'पिछली टो/क्लैम्प प्रविष्टियाँ';

  @override
  String get no_entries_found => 'कोई प्रविष्टियाँ नहीं मिलीं।';

  @override
  String get memo => 'मेमो';

  @override
  String get pending_approval_message =>
      'आपका खाता व्यवस्थापक द्वारा अनुमोदन लंबित है।\nकृपया बाद में दोबारा जाँच करें।';

  @override
  String get admin_greeting_title => 'नमस्ते! एडमिन';

  @override
  String get admin_loading_greeting => 'आपका अभिवादन लोड हो रहा है…';

  @override
  String get admin_good_morning => 'सुप्रभात';

  @override
  String get admin_good_afternoon => 'नमस्कार';

  @override
  String get admin_good_evening => 'शुभ संध्या';

  @override
  String get menu_approve_vehicle => 'वाहन स्वीकृत करें';

  @override
  String get menu_manage_users => 'यूज़र्स प्रबंधित करें';

  @override
  String get menu_all_challans => 'सभी चालान';

  @override
  String get menu_handle_grievances => 'शिकायतें संभालें';

  @override
  String get menu_reported_violations => 'रिपोर्ट की गई उल्लंघनें';

  @override
  String get menu_add_quiz => 'प्रश्नोत्तरी जोड़ें';

  @override
  String get menu_manage_police => 'पुलिस प्रबंधन';

  @override
  String get menu_app_settings => 'ऐप सेटिंग्स';

  @override
  String get menu_alert_traffic => 'ट्रैफिक अलर्ट';

  @override
  String get menu_incident => 'घटना';

  @override
  String get menu_report => 'रिपोर्ट';

  @override
  String get menu_grievance_challan => 'शिकायत चालान';

  @override
  String get menu_grievance_receipt => 'शिकायत रसीद';

  @override
  String get vehicle_approvals => 'वाहन अनुमोदन';

  @override
  String get search_hint => 'आईडी, स्टेशन या क्षेत्र द्वारा खोजें';

  @override
  String get filter_pending => 'लंबित';

  @override
  String get filter_approved => 'स्वीकृत';

  @override
  String get filter_rejected => 'अस्वीकृत';

  @override
  String get label_vehicle_number => 'नंबर';

  @override
  String get label_owner => 'मालिक';

  @override
  String get label_vehicle_type => 'प्रकार';

  @override
  String get label_added_on => 'जोड़ा गया';

  @override
  String get button_view_rc => 'आरसी दस्तावेज़ देखें';

  @override
  String get button_approve => 'स्वीकृत करें';

  @override
  String get button_reject => 'अस्वीकृत करें';

  @override
  String get no_vehicles_found => 'कोई वाहन नहीं मिला।';

  @override
  String get rc_open_error => 'आरसी दस्तावेज़ नहीं खोल सका';

  @override
  String get manage_police => 'पुलिस अधिकारियों का प्रबंधन करें';

  @override
  String get pending => 'लंबित';

  @override
  String get approved => 'स्वीकृत';

  @override
  String get rejected => 'अस्वीकृत';

  @override
  String get station => 'स्टेशन';

  @override
  String get applied_on => 'आवेदन की तिथि';

  @override
  String get approve => 'स्वीकृत करें';

  @override
  String get reject => 'अस्वीकृत करें';

  @override
  String get no_officers => 'कोई पुलिस अधिकारी नहीं मिले।';

  @override
  String get all_reported_violations => 'सभी रिपोर्ट की गई उल्लंघन';

  @override
  String get no_violations => 'अभी तक कोई उल्लंघन रिपोर्ट नहीं किया गया है।';

  @override
  String get date => 'तारीख';

  @override
  String get image => 'छवि';

  @override
  String get manage_notices => 'नोटिस प्रबंधन करें';

  @override
  String get add_public_notice => 'सार्वजनिक सूचना जोड़ें';

  @override
  String get my_notices => 'मेरे नोटिस';

  @override
  String get title => 'शीर्षक';

  @override
  String get enter_title => 'एक शीर्षक दर्ज करें';

  @override
  String get pick_photo => 'फोटो चुनें';

  @override
  String get post_notice => 'नोटिस पोस्ट करें';

  @override
  String get notice_added => '✅ सार्वजनिक सूचना जोड़ी गई';

  @override
  String get notice_deleted => '🗑️ सूचना हटाई गई';

  @override
  String get delete_notice => 'सूचना हटाएं';

  @override
  String get delete_notice_confirm =>
      'क्या आप वाकई इस सूचना को हटाना चाहते हैं?';

  @override
  String get delete => 'हटाएं';

  @override
  String get no_my_notices => 'आपने अभी तक कोई सूचना पोस्ट नहीं की है';

  @override
  String get could_not_open_image => 'छवि खोलने में विफल';

  @override
  String get reported_incidents => 'रिपोर्ट की गई घटनाएं';

  @override
  String get no_incidents => 'कोई घटनाएं रिपोर्ट नहीं की गईं।';

  @override
  String get incident_type => 'घटना प्रकार';

  @override
  String get vehicle_type => 'वाहन प्रकार';

  @override
  String get issued_by => 'जारीकर्ता';

  @override
  String get all => 'सभी';

  @override
  String get admin_quiz_upload => 'एडमिन क्विज अपलोड';

  @override
  String get add_quiz => 'क्विज जोड़ें';

  @override
  String get question => 'प्रश्न';

  @override
  String get option => 'विकल्प';

  @override
  String get correct_option => 'सही: विकल्प';

  @override
  String get select_image => 'चित्र चुनें';

  @override
  String get no_quizzes => 'कोई क्विज़ नहीं मिला';

  @override
  String get answer => 'उत्तर';

  @override
  String get no_question => 'कोई प्रश्न नहीं';

  @override
  String get image_not_supported => 'चित्र समर्थित नहीं है';

  @override
  String get traffic_alerts => 'यातायात अलर्ट';

  @override
  String get alert_type => 'अलर्ट प्रकार';

  @override
  String get pick_datetime => 'अलर्ट दिनांक और समय चुनें';

  @override
  String get submit_alert => 'अलर्ट सबमिट करें';

  @override
  String get alert_created => 'अलर्ट बनाया गया!';

  @override
  String get no_alerts => 'अभी तक कोई अलर्ट नहीं बनाया गया।';

  @override
  String get time => 'समय';

  @override
  String get admin_receipts_title => 'प्रशासक - शिकायत रसीदें';

  @override
  String get admin_challans_title => 'प्रशासक - शिकायत चालान';

  @override
  String get user_id => 'यूज़र आईडी';

  @override
  String get submitted => 'जमा किया गया';

  @override
  String get fill_details => 'नीचे विवरण भरें';

  @override
  String get reason_offense => 'कारण / अपराध';

  @override
  String get location_autofilled => 'स्थान (स्वतः भरा गया)';

  @override
  String get upload_photo_proof => 'फोटो प्रमाण अपलोड करें';

  @override
  String get selected_proof_image => 'चयनित प्रमाण छवि:';

  @override
  String get submit_challan => 'चालान जमा करें';

  @override
  String get fetch_location_error => 'स्थान प्राप्त करने में विफल';

  @override
  String get please_fill_fields => '⚠️ कृपया सब फ़ील्ड भरें।';

  @override
  String get not_logged_in => '⚠️ आप लॉग इन नहीं हैं।';

  @override
  String get vehicle_not_found => 'इस नंबर का कोई सत्यापित वाहन नहीं मिला';

  @override
  String get challan_created => '✅ चालान सफलतापूर्वक बनाया गया!';

  @override
  String get error_occurred => '❌ त्रुटि';
}
