import 'dart:convert';

class UserResponse {
  Map<String, List<User>> data;

  UserResponse({
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      data: Map.from(json).map((k, v) => MapEntry<String, List<User>>(
          k, List<User>.from(v.map((x) => User.fromJson(x))))),
    );
  }

  Map<String, dynamic> toJson() {
    return Map.from(data).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson()))));
  }
}
UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) =>
    json.encode(data.toJson());

class User {
  int id;
  String uid;
  String email;
  String mobile;
  String password;
  String referralCode;
  dynamic coin;
  String createdTime;
  int otp;
  int userOtp;
  String createdDate;
  String idCard1;
  String name;
  String address;
  int height;
  int weight;
  String gender;
  String marital;
  String physical;
  String religion;
  int age;
  String birthPlace;
  String birthCountry;
  String birthTime;
  String birthCity;
  String origin;
  String rCountry;
  String rState;
  String rStatus;
  String denomination;
  String bloodGroup;
  String idCard2;
  dynamic profileForWho;
  String templeName;
  String templeStreet;
  String templePostCode;
  String templeCountry;
  String templeCity;
  String templePhoneNumber;
  String templeDiocese;
  String templeLocalAdmin;
  List<String> emergencyName;
  List<String> emergencyRelation;
  List<String> emergencyPhoneNumber;
  List<String> emergencyEmail;
  List<String> emergencyMaritalStatus;
  List<String> emergencyOccupations;
  String profilePicture;
  String maritalStatus;
  String physicalMentalStatus;
  String primaryEmail;
  String primaryPhoneNumber;
  String dob;
  String whyMarry;
  String behindDecision;
  List<String> educationSchool;
  List<String> educationYear;
  List<String> educationCourse;
  List<String> educationMajor;
  List<String> areYouWorkingNow;
  List<String> companyName;
  List<String> position;
  List<String> profession;
  List<String> salaryRange;
  List<String> yourInterest;
  List<String> nonInterest;
  List<String> complexion;
  List<String> foodTaste;
  List<String> dailyDietPlan;
  String carryingAfterMarriage;
  String tobacco;
  String alcohol;
  String drugs;
  String criminalOffence;
  String primaryCountry;
  String selfie;
  String fullSizeImage;
  String familyImage;
  List<String> gallery;
  String horoscope;
  String profileTag;
  String treatMyPartner;
  String treatTheirSide;
  String orphan;
  String disable;
  String whichOrgan;
  String familyStatus;
  String fatherName;
  String fatherCountry;
  String fatherCity;
  String fatherJob;
  String fatherFamilyName;
  String motherName;
  String motherCountry;
  String motherCity;
  String motherJob;
  String motherFamilyName;
  List<String> siblingName;
  List<String> siblingRelation;
  List<String> siblingYoungOrOld;
  List<String> siblingOccupation;
  List<String> siblingMarital;
  List<String> siblingEmail;
  List<String> siblingDob;
  List<dynamic> siblingJob;
  String aboutCandidate;
  String currentStatus;
  String contactFatherName;
  String contactFatherStreet;
  String contactFatherZipcode;
  String contactFatherCountry;
  String contactFatherCity;
  String contactFatherHousename;
  String contactMotherHousename;
  String contactEmail;
  String contactPhone;
  String whatsapp;
  String facebook;
  String linkedin;
  String instagram;
  String youtube;
  String twitter;
  String website;
  dynamic registeredDate;
  dynamic myInvestigator;
  List<List<String>> question;
  List<List<String>> answer;
  List<dynamic> rating;
  List<String> feedback;
  List<String> myManager;
  List<String> complaints;
  List<String> complaintsReplay;
  dynamic status;
  dynamic reason;
  dynamic otp1;
  dynamic userOtp1;

