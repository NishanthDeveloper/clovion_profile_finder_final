// // To parse this JSON data, do
// //
// //     final piMyData = piMyDataFromJson(jsonString);

// import 'dart:convert';

// List<PiMyData> piMyDataFromJson(String str) => List<PiMyData>.from(json.decode(str).map((x) => PiMyData.fromJson(x)));

// String piMyDataToJson(List<PiMyData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class PiMyData {
//     String? uid;
//     String? email;
//     String? mobile;
//     String? password;
//     int? otp;
//     int? userOtp;
//     String? createdDate;
//     String? profilePicture;
//     String? officeName;
//     String? officeCountry;
//     String? officeCity;
//     String? officeAddress;
//     String? firstName;
//     String? lastName;
//     String? personalCountry;
//     String? personalCity;
//     String? personalAddress;
//     String? hiringManager;
//     String? idCard;
//     String? tagline;
//     String? myClient;
//     int? totalRatings;

//     PiMyData({
//          this.uid,
//          this.email,
//          this.mobile,
//          this.password,
//          this.otp,
//          this.userOtp,
//          this.createdDate,
//          this.profilePicture,
//          this.officeName,
//          this.officeCountry,
//          this.officeCity,
//          this.officeAddress,
//          this.firstName,
//          this.lastName,
//          this.personalCountry,
//          this.personalCity,
//          this.personalAddress,
//          this.hiringManager,
//          this.idCard,
//          this.tagline,
//          this.myClient,
//          this.totalRatings,
//     });

//     factory PiMyData.fromJson(Map<String, dynamic> json) => PiMyData(
//         uid: json["uid"],
//         email: json["email"],
//         mobile: json["mobile"],
//         password: json["password"],
//         otp: json["otp"],
//         userOtp: json["user_otp"],
//         createdDate: json["created_date"],
//         profilePicture: json["profile_picture"],
//         officeName: json["office_name"],
//         officeCountry: json["office_country"],
//         officeCity: json["office_city"],
//         officeAddress: json["office_address"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         personalCountry: json["personal_country"],
//         personalCity: json["personal_city"],
//         personalAddress: json["personal_address"],
//         hiringManager: json["hiring_manager"],
//         idCard: json["id_card"],
//         tagline: json["tagline"],
//         myClient: json["my_client"],
//         totalRatings: json["total_ratings"],
//     );

//     Map<String, dynamic> toJson() => {
//         "uid": uid,
//         "email": email,
//         "mobile": mobile,
//         "password": password,
//         "otp": otp,
//         "user_otp": userOtp,
//         "created_date": createdDate,
//         "profile_picture": profilePicture,
//         "office_name": officeName,
//         "office_country": officeCountry,
//         "office_city": officeCity,
//         "office_address": officeAddress,
//         "first_name": firstName,
//         "last_name": lastName,
//         "personal_country": personalCountry,
//         "personal_city": personalCity,
//         "personal_address": personalAddress,
//         "hiring_manager": hiringManager,
//         "id_card": idCard,
//         "tagline": tagline,
//         "my_client": myClient,
//         "total_ratings": totalRatings,
//     };
// }



// // class PrivateInvestigatorDataModel {
// //   final String uid;
// //   final String email;
// //   final String mobile;
// //   final String password;
// //   final String otp;
// //   final String user_otp;
// //   final String date;
// //   final Uri profile_picture;
// //   final String office_name;
// //   final String office_country;
// //   final String office_city;
// //   final String office_address;
// //   final String first_name;
// //   final String last_name;
// //   final String personal_country;
// //   final String personal_city;
// //   final String personal_address;
// //   final String hiring_manager;
// //   final Uri id_card;
// //   final String tagline;
// //   final String my_client;
// //   final int total_ratings;

// //   const PrivateInvestigatorDataModel({required this.uid,
// //     required this.email,
// //     required this.mobile,
// //     required this.password,
// //     required this.otp,
// //     required this.user_otp,
// //     required this.date,
// //     required this.profile_picture,
// //     required this.office_name,
// //     required this.office_country,
// //     required this.office_city,
// //     required this.office_address,
// //     required this.first_name,
// //     required this.last_name,
// //     required this.personal_country,
// //     required this.personal_address,
// //     required this.personal_city,
// //     required this.hiring_manager,
// //     required this.id_card,
// //     required this.tagline,
// //     required this.my_client,
// //     required this.total_ratings,});

// //   factory PrivateInvestigatorDataModel.fromJson(Map<String, dynamic> json) =>
// //       PrivateInvestigatorDataModel(
// //         uid: json['uid'].toString(),
// //         email: json['email'].toString(),
// //         mobile: json['mobile'].toString(),
// //         password: json['password'].toString(),
// //         otp: json['otp'].toString(),
// //         user_otp: json['user_otp'].toString(),
// //         date: json['date'].toString(),
// //         profile_picture: Uri.parse(json['profile_picture'].toString()),
// //         office_name: json['office_name'].toString(),
// //         office_country: json['office_country'].toString(),
// //         office_city: json['office_city'].toString(),
// //         office_address: json['office_address'].toString(),
// //         first_name: json['first_name'].toString(),
// //         last_name: json['last_name'].toString(),
// //         personal_country: json['personal_country'].toString(),
// //         personal_address: json['personal_address'].toString(),
// //         personal_city: json['personal_city'].toString(),
// //         hiring_manager: json['hiring_manager'].toString(),
// //         id_card: Uri.parse(json['id_card'].toString()),
// //         tagline: json['tagline'].toString(),
// //         my_client: json['my_client'].toString(),
// //         total_ratings: json['total_ratings'] as int,
// //       );
// // }



