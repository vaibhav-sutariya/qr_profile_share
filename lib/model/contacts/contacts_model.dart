import 'dart:convert';

ContactModel contactModelFromJson(String str) =>
    ContactModel.fromJson(json.decode(str));

class ContactModel {
  String? status;
  int? results;
  int? total;
  int? page;
  int? totalPages;
  List<ContactData>? data;

  ContactModel({
    this.status,
    this.results,
    this.total,
    this.page,
    this.totalPages,
    this.data,
  });

  ContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    total = json['total'];
    page = json['page'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <ContactData>[];
      json['data'].forEach((v) {
        data!.add(ContactData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['results'] = results;
    data['total'] = total;
    data['page'] = page;
    data['totalPages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactData {
  SocialLinks? socialLinks;
  String? sId;
  String? contactId;
  String? userId;
  String? name;
  String? email;
  String? phoneNumber;
  String? company;
  String? userRole;
  String? website;
  String? location;
  String? photo;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ContactData({
    this.socialLinks,
    this.sId,
    this.contactId,
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.company,
    this.userRole,
    this.website,
    this.location,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ContactData.fromJson(Map<String, dynamic> json) {
    socialLinks =
        json['socialLinks'] != null
            ? SocialLinks.fromJson(json['socialLinks'])
            : null;
    sId = json['_id'];
    contactId = json['contactId'];
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    company = json['company'];
    userRole = json['userRole'];
    website = json['website'];
    location = json['location'];
    photo = json['photo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (socialLinks != null) {
      data['socialLinks'] = socialLinks!.toJson();
    }
    data['_id'] = sId;
    data['contactId'] = contactId;
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['company'] = company;
    data['userRole'] = userRole;
    data['website'] = website;
    data['location'] = location;
    data['photo'] = photo;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