  User({
    required this.id,
    required this.uid,
    required this.email,
    required this.mobile,
    required this.password,
    required this.referralCode,
    this.coin,
    required this.createdTime,
    required this.otp,
    required this.userOtp,
    required this.createdDate,
    required this.idCard1,
    required this.name,
    required this.address,
    required this.height,
    required this.weight,
    required this.gender,
    required this.marital,
    required this.physical,
    required this.religion,
    required this.age,
    required this.birthPlace,
    required this.birthCountry,
    required this.birthTime,
    required this.birthCity,
    required this.origin,
    required this.rCountry,
    required this.rState,
    required this.rStatus,
    required this.denomination,
    required this.bloodGroup,
    required this.idCard2,
    this.profileForWho,
    required this.templeName,
    required this.templeStreet,
    required this.templePostCode,
    required this.templeCountry,
    required this.templeCity,
    required this.templePhoneNumber,
    required this.templeDiocese,
    required this.templeLocalAdmin,
    required this.emergencyName,
    required this.emergencyRelation,
    required this.emergencyPhoneNumber,
    required this.emergencyEmail,
    required this.emergencyMaritalStatus,
    required this.emergencyOccupations,
    required this.profilePicture,
    required this.maritalStatus,
    required this.physicalMentalStatus,
    required this.primaryEmail,
    required this.primaryPhoneNumber,
    required this.dob,
    required this.whyMarry,
    required this.behindDecision,
    required this.educationSchool,
    required this.educationYear,
    required this.educationCourse,
    required this.educationMajor,
    required this.areYouWorkingNow,
    required this.companyName,
    required this.position,
    required this.profession,
    required this.salaryRange,
    required this.yourInterest,
    required this.nonInterest,
    required this.complexion,
    required this.foodTaste,
    required this.dailyDietPlan,
    required this.carryingAfterMarriage,
    required this.tobacco,
    required this.alcohol,
    required this.drugs,
    required this.criminalOffence,
    required this.primaryCountry,
    required this.selfie,
    required this.fullSizeImage,
    required this.familyImage,
    required this.gallery,
    required this.horoscope,
    required this.profileTag,
    required this.treatMyPartner,
    required this.treatTheirSide,
    required this.orphan,
    required this.disable,
    required this.whichOrgan,
    required this.familyStatus,
    required this.fatherName,
    required this.fatherCountry,
    required this.fatherCity,
    required this.fatherJob,
    required this.fatherFamilyName,
    required this.motherName,
    required this.motherCountry,
    required this.motherCity,
    required this.motherJob,
    required this.motherFamilyName,
    required this.siblingName,
    required this.siblingRelation,
    required this.siblingYoungOrOld,
    required this.siblingOccupation,
    required this.siblingMarital,
    required this.siblingEmail,
    required this.siblingDob,
    required this.siblingJob,
    required this.aboutCandidate,
    required this.currentStatus,
    required this.contactFatherName,
    required this.contactFatherStreet,
    required this.contactFatherZipcode,
    required this.contactFatherCountry,
    required this.contactFatherCity,
    required this.contactFatherHousename,
    required this.contactMotherHousename,
    required this.contactEmail,
    required this.contactPhone,
    required this.whatsapp,
    required this.facebook,
    required this.linkedin,
    required this.instagram,
    required this.youtube,
    required this.twitter,
    required this.website,
    this.registeredDate,
    this.myInvestigator,
    required this.question,
    required this.answer,
    required this.rating,
    required this.feedback,
    required this.myManager,
    required this.complaints,
    required this.complaintsReplay,
    this.status,
    this.reason,
    this.otp1,
    this.userOtp1,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        uid: json['uid'],
        email: json['email'],
        mobile: json['mobile'],
        password: json['password'],
        referralCode: json['referral_code'],
        coin: json['coin'],
        createdTime: json['created_time'],
        otp: json['otp'],
        userOtp: json['user_otp'],
        createdDate: json['created_date'],
        idCard1: json['id_card_1'],
        name: json['name'],
        address: json['address'],
        height: json['height'],
        weight: json['weight'],
        gender: json['gender'],
        marital: json['marital'],
        physical: json['physical'],
        religion: json['religion'],
        age: json['age'],
        birthPlace: json['birth_place'],
        birthCountry: json['birth_country'],
        birthTime: json['birth_time'],
        birthCity: json['birth_city'],
        origin: json['origin'],
        rCountry: json['r_country'],
        rState: json['r_state'],
        rStatus: json['r_status'],
        denomination: json['denomination'],
        bloodGroup: json['blood_group'],
        idCard2: json['id_card_2'],
        profileForWho: json['profile_for_who'],
        templeName: json['temple_name'],
        templeStreet: json['temple_street'],
        templePostCode: json['temple_post_code'],
        templeCountry: json['temple_country'],
        templeCity: json['temple_city'],
        templePhoneNumber: json['temple_phone_number'],
        templeDiocese: json['temple_diocese'],
        templeLocalAdmin: json['temple_local_admin'],
        emergencyName: List<String>.from(json['emergency_name'].map((x) => x)),
    emergencyRelation:
    List<String>.from(json['emergency_relation'].map((x) => x)),
    emergencyPhoneNumber:
    List<String>.from(json['emergency_phone_number'].map((x) => x)),
    emergencyEmail:
    List<String>.from(json['emergency_email'].map((x) => x)),
    emergencyMaritalStatus:
    List<String>.from(json['emergency_marital_status'].map((x) => x)),
    emergencyOccupations:
    List<String>.from(json['emergency_occupations'].map((x) => x)),
    profilePicture: json['profile_picture'],
    maritalStatus: json['marital_status'],
    physicalMentalStatus: json['physical_mental_status'],
    primaryEmail: json['primary_email'],
    primaryPhoneNumber: json['primary_phone_number'],
    dob: json['dob'],
    whyMarry: json['why_marry'],
    behindDecision: json['behind_decision'],
    educationSchool:
    List<String>.from(json['education_school'].map((x) => x)),
    educationYear: List<String>.from(json['education_year'].map((x) => x)),
      educationCourse: List<String>.from(json['education_course'].map((x) => x)),
      educationMajor: List<String>.from(json['education_major'].map((x) => x)),
      areYouWorkingNow: List<String>.from(json['are_you_working_now'].map((x) => x)),
      companyName: List<String>.from(json['company_name'].map((x) => x)),
      position: List<String>.from(json['position'].map((x) => x)),
      profession: List<String>.from(json['profession'].map((x) => x)),
      salaryRange: List<String>.from(json['salary_range'].map((x) => x)),
      yourInterest: List<String>.from(json['your_interest'].map((x) => x)),
      nonInterest: List<String>.from(json['non_interest'].map((x) => x)),
      complexion: List<String>.from(json['complexion'].map((x) => x)),
      foodTaste: List<String>.from(json['food_taste'].map((x) => x)),
      dailyDietPlan: List<String>.from(json['daily_diet_plan'].map((x) => x)),
      carryingAfterMarriage: json['carrying_after_marriage'],
      tobacco: json['tobacco'],
      alcohol: json['alcohol'],
      drugs: json['drugs'],
      criminalOffence: json['criminal_offence'],
      primaryCountry: json['primary_country'],
      selfie: json['selfie'],
      fullSizeImage: json['full_size_image'],
      familyImage: json['family_image'],
      gallery: List<String>.from(json['gallery'].map((x) => x)),
      horoscope: json['horoscope'],
      profileTag: json['profile_tag'],
      treatMyPartner: json['treat_my_partner'],
      treatTheirSide: json['treat_their_side'],
      orphan: json['orphan'],
      disable: json['disable'],
      whichOrgan: json['which_organ'],
      familyStatus: json['family_status'],
      fatherName: json['father_name'],
      fatherCountry: json['father_country'],
      fatherCity: json['father_city'],
      fatherJob: json['father_job'],
      fatherFamilyName: json['father_family_name'],
      motherName: json['mother_name'],
      motherCountry: json['mother_country'],
      motherCity: json['mother_city'],
      motherJob: json['mother_job'],
      motherFamilyName: json['mother_family_name'],
      siblingName: List<String>.from(json['sibling_name'].map((x) => x)),
      siblingRelation: List<String>.from(json['sibling_relation'].map((x) => x)),
      siblingYoungOrOld: List<String>.from(json['sibling_young_or_old'].map((x) => x)),
      siblingOccupation: List<String>.from(json['sibling_occupation'].map((x) => x)),
      siblingMarital: List<String>.from(json['sibling_marital'].map((x) => x)),
      siblingEmail: List<String>.from(json['sibling_email'].map((x) => x)),
      siblingDob: List<String>.from(json['sibling_dob'].map((x) => x)),
      siblingJob: List<dynamic>.from(json['sibling_job'].map((x) => x)),
      aboutCandidate: json['about_candidate'],
      currentStatus: json['current_status'],
      contactFatherName: json['contact_father_name'],
      contactFatherStreet: json['contact_father_street'],
      contactFatherZipcode: json['contact_father_zipcode'],
      contactFatherCountry: json['contact_father_country'],
      contactFatherCity: json['contact_father_city'],
      contactFatherHousename: json['contact_father_housename'],
      contactMotherHousename: json['contact_mother_housename'],
      contactEmail: json['contact_email'],
      contactPhone: json['contact_phone'],
      whatsapp: json['whatsapp'],
      facebook: json['facebook'],
      linkedin: json['linkedin'],
      instagram: json['instagram'],
      youtube: json['youtube'],
      twitter: json['twitter'],
      website: json['website'],
      registeredDate: json['registered_date'],
      myInvestigator: json['my_investigator'],
      question: List<List<String>>.from(json['question'].map((x) => List<String>.from(x))),
      answer: List<List<String>>.from(json['answer'].map((x) => List<String>.from(x))),
      rating: List<dynamic>.from(json['rating'].map((x) => x)),
      feedback: List<String>.from(json['feedback'].map((x) => x)),
      myManager: List<String>.from(json['my_manager'].map((x) => x)),
      complaints: List<String>.from(json['complaints'].map((x) => x)),
      complaintsReplay: List<String>.from(json['complaints_replay'].map((x) => x)),
      status: json['status'],
      reason: json['reason'],
      otp1: json['otp1'],
      userOtp1: json['user_otp1'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'mobile': mobile,
      'password': password,
      'referral_code': referralCode,
      'coin': coin,
      'created_time': createdTime,
      'otp': otp,
      'user_otp': userOtp,
      'created_date': createdDate,
      'id_card_1': idCard1,
      'name': name,
      'address': address,
      'height': height,
      'weight': weight,
      'gender': gender,
      'marital': marital,
      'physical': physical,
      'religion': religion,
      'age': age,
      'birth_place': birthPlace,
      'birth_country': birthCountry,
      'birth_time': birthTime,
      'birth_city': birthCity,
      'origin': origin,
      'r_country': rCountry,
      'r_state': rState,
      'r_status': rStatus,
      'denomination': denomination,
      'blood_group': bloodGroup,
      'id_card_2': idCard2,
      'profile_for_who': profileForWho,
      'temple_name': templeName,
      'temple_street': templeStreet,
      'temple_post_code': templePostCode,
      'temple_country': templeCountry,
      'temple_city': templeCity,
      'temple_phone_number': templePhoneNumber,
      'temple_diocese': templeDiocese,
      'temple_local_admin': templeLocalAdmin,
      'emergency_name': List<dynamic>.from(emergencyName.map((x) => x)),
      'emergency_relation': List<dynamic>.from(emergencyRelation.map((x) => x)),
      'emergency_phone_number': List<dynamic>.from(emergencyPhoneNumber.map((x) => x)),
      'emergency_email': List<dynamic>.from(emergencyEmail.map((x) => x)),
      'emergency_marital_status': List<dynamic>.from(emergencyMaritalStatus.map((x) => x)),
      'emergency_occupations': List<dynamic>.from(emergencyOccupations.map((x) => x)),
      'profile_picture': profilePicture,
      'marital_status': maritalStatus,
      'physical_mental_status': physicalMentalStatus,
      'primary_email': primaryEmail,
      'primary_phone_number': primaryPhoneNumber,
      'dob': dob,
      'why_marry': whyMarry,
      'behind_decision': behindDecision,
      'education_school': List<dynamic>.from(educationSchool.map((x) => x)),
      'education_year': List<dynamic>.from(educationYear.map((x) => x)),
      'education_course': List<dynamic>.from(educationCourse.map((x) => x)),
      'education_major': List<dynamic>.from(educationMajor.map((x) => x)),
      'are_you_working_now': List<dynamic>.from(areYouWorkingNow.map((x) => x)),
      'company_name': List<dynamic>.from(companyName.map((x) => x)),
      'position': List<dynamic>.from(position.map((x) => x)),
      'profession': List<dynamic>.from(profession.map((x) => x)),
      'salary_range': List<dynamic>.from(salaryRange.map((x) => x)),
      'your_interest': List<dynamic>.from(yourInterest.map((x) => x)),
      'non_interest': List<dynamic>.from(nonInterest.map((x) => x)),
      'complexion': List<dynamic>.from(complexion.map((x) => x)),
      'food_taste': List<dynamic>.from(foodTaste.map((x) => x)),
      'daily_diet_plan': List<dynamic>.from(dailyDietPlan.map((x) => x)),
      'carrying_after_marriage': carryingAfterMarriage,
      'tobacco': tobacco,
      'alcohol': alcohol,
      'drugs': drugs,
      'criminal_offence': criminalOffence,
      'primary_country': primaryCountry,
      'selfie': selfie,
      'full_size_image': fullSizeImage,
      'family_image': familyImage,
      'gallery': List<dynamic>.from(gallery.map((x) => x)),
      'horoscope': horoscope,
      'profile_tag': profileTag,
      'treat_my_partner': treatMyPartner,
      'treat_their_side': treatTheirSide,
      'orphan': orphan,
      'disable': disable,
      'which_organ': whichOrgan,
      'family_status': familyStatus,
      'father_name': fatherName,
      'father_country': fatherCountry,
      'father_city': fatherCity,
      'father_job': fatherJob,
      'father_family_name': fatherFamilyName,
      'mother_name': motherName,
      'mother_country': motherCountry,
      'mother_city': motherCity,
      'mother_job': motherJob,
      'mother_family_name': motherFamilyName,
      'sibling_name': List<dynamic>.from(siblingName.map((x) => x)),
      'sibling_relation': List<dynamic>.from(siblingRelation.map((x) => x)),
      'sibling_young_or_old': List<dynamic>.from(siblingYoungOrOld.map((x) => x)),
      'sibling_occupation': List<dynamic>.from(siblingOccupation.map((x) => x)),
      'sibling_marital': List<dynamic>.from(siblingMarital.map((x) => x)),
      'sibling_email': List<dynamic>.from(siblingEmail.map((x) => x)),
      'sibling_dob': List<dynamic>.from(siblingDob.map((x) => x)),
      'sibling_job': List<dynamic>.from(siblingJob.map((x) => x)),
      'about_candidate': aboutCandidate,
      'current_status': currentStatus,
      'contact_father_name': contactFatherName,
      'contact_father_street': contactFatherStreet,
      'contact_father_zipcode': contactFatherZipcode,
      'contact_father_country': contactFatherCountry,
      'contact_father_city': contactFatherCity,
      'contact_father_housename': contactFatherHousename,
      'contact_mother_housename': contactMotherHousename,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
      'whatsapp': whatsapp,
      'facebook': facebook,
      'linkedin': linkedin,
      'instagram': instagram,
      'youtube': youtube,
      'twitter': twitter,
      'website': website,
      'registered_date': registeredDate,
      'my_investigator': myInvestigator,
      'question': List<dynamic>.from(question.map((x) => List<dynamic>.from(x.map((x) => x)))),
      'answer': List<dynamic>.from(answer.map((x) => List<dynamic>.from(x.map((x) => x)))),
      'rating': List<dynamic>.from(rating.map((x) => x)),
      'feedback': List<dynamic>.from(feedback.map((x) => x)),
      'my_manager': List<dynamic>.from(myManager.map((x) => x)),
      'complaints': List<dynamic>.from(complaints.map((x) => x)),
      'complaints_replay': List<dynamic>.from(complaintsReplay.map((x) => x)),
      'status': status,
      'reason': reason,
      'otp1': otp1,
      'user_otp1': userOtp1,
    };
  }
}