// To parse this JSON data, do
//
//     final piMyData = piMyDataFromJson(jsonString);

import 'dart:convert';

List<PiMyData> piMyDataFromJson(String str) => List<PiMyData>.from(json.decode(str).map((x) => PiMyData.fromJson(x)));

String piMyDataToJson(List<PiMyData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PiMyData {
    String? uid;
    String? email;
    String? mobile;
    String? password;
    int? otp;
    int? userOtp;
    String? createdDate;
    String? profilePicture;
    dynamic officeName;
    dynamic officeCountry;
    dynamic officeCity;
    dynamic officeAddress;
    String? firstName;
    String? lastName;
    String? personalCountry;
    String? personalCity;
    String? personalAddress;
    String? hiringManager;
    dynamic idCard;
    String? tagline;
    String? myClient;
    double? totalRatings;
    int? otp1;
    int? userOtp1;
    dynamic levelEducation;
    dynamic fieldStudy;
    dynamic workJobTitle;
    dynamic workCompanyName;
    dynamic workJobLocation;
    dynamic exJobTitle;
    dynamic exCompanyName;
    dynamic yearExperience;
    dynamic exLocation;
    dynamic degreeCer;
    dynamic exCer;
    dynamic workType;
    dynamic gstNumber;
    dynamic gstCertificate;
    dynamic companyPanNo;
    dynamic arnNo;
    dynamic panCard;
    String? notificationStatus;

    PiMyData({
        this.uid,
        this.email,
        this.mobile,
        this.password,
        this.otp,
        this.userOtp,
        this.createdDate,
        this.profilePicture,
        this.officeName,
        this.officeCountry,
        this.officeCity,
        this.officeAddress,
        this.firstName,
        this.lastName,
        this.personalCountry,
        this.personalCity,
        this.personalAddress,
        this.hiringManager,
        this.idCard,
        this.tagline,
        this.myClient,
        this.totalRatings,
        this.otp1,
        this.userOtp1,
        this.levelEducation,
        this.fieldStudy,
        this.workJobTitle,
        this.workCompanyName,
        this.workJobLocation,
        this.exJobTitle,
        this.exCompanyName,
        this.yearExperience,
        this.exLocation,
        this.degreeCer,
        this.exCer,
        this.workType,
        this.gstNumber,
        this.gstCertificate,
        this.companyPanNo,
        this.arnNo,
        this.panCard,
        this.notificationStatus,
    });

    factory PiMyData.fromJson(Map<String, dynamic> json) => PiMyData(
        uid: json["uid"],
        email: json["email"],
        mobile: json["mobile"],
        password: json["password"],
        otp: json["otp"],
        userOtp: json["user_otp"],
        createdDate: json["created_date"],
        profilePicture: json["profile_picture"],
        officeName: json["office_name"],
        officeCountry: json["office_country"],
        officeCity: json["office_city"],
        officeAddress: json["office_address"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        personalCountry: json["personal_country"],
        personalCity: json["personal_city"],
        personalAddress: json["personal_address"],
        hiringManager: json["hiring_manager"],
        idCard: json["id_card"],
        tagline: json["tagline"],
        myClient: json["my_client"],
        totalRatings: json["total_ratings"]?.toDouble(),
        otp1: json["otp1"],
        userOtp1: json["user_otp1"],
        levelEducation: json["level_education"],
        fieldStudy: json["field_study"],
        workJobTitle: json["work_job_title"],
        workCompanyName: json["work_company_name"],
        workJobLocation: json["work_job_location"],
        exJobTitle: json["ex_job_title"],
        exCompanyName: json["ex_company_name"],
        yearExperience: json["year_experience"],
        exLocation: json["ex_location"],
        degreeCer: json["degree_cer"],
        exCer: json["ex_cer"],
        workType: json["work_type"],
        gstNumber: json["gst_number"],
        gstCertificate: json["gst_certificate"],
        companyPanNo: json["company_pan_no"],
        arnNo: json["arn_no"],
        panCard: json["pan_card"],
        notificationStatus: json["notification_status"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "mobile": mobile,
        "password": password,
        "otp": otp,
        "user_otp": userOtp,
        "created_date": createdDate,
        "profile_picture": profilePicture,
        "office_name": officeName,
        "office_country": officeCountry,
        "office_city": officeCity,
        "office_address": officeAddress,
        "first_name": firstName,
        "last_name": lastName,
        "personal_country": personalCountry,
        "personal_city": personalCity,
        "personal_address": personalAddress,
        "hiring_manager": hiringManager,
        "id_card": idCard,
        "tagline": tagline,
        "my_client": myClient,
        "total_ratings": totalRatings,
        "otp1": otp1,
        "user_otp1": userOtp1,
        "level_education": levelEducation,
        "field_study": fieldStudy,
        "work_job_title": workJobTitle,
        "work_company_name": workCompanyName,
        "work_job_location": workJobLocation,
        "ex_job_title": exJobTitle,
        "ex_company_name": exCompanyName,
        "year_experience": yearExperience,
        "ex_location": exLocation,
        "degree_cer": degreeCer,
        "ex_cer": exCer,
        "work_type": workType,
        "gst_number": gstNumber,
        "gst_certificate": gstCertificate,
        "company_pan_no": companyPanNo,
        "arn_no": arnNo,
        "pan_card": panCard,
        "notification_status": notificationStatus,
    };
}
