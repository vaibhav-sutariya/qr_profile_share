import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  String? status;
  Data? data;

  UserModel({this.status, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  SocialLinks? socialLinks;
  String? sId;
  String? name;
  String? email;
  String? photo;
  String? role;
  bool? emailVerified;
  String? authType;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? verifyEmailExpires;
  String? verifyEmailToken;
  String? phoneNumber;
  String? location;
  String? company;
  String? userRole;
  String? website;
  int? scans;

  User({
    this.socialLinks,
    this.sId,
    this.name,
    this.email,
    this.photo,
    this.role,
    this.emailVerified,
    this.authType,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.verifyEmailExpires,
    this.verifyEmailToken,
    this.phoneNumber,
    this.location,
    this.company,
    this.userRole,
    this.website,
    this.scans,
  });

  User.fromJson(Map<String, dynamic> json) {
    socialLinks =
        json['socialLinks'] != null
            ? SocialLinks.fromJson(json['socialLinks'])
            : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    role = json['role'];
    emailVerified = json['emailVerified'];
    authType = json['authType'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    verifyEmailExpires = json['verifyEmailExpires'];
    verifyEmailToken = json['verifyEmailToken'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
    company = json['company'];
    userRole = json['userRole'];
    website = json['website'];
    scans = json['scans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (socialLinks != null) {
      data['socialLinks'] = socialLinks!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    data['role'] = role;
    data['emailVerified'] = emailVerified;
    data['authType'] = authType;
    data['active'] = active;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['verifyEmailExpires'] = verifyEmailExpires;
    data['verifyEmailToken'] = verifyEmailToken;
    data['phoneNumber'] = phoneNumber;
    data['location'] = location;
    data['company'] = company;
    data['userRole'] = userRole;
    data['website'] = website;
    data['scans'] = scans;
    return data;
  }
}

class SocialLinks {
  String? github;
  String? linkedIn;
  String? instagram;
  String? twitter;

  SocialLinks({this.github, this.linkedIn, this.instagram, this.twitter});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    github = json['github'];
    linkedIn = json['linkedIn'];
    instagram = json['instagram'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['github'] = github;
    data['linkedIn'] = linkedIn;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    return data;
  }
}
