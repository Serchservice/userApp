import 'package:user/lib.dart';

class UserAdditionalModel{
  String? streetNumber, streetName, lga, landMark, userCity, stateOfOrigin, userCountry, emailAlternate, alternatePhoneNumber;
  String? nokTitle, nokRelationship, nokFirstName, nokLastName, nokEmailAddress, nokPhoneNumber, nokAddress, nokCity, nokState, nokCountry;

  UserAdditionalModel({
    this.streetNumber, this.streetName, this.lga, this.landMark, this.userCity, this.stateOfOrigin, this.userCountry, this.emailAlternate,
    this.alternatePhoneNumber, this.nokTitle, this.nokRelationship, this.nokFirstName, this.nokLastName, this.nokEmailAddress,
    this.nokPhoneNumber, this.nokAddress, this.nokCity, this.nokCountry
  });
}

class BookmarkModel{
  final String name;
  final String service;
  final String id;
  final double rate;
  BookmarkModel({required this.name, required this.service, required this.id, required this.rate});
}

class RatingTalkModel{
  final String image;
  final String? comment;
  final String name;
  final double rate;
  final bool good;
  RatingTalkModel({required this.image, this.comment, required this.name, required this.rate, required this.good});
}