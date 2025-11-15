// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get settings => 'सेटिंग्ज';

  @override
  String get profile => 'प्रोफाइल';

  @override
  String get viewOrEditProfile => 'तुमची प्रोफाइल पहा किंवा संपादित करा';

  @override
  String get profileTapped => 'प्रोफाइल टॅप केली';

  @override
  String get language => 'भाषा';

  @override
  String get changeLanguage => 'अॅपची भाषा बदला';

  @override
  String get chooseLanguage => 'भाषा निवडा';

  @override
  String get notifications => 'सूचना';

  @override
  String get enableOrDisableNotifications => 'सूचना सुरू किंवा बंद करा';

  @override
  String get on => 'चालू';

  @override
  String get off => 'बंद';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get toggleDarkTheme => 'डार्क थीम बदला';

  @override
  String get logout => 'बाहेर पडा';

  @override
  String get logoutTapped => 'लॉगआउट क्लिक केले';

  @override
  String get appTitle => 'ट्राफिक३६०';

  @override
  String get roleTitle => 'आपण कोण आहात?';

  @override
  String get user => 'वापरकर्ता';

  @override
  String get police => 'पोलीस';

  @override
  String get admin => 'प्रशासक';

  @override
  String get loginTitle => 'ओटीपीने लॉगिन करा';

  @override
  String get enterPhoneLabel => 'आपला फोन नंबर टाका';

  @override
  String get phoneNumber => 'फोन नंबर';

  @override
  String get sendOtp => 'ओटीपी पाठवा';

  @override
  String otpSentTo(Object phone) {
    return '$phone वर ओटीपी पाठवला';
  }

  @override
  String get enterOtp => 'ओटीपी टाका';

  @override
  String get verifyAndContinue => 'सत्यापित करा आणि पुढे जा';

  @override
  String resendIn(Object seconds) {
    return '$seconds सेकंदात पुन्हा पाठवा';
  }

  @override
  String get didNotReceiveCode => 'कोड मिळाला नाही?';

  @override
  String get resendOtp => 'ओटीपी पुन्हा पाठवा';

  @override
  String get pleaseEnterPhone => '📞 कृपया फोन नंबर टाका';

  @override
  String otpSentSuccess(Object phone) {
    return '✅ $phone वर यशस्वीरित्या ओटीपी पाठवला';
  }

  @override
  String otpFailedToSend(Object error) {
    return '❌ ओटीपी पाठवण्यात अयशस्वी: $error';
  }

  @override
  String get enterValidOtp => 'वैध 6-अंकी ओटीपी टाका';

  @override
  String otpVerificationFailed(Object error) {
    return 'ओटीपी सत्यापन अयशस्वी: $error';
  }

  @override
  String get invalidOtp => '❌ अवैध ओटीपी';

  @override
  String get welcomeBack => '🎉 पुन्हा स्वागत आहे!';

  @override
  String get newUserSignup => 'ℹ️ नवीन वापरकर्ता – साइनअप करा';

  @override
  String get policeLoginSuccess => '✅ पोलीस लॉगिन यशस्वी!';

  @override
  String get waitingForApproval => '⏳ मान्यतेची वाट पाहत आहोत.';

  @override
  String get registerAsPolice => '📝 पोलीस म्हणून नोंदणी करा.';

  @override
  String get redirectAdminLogin => '🔑 अ‍ॅडमिन लॉगिनकडे वळत आहे';

  @override
  String get roleNotFound => '❌ भूमिका सापडली नाही';

  @override
  String get signup_title => 'साइनअप पूर्ण करा';

  @override
  String get full_name => 'पूर्ण नाव';

  @override
  String get email => 'ईमेल';

  @override
  String get mobile => 'मोबाईल';

  @override
  String get submit_button => 'सबमिट करा आणि पुढे जा';

  @override
  String get all_fields_required => 'सर्व फील्ड आवश्यक आहेत.';

  @override
  String get session_expired => 'सत्र कालबाह्य झाले. कृपया पुन्हा लॉगिन करा.';

  @override
  String get signup_failed => 'साइनअप अयशस्वी झाला';

  @override
  String get greeting_morning => 'शुभ सकाळ';

  @override
  String get greeting_afternoon => 'शुभ दुपार';

  @override
  String get greeting_evening => 'शुभ संध्याकाळ';

  @override
  String get greeting_night => 'शुभ रात्री';

  @override
  String greeting_user(Object userName) {
    return 'हाय! $userName';
  }

  @override
  String get menu_my_vehicles => 'माझी वाहने';

  @override
  String get menu_my_challans => 'माझे चालान';

  @override
  String get menu_pay_challan => 'ई-चालान भरा';

  @override
  String get menu_tow_clamp => 'टो क्लॅम्प';

  @override
  String get menu_grievance => 'तक्रार';

  @override
  String get menu_report_violation => 'Report Violation';

  @override
  String get menu_traffic_alerts => 'वाहतूक इशारे';

  @override
  String get menu_road_signs_quiz => 'रस्ता चिन्ह क्विझ';

  @override
  String get menu_offenses_fines => 'गुन्हे आणि दंड';

  @override
  String get menu_road_signs => 'रस्ता चिन्ह';

  @override
  String get menu_public_notices => 'सार्वजनिक सूचना';

  @override
  String get bottom_home => 'मुख्यपृष्ठ';

  @override
  String get bottom_contact => 'संपर्क';

  @override
  String get bottom_settings => 'सेटिंग्ज';

  @override
  String get myVehicles => 'माझी वाहने';

  @override
  String get addVehicle => 'वाहन जोडा';

  @override
  String get vehicleNumber => 'Vehicle Number';

  @override
  String chassisNumber(Object number) {
    return 'चेसिस क्रमांक: $number';
  }

  @override
  String vehicleType(Object type) {
    return 'प्रकार: $type';
  }

  @override
  String get uploadRcDocument => 'आरसी दस्तऐवज अपलोड करा';

  @override
  String get rcSelected => 'आरसी निवडली गेली';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get add => 'वाहन जोडा';

  @override
  String get allFieldsRequired => 'सर्व फील्ड आवश्यक आहेत';

  @override
  String get vehicleAdded => 'वाहन यशस्वीरित्या जोडले गेले';

  @override
  String uploadFailed(Object error) {
    return 'अपलोड अयशस्वी: $error';
  }

  @override
  String deleteFailed(Object error) {
    return 'हटवणे अयशस्वी: $error';
  }

  @override
  String get vehicleDeleted => 'वाहन यशस्वीरित्या हटवले गेले';

  @override
  String get noVehiclesFound => 'कोणतेही वाहन सापडले नाही.';

  @override
  String get viewRC => 'आरसी पहा';

  @override
  String get deleteVehicle => 'वाहन हटवा';

  @override
  String type(Object type) {
    return 'प्रकार: $type';
  }

  @override
  String chassisNo(Object chassis) {
    return 'चेसिस क्रमांक: $chassis';
  }

  @override
  String status(Object status) {
    return 'स्थिती: $status';
  }

  @override
  String get statusApproved => 'मंजूर';

  @override
  String get statusRejected => 'नकार';

  @override
  String get statusPending => 'प्रलंबित';

  @override
  String get back => 'मागे';

  @override
  String get eChallanDashboard => 'ई-चालान डॅशबोर्ड';

  @override
  String get challanDetails => 'चालान तपशील';

  @override
  String get noChallansFound => 'कोणतेही चालान आढळले नाहीत.';

  @override
  String get paid => 'भरणा केलेले';

  @override
  String get unpaid => 'अदा न केलेले';

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
    return 'चालान क्रमांक: $number';
  }

  @override
  String issuedOn(Object date) {
    return 'जारी दिनांक: $date';
  }

  @override
  String get locationUnknown => 'स्थान: अज्ञात';

  @override
  String get locationResolving => 'स्थान शोधले जात आहे...';

  @override
  String location(Object location) {
    return 'स्थान: $location';
  }

  @override
  String get pay => 'देय द्या';

  @override
  String get viewReceipt => 'पावती पहा';

  @override
  String get viewImage => 'प्रतिमा पहा';

  @override
  String get unknownVehicle => 'अज्ञात वाहन';

  @override
  String get notifications_title => 'सूचना';

  @override
  String get notifications_unread => 'न वाचलेले';

  @override
  String get notifications_all => 'सर्व';

  @override
  String get notifications_empty => 'सूचना उपलब्ध नाहीत.';

  @override
  String notifications_error(Object error) {
    return 'त्रुटी: $error';
  }

  @override
  String get grievance_title => 'तक्रार';

  @override
  String get grievance_challan_title => 'चालान';

  @override
  String get grievance_challan_subtitle => 'चालान विरोधात';

  @override
  String get grievance_receipt_title => 'पावती तक्रार';

  @override
  String get grievance_receipt_subtitle => 'पावती विरोधात';

  @override
  String get submit_grievance => 'तक्रार सबमिट करा';

  @override
  String get submitted_receipts => 'सबमिट केलेल्या पावत्या';

  @override
  String get receipt_grievance_form => 'पावती तक्रार फॉर्म';

  @override
  String get receipt_no => 'पावती क्रमांक';

  @override
  String get challan_no => 'चालान क्रमांक';

  @override
  String get vehicle_no => 'वाहन क्रमांक';

  @override
  String get mobile_no => 'मोबाईल नंबर';

  @override
  String get wrong_vehicle_no => 'चुकीचा वाहन क्रमांक';

  @override
  String get correct_vehicle_no => 'बरोबर वाहन क्रमांक';

  @override
  String get chassis_last4 => 'चेसिसचे शेवटचे 4 अंक';

  @override
  String get remarks => 'टीप';

  @override
  String get no_grievances_yet =>
      'आत्तापर्यंत कोणतीही पावती तक्रार सादर केलेली नाही.';

  @override
  String get grievance_success_message =>
      'पावती तक्रार यशस्वीरित्या सादर झाली.';

  @override
  String get title_grievance_challan => 'तक्रार चालान';

  @override
  String get title_grievance_receipt => 'तक्रार पावती';

  @override
  String get tab_submit_grievance => 'तक्रार नोंदवा';

  @override
  String get tab_my_submissions => 'माझ्या तक्रारी';

  @override
  String get form_grievance_details => 'तक्रारीचे तपशील';

  @override
  String get form_receipt_grievance => 'पावती तक्रार फॉर्म';

  @override
  String get label_challan_no => 'चालान क्रमांक';

  @override
  String get label_receipt_no => 'पावती क्रमांक';

  @override
  String get label_vehicle_no => 'वाहन क्रमांक';

  @override
  String get label_wrong_vehicle_no => 'चुकीचा वाहन क्रमांक';

  @override
  String get label_correct_vehicle_no => 'योग्य वाहन क्रमांक';

  @override
  String get label_mobile_no => 'मोबाईल क्रमांक';

  @override
  String get label_chassis_last4 => 'चेसिसचे शेवटचे ४ अंक';

  @override
  String get label_email => 'ईमेल';

  @override
  String get label_reason => 'कारण';

  @override
  String get label_remarks => 'शेरा';

  @override
  String get label_amount => 'रक्कम';

  @override
  String get button_submit_grievance => 'तक्रार सबमिट करा';

  @override
  String get snackbar_grievance_challan_submitted =>
      'तक्रार चालान सबमिट करण्यात आला.';

  @override
  String get snackbar_grievance_receipt_submitted =>
      'तक्रार पावती सबमिट करण्यात आली.';

  @override
  String get no_grievances => 'कोणतीही तक्रार सबमिट केलेली नाही.';

  @override
  String get no_receipts => 'कोणतीही तक्रार पावती सबमिट केलेली नाही.';

  @override
  String get error => 'चूक';

  @override
  String get civilian_report_title => 'नागरिक अहवाल';

  @override
  String get report_violation => 'उल्लंघन अहवाल';

  @override
  String get violation_history => 'उल्लंघन इतिहास';

  @override
  String get report_incident => 'घटना अहवाल';

  @override
  String get incident_history => 'घटना इतिहास';

  @override
  String get challan => 'चालान';

  @override
  String get challan_subtitle => 'चालान विरोधात';

  @override
  String get receipt => 'पावती';

  @override
  String get receipt_subtitle => 'पावती विरोधात';

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
  String get vehicle_number => 'वाहन क्रमांक';

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
  String get menu_report_incident => 'घटना अहवाल';

  @override
  String get menu_incident_history => 'घटना इतिहास';

  @override
  String get offense_screen_title => '🚦 गुन्हे व दंड';

  @override
  String get offense_1_title => 'चालक (मालक) ने हेल्मेट न घालता वाहन चालवले';

  @override
  String get offense_2_title => 'पिलियन (मालक) ने हेल्मेट न घालता वाहन चालवले';

  @override
  String get offense_3_title =>
      'प्रवासी वाहने - समोर पांढरे / दोन्ही बाजूंना पिवळे / मागे लाल परावर्तक नसणे';

  @override
  String get offense_4_title => 'वैध लायसन्सशिवाय वाहन चालवणे';

  @override
  String get offense_5_title =>
      '१६ वर्षाखालील व्यक्तीने लायसन्सशिवाय वाहन चालवणे';

  @override
  String get offense_1_section => 'कलम 129/194(D) मोटार वाहन कायदा';

  @override
  String get offense_2_section => 'कलम 129/194(D) मोटार वाहन कायदा';

  @override
  String get offense_3_section => 'CMVR 104(1)(iv)/177 मोटार वाहन कायदा';

  @override
  String get offense_4_section => 'कलम 3/181 मोटार वाहन कायदा';

  @override
  String get offense_5_section => 'कलम 4/181 मोटार वाहन कायदा';

  @override
  String get fine_1000 => '₹1000';

  @override
  String get fine_5000 => '₹5000';

  @override
  String get pay_challan_title => 'ई-चालान भरा';

  @override
  String get challan_id => 'चालान आयडी';

  @override
  String get search_by_vehicle => 'वाहन क्रमांक';

  @override
  String get search_by_challan => 'चालान क्रमांक';

  @override
  String get pay_button => 'भरणा करा';

  @override
  String get payment_success => '✅ पेमेंट यशस्वी! पावती डाउनलोड केली.';

  @override
  String payment_failed(Object error) {
    return '⚠️ काहीतरी चुकले: $error';
  }

  @override
  String get no_vehicle_found => '❌ वाहन सापडले नाही. कृपया तपासा.';

  @override
  String get no_unpaid_challans =>
      '✅ वाहन सापडले, परंतु कोणतेही अवैतनिक चालान नाहीत.';

  @override
  String get invalid_challan_id => '❌ अवैध किंवा आधीच भरलेले चालान आयडी.';

  @override
  String get invalid_input_vehicle =>
      'कृपया योग्य वाहन क्रमांक आणि चेसिसचे शेवटचे ४ अंक द्या.';

  @override
  String get invalid_input_challan => 'कृपया वैध चालान आयडी द्या.';

  @override
  String get receipt_title => 'ई-चालान पावती';

  @override
  String receipt_challan_id(Object id) {
    return 'चालान आयडी: $id';
  }

  @override
  String receipt_amount(Object amount) {
    return 'भरलेली रक्कम: ₹$amount';
  }

  @override
  String receipt_reason(Object reason) {
    return 'कारण: $reason';
  }

  @override
  String get receipt_status => 'स्थिती: भरलेले';

  @override
  String receipt_issued_on(Object date) {
    return 'जारी केले: $date';
  }

  @override
  String get receipt_thank_you => 'तुमच्या पेमेंटबद्दल धन्यवाद.';

  @override
  String get title_public_notices => 'सार्वजनिक सूचना';

  @override
  String get label_read_more => 'अधिक वाचा';

  @override
  String get tooltip_view_file => 'फाईल पहा';

  @override
  String get tooltip_download_file => 'फाईल डाउनलोड करा';

  @override
  String message_downloaded(Object filePath) {
    return '$filePath वर डाउनलोड केले';
  }

  @override
  String get message_download_failed => 'डाउनलोड अयशस्वी';

  @override
  String message_download_error(Object error) {
    return 'डाउनलोड त्रुटी: $error';
  }

  @override
  String get message_permission_denied => 'स्टोरेज परवानगी नाकारली';

  @override
  String get message_could_not_open_file => 'फाईल उघडता आली नाही';

  @override
  String get dialog_close => 'बंद करा';

  @override
  String get loading => 'लोड होत आहे...';

  @override
  String get error_loading_notices => 'सूचना लोड करण्यात त्रुटी.';

  @override
  String get road_signs_title => 'रस्ता चिन्हे';

  @override
  String get stop => 'थांबा';

  @override
  String get no_entry => 'प्रवेश नाही';

  @override
  String get no_u_turn => 'यू टर्न निषिद्ध';

  @override
  String get no_overtaking => 'ओव्हरटेकिंग निषिद्ध';

  @override
  String get speed_limit => 'गती मर्यादा';

  @override
  String get right_hand_curve => 'उजव्या हाताला वळण';

  @override
  String get pedestrian_crossing => 'पादचारी क्रॉसिंग';

  @override
  String get school_ahead => 'पुढे शाळा आहे';

  @override
  String get no_right_turn => 'उजवे वळण निषिद्ध';

  @override
  String get slippery_road => 'घसरणारी रस्ता';

  @override
  String get y_intersection => 'Y-जोडणी';

  @override
  String get narrow_bridge => 'पुढे अरुंद पूल';

  @override
  String get left_hand_curve => 'डाव्या हाताला वळण';

  @override
  String get railway_crossing => 'रेल्वे क्रॉसिंग';

  @override
  String get roundabout => 'गोल वळण';

  @override
  String get no_horn => 'हॉर्न वाजवू नका';

  @override
  String get cattle_crossing => 'जनावरांचा रस्ता';

  @override
  String get quiz_title => '🚦 रस्ता चिन्ह प्रश्नमंजुषा';

  @override
  String get error_loading => 'प्रश्न लोड करताना त्रुटी.';

  @override
  String get no_questions => 'प्रश्न उपलब्ध नाहीत.';

  @override
  String get quiz_completed => '🎉 प्रश्नमंजुषा पूर्ण!';

  @override
  String your_score(Object score, Object total) {
    return 'तुमचा स्कोअर: $score / $total';
  }

  @override
  String get restart_quiz => 'पुन्हा सुरुवात करा';

  @override
  String get correct => '✅ बरोबर!';

  @override
  String incorrect(Object answer) {
    return '❌ चुकीचे. बरोबर उत्तर: $answer';
  }

  @override
  String explanation(Object text) {
    return '📝 स्पष्टीकरण: $text';
  }

  @override
  String get next => 'पुढे';

  @override
  String get contact_title => 'संपर्क करा';

  @override
  String get contact_help => 'मदतीसाठी किंवा सहाय्यासाठी?';

  @override
  String get contact_helpline => 'वाहतूक हेल्पलाइन';

  @override
  String get contact_phone => '1800-123-456';

  @override
  String get contact_email_label => 'आम्हाला ईमेल करा';

  @override
  String get contact_email => 'support@traffic360.in';

  @override
  String get contact_office_label => 'कार्यालयाचा पत्ता';

  @override
  String get contact_office =>
      'वाहतूक नियंत्रण मुख्यालय, मुंबई\nमहाराष्ट्र, भारत';

  @override
  String get contact_hours_label => 'कामाचे तास';

  @override
  String get contact_hours => 'सोम–शनि: सकाळी 9 ते संध्याकाळी 6';

  @override
  String get nav_home => 'मुख्यपृष्ठ';

  @override
  String get nav_contact => 'संपर्क';

  @override
  String get nav_settings => 'सेटिंग्ज';

  @override
  String get challan_title => 'ई-चलन';

  @override
  String get paid_challans => 'भरण केलेले चलन';

  @override
  String get unpaid_challans => 'बकाया चलन';

  @override
  String get no_challans => 'कोणतेही चलन सापडले नाहीत';

  @override
  String get loading_challans => 'चलन लोड करत आहे...';

  @override
  String get challan_details => 'चलन तपशील';

  @override
  String get filter_all => 'सर्व';

  @override
  String get filter_paid => 'भरण केलेले';

  @override
  String get filter_unpaid => 'बकाया';

  @override
  String get issued_on => 'जारी दिनांक';

  @override
  String get no_challans_found => 'कोणतेही चलन सापडले नाहीत';

  @override
  String get no_notifications => 'कोणतीही सूचना सापडली नाही';

  @override
  String get mark_as_read => 'वाचले म्हणून चिन्हांकित करा';

  @override
  String get new_notification => 'नवीन सूचना';

  @override
  String get read => 'वाचलेले';

  @override
  String get unread => 'न वाचलेले';

  @override
  String get search_by => 'शोधा';

  @override
  String get chassis_last_4 => 'चेसिस क्रमांकाचे शेवटचे 4 आकडे';

  @override
  String get challan_number => 'चलन क्रमांक';

  @override
  String get vehicle => 'वाहन';

  @override
  String get search => 'शोधा';

  @override
  String get enter_vehicle_number => 'वाहन क्रमांक प्रविष्ट करा';

  @override
  String get enter_chassis_last_4 => 'चेसिसचे शेवटचे 4 आकडे प्रविष्ट करा';

  @override
  String get enter_challan_number => 'चलन क्रमांक प्रविष्ट करा';

  @override
  String get violation_type => 'उल्लंघन प्रकार';

  @override
  String get upload_photo => 'छायाचित्र अपलोड करा (ऐच्छिक)';

  @override
  String get enter_description => 'वर्णन प्रविष्ट करा';

  @override
  String get select_violation_type => 'उल्लंघन प्रकार निवडा';

  @override
  String get violation_submitted => 'उल्लंघन अहवाल यशस्वीरित्या सबमिट झाला';

  @override
  String get police_login_title => 'पोलीस OTP लॉगिन';

  @override
  String get enter_phone => 'आपला पोलीस फोन नंबर प्रविष्ट करा';

  @override
  String get phone_number => 'फोन नंबर';

  @override
  String get send_otp => 'OTP पाठवा';

  @override
  String get otp_sent_to => 'OTP पाठवला गेला';

  @override
  String get enter_otp => 'OTP प्रविष्ट करा';

  @override
  String get verify_continue => 'सत्यापित करा आणि पुढे जा';

  @override
  String get resend_code_question => 'कोड मिळाला नाही?';

  @override
  String get resend_otp => 'OTP पुन्हा पाठवा';

  @override
  String get otp_sent_success => 'OTP यशस्वीरित्या पाठवला';

  @override
  String get otp_failed => 'OTP पाठवण्यात अयशस्वी';

  @override
  String get otp_verification_failed => 'OTP सत्यापन अयशस्वी';

  @override
  String get otp_invalid => 'अवैध OTP, पुन्हा प्रयत्न करा.';

  @override
  String get otp_required => '6-अंकी वैध OTP प्रविष्ट करा';

  @override
  String get otp_pending_approval => 'आपले खाते मान्यतेची प्रतीक्षा करत आहे.';

  @override
  String get otp_complete_registration => 'कृपया पोलीस नोंदणी पूर्ण करा.';

  @override
  String get otp_welcome => 'स्वागत आहे, अधिकारी!';

  @override
  String get please_enter_phone => 'कृपया आपला फोन नंबर प्रविष्ट करा';

  @override
  String get police_waiting_title => 'मंजुरीची प्रतीक्षा';

  @override
  String get police_waiting_message =>
      'आपले खाते प्रशासकाच्या मंजुरीसाठी प्रतीक्षेत आहे.\nकृपया नंतर पुन्हा तपासा.';

  @override
  String get police_signup_title => 'पोलीस नोंदणी';

  @override
  String get police_id => 'पोलीस आयडी';

  @override
  String get station_code => 'स्टेशन कोड';

  @override
  String get region => 'प्रदेश';

  @override
  String get submit_continue => 'सबमिट करा आणि पुढे जा';

  @override
  String get signup_error_required => 'सर्व फील्ड आवश्यक आहेत.';

  @override
  String get signup_error_session =>
      'सत्र कालबाह्य झाले आहे. कृपया पुन्हा लॉगिन करा.';

  @override
  String get signup_error_failed => 'नोंदणी अयशस्वी';

  @override
  String get policeSignupTitle => 'पोलीस साइनअप';

  @override
  String get policeId => 'पोलीस आयडी';

  @override
  String get stationCode => 'स्टेशन कोड';

  @override
  String get submitContinue => 'सबमिट करा व पुढे जा';

  @override
  String get sessionExpired => 'सत्र कालबाह्य झाले. कृपया पुन्हा लॉगिन करा.';

  @override
  String get signupFailed => 'साइनअप अयशस्वी';

  @override
  String get hello_officer => 'नमस्कार, अधिकारी';

  @override
  String get good_morning => 'शुभ सकाळ!';

  @override
  String get good_afternoon => 'शुभ दुपार!';

  @override
  String get good_evening => 'शुभ संध्या!';

  @override
  String get what_todo => 'आज तुम्ही काय करू इच्छिता?';

  @override
  String get create_challan => 'चलन तयार करा';

  @override
  String get search_vehicle => 'वाहन शोधा';

  @override
  String get all_challans => 'सर्व चलन';

  @override
  String get civil_report => 'नागरिक तक्रार';

  @override
  String get tow_clamp => 'टो व क्लॅम्प';

  @override
  String get awaiting_approval => 'मान्यता प्रतीक्षेत';

  @override
  String get pending_approval_msg =>
      'तुमचे खाते प्रशासकाच्या मान्यतेसाठी प्रतीक्षेत आहे.\nकृपया नंतर पुन्हा तपासा.';

  @override
  String get police_challans_title => 'माझ्याकडून जारी केलेले चलन';

  @override
  String get status_unpaid => 'बकाया';

  @override
  String get status_paid => 'भरलेले';

  @override
  String get status_cancelled => 'रद्द केलेले';

  @override
  String get destination => 'गंतव्य';

  @override
  String get penalty => 'दंड';

  @override
  String get towed => 'टो केले';

  @override
  String get clamped => 'क्लॅम्प केले';

  @override
  String get released => 'सोडले';

  @override
  String get pick_image => 'छायाचित्र निवडा';

  @override
  String get no_image_selected => 'कोणतेही छायाचित्र निवडले नाही.';

  @override
  String get location_disabled => 'स्थान सेवा अक्षम आहेत.';

  @override
  String get location_denied => 'स्थान परवानगी नाकारली आहे.';

  @override
  String get location_denied_permanently =>
      'स्थान परवानगी कायमस्वरूपी नाकारली आहे.';

  @override
  String get fetch_location_failed => 'स्थान मिळवण्यात अयशस्वी';

  @override
  String get fill_all_fields => 'कृपया सर्व माहिती भरा आणि छायाचित्र निवडा.';

  @override
  String get entry_added => 'टो/क्लॅम्प नोंद यशस्वीरित्या जोडली.';

  @override
  String get upload_failed => 'अपलोड अयशस्वी';

  @override
  String get past_entries => 'मागील टो/क्लॅम्प नोंदी';

  @override
  String get no_entries_found => 'कोणतीही नोंद सापडली नाही.';

  @override
  String get memo => 'मेमो';

  @override
  String get pending_approval_message =>
      'तुमचे खाते अ‍ॅडमिनकडून मंजुरीसाठी थांबले आहे.\nकृपया नंतर पुन्हा तपासा.';

  @override
  String get admin_greeting_title => 'नमस्कार! अ‍ॅडमिन';

  @override
  String get admin_loading_greeting => 'आपले अभिवादन लोड होत आहे…';

  @override
  String get admin_good_morning => 'शुभ सकाळ';

  @override
  String get admin_good_afternoon => 'शुभ दुपार';

  @override
  String get admin_good_evening => 'शुभ संध्या';

  @override
  String get menu_approve_vehicle => 'वाहन मंजूर करा';

  @override
  String get menu_manage_users => 'वापरकर्ते व्यवस्थापित करा';

  @override
  String get menu_all_challans => 'सर्व चालान';

  @override
  String get menu_handle_grievances => 'तक्रारी हाताळा';

  @override
  String get menu_reported_violations => 'नोंदवलेले नियमभंग';

  @override
  String get menu_add_quiz => 'प्रश्नमंजुषा जोडा';

  @override
  String get menu_manage_police => 'पोलीस व्यवस्थापन';

  @override
  String get menu_app_settings => 'अ‍ॅप सेटिंग्स';

  @override
  String get menu_alert_traffic => 'ट्रॅफिक अलर्ट';

  @override
  String get menu_incident => 'घटना';

  @override
  String get menu_report => 'अहवाल';

  @override
  String get menu_grievance_challan => 'तक्रार चालान';

  @override
  String get menu_grievance_receipt => 'तक्रार पावती';

  @override
  String get vehicle_approvals => 'वाहन मंजुरी';

  @override
  String get search_hint => 'वाहन किंवा मालक शोधा';

  @override
  String get filter_pending => 'प्रलंबित';

  @override
  String get filter_approved => 'मंजूर';

  @override
  String get filter_rejected => 'नाकारले';

  @override
  String get label_vehicle_number => 'क्रमांक';

  @override
  String get label_owner => 'मालक';

  @override
  String get label_vehicle_type => 'प्रकार';

  @override
  String get label_added_on => 'जोडलेले';

  @override
  String get button_view_rc => 'आरसी दस्तऐवज पाहा';

  @override
  String get button_approve => 'मंजूर करा';

  @override
  String get button_reject => 'नकारा';

  @override
  String get no_vehicles_found => 'कोणतीही वाहने आढळली नाहीत.';

  @override
  String get rc_open_error => 'आरसी दस्तऐवज उघडू शकलो नाही';

  @override
  String get manage_police => 'पोलीस अधिकाऱ्यांचे व्यवस्थापन';

  @override
  String get pending => 'प्रलंबित';

  @override
  String get approved => 'मंजूर';

  @override
  String get rejected => 'नकारले';

  @override
  String get station => 'स्टेशन';

  @override
  String get applied_on => 'अर्जाची तारीख';

  @override
  String get approve => 'मंजूर करा';

  @override
  String get reject => 'नाकाराः';

  @override
  String get no_officers => 'कोणतेही पोलीस अधिकारी सापडले नाहीत.';

  @override
  String get all_reported_violations => 'सर्व अहवालित उल्लंघने';

  @override
  String get no_violations => 'अद्याप कोणतेही उल्लंघन अहवालित नाहीत.';

  @override
  String get date => 'तारीख';

  @override
  String get image => 'प्रतिमा';

  @override
  String get manage_notices => 'सूचना व्यवस्थापन';

  @override
  String get add_public_notice => 'सार्वजनिक सूचना जोडा';

  @override
  String get my_notices => 'माझ्या सूचना';

  @override
  String get title => 'शीर्षक';

  @override
  String get enter_title => 'शीर्षक प्रविष्ट करा';

  @override
  String get pick_photo => 'फोटो निवडा';

  @override
  String get post_notice => 'सूचना पोस्ट करा';

  @override
  String get notice_added => '✅ सार्वजनिक सूचना जोडली गेली';

  @override
  String get notice_deleted => '🗑️ सूचना हटवली गेली';

  @override
  String get delete_notice => 'सूचना हटवा';

  @override
  String get delete_notice_confirm => 'आपण ही सूचना हटवू इच्छिता का?';

  @override
  String get delete => 'हटवा';

  @override
  String get no_my_notices => 'आपण अद्याप कोणतीही सूचना पोस्ट केलेली नाही';

  @override
  String get could_not_open_image => 'प्रतिमा उघडता आली नाही';

  @override
  String get reported_incidents => 'अहवाल दिलेल्या घटना';

  @override
  String get no_incidents => 'अद्याप कोणतीही घटना अहवालित नाही.';

  @override
  String get incident_type => 'घटनेचा प्रकार';

  @override
  String get vehicle_type => 'वाहन प्रकार';

  @override
  String get issued_by => 'जारी करणारा';

  @override
  String get all => 'सर्व';

  @override
  String get admin_quiz_upload => 'प्रशासक क्विझ अपलोड';

  @override
  String get add_quiz => 'क्विझ जोडा';

  @override
  String get question => 'प्रश्न';

  @override
  String get option => 'पर्याय';

  @override
  String get correct_option => 'योग्य: पर्याय';

  @override
  String get select_image => 'प्रतिमा निवडा';

  @override
  String get no_quizzes => 'कोणतीही क्विझ आढळली नाही';

  @override
  String get answer => 'उत्तर';

  @override
  String get no_question => 'प्रश्न उपलब्ध नाही';

  @override
  String get image_not_supported => 'प्रतिमा समर्थित नाही';

  @override
  String get traffic_alerts => 'वाहतूक अलर्ट';

  @override
  String get alert_type => 'अलर्ट प्रकार';

  @override
  String get pick_datetime => 'अलर्ट दिनांक व वेळ निवडा';

  @override
  String get submit_alert => 'अलर्ट सबमिट करा';

  @override
  String get alert_created => 'अलर्ट तयार झाला!';

  @override
  String get no_alerts => 'अद्याप कोणतेही अलर्ट तयार झालेले नाहीत.';

  @override
  String get time => 'वेळ';

  @override
  String get admin_receipts_title => 'प्रशासक - तक्रार पावत्या';

  @override
  String get admin_challans_title => 'प्रशासक - तक्रार चालान';

  @override
  String get user_id => 'वापरकर्ता आयडी';

  @override
  String get submitted => 'सबमिट केले';

  @override
  String get fill_details => 'खालील माहिती भरा';

  @override
  String get reason_offense => 'कारण / गुन्हा';

  @override
  String get location_autofilled => 'स्थान (स्वयंचलित भरलेले)';

  @override
  String get upload_photo_proof => 'फोटो पुरावा अपलोड करा';

  @override
  String get selected_proof_image => 'निवडलेला पुरावा फोटो:';

  @override
  String get submit_challan => 'चलन सबमिट करा';

  @override
  String get fetch_location_error => 'स्थान मिळवण्यात अयशस्वी';

  @override
  String get please_fill_fields => '⚠️ कृपया सर्व माहिती भरा.';

  @override
  String get not_logged_in => '⚠️ आपण लॉग इन केलेले नाही.';

  @override
  String get vehicle_not_found => 'या नंबरसाठी सत्यापित वाहन सापडले नाही';

  @override
  String get challan_created => '✅ चलन यशस्वीपणे तयार केले!';

  @override
  String get error_occurred => '❌ त्रुटी';
}
