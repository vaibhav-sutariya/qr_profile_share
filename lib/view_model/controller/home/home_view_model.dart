import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/assets/image_assets.dart';
import 'package:qr_profile_share/model/home/connection_model.dart';
import 'package:qr_profile_share/model/home/event_model.dart';
import 'package:qr_profile_share/model/home/smart_feature_model.dart';
import 'package:qr_profile_share/model/home/template_model.dart';

class HomeViewModel extends ChangeNotifier {
  final List<SmartFeatureModel> _features = [
    SmartFeatureModel(
      icon: Icons.flash_on_outlined,
      title: 'Auto-Update',
      description:
          'Your QR code updates automatically when you change your profile',
      isEnabled: true,
    ),
    SmartFeatureModel(
      icon: Icons.share_outlined,
      title: 'NFC Sharing',
      description: 'Share your contact via tap',
    ),
    SmartFeatureModel(
      icon: Icons.flash_on_outlined,
      title: 'Auto-Update',
      description:
          'Your QR code updates automatically when you change your profile',
      isEnabled: true,
    ),
    SmartFeatureModel(
      icon: Icons.share_outlined,
      title: 'NFC Sharing',
      description: 'Share your contact via tap',
    ),
  ];

  List<SmartFeatureModel> get features => _features;

  void toggleFeature(int index) {
    _features[index].isEnabled = !_features[index].isEnabled;
    notifyListeners();
  }

  final List<EventModel> _events = [
    EventModel(
      title: 'Tech Conference',
      date: 'Mar 15',
      tag: 'Conference',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwiVqpNd0zv349lznWpZI0-KKoEyp-sFiA_g&s', // Use your asset or network image
    ),
    EventModel(
      title: 'Networking Meetup',
      date: 'Apr 05',
      tag: 'Meetup',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/19/11/11/hands-1838658_1280.jpg',
    ),
    EventModel(
      title: 'Tech Conference',
      date: 'Mar 15',
      tag: 'Conference',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwiVqpNd0zv349lznWpZI0-KKoEyp-sFiA_g&s', // Use your asset or network image
    ),
    EventModel(
      title: 'Networking Meetup',
      date: 'Apr 05',
      tag: 'Meetup',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/19/11/11/hands-1838658_1280.jpg',
    ),
  ];

  List<EventModel> get events => _events;

  final List<ConnectionModel> _connections = [
    ConnectionModel(
      name: 'Sarah Wilson',
      role: 'Product Designer',
      imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      time: '5m ago',
      isOnline: true,
    ),
    ConnectionModel(
      name: 'Michael Chen',
      role: 'Developer',
      imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      time: '1h ago',
    ),
    ConnectionModel(
      name: 'Emma Davis',
      role: 'Marketing',
      imageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
      time: '2h ago',
    ),
  ];

  List<ConnectionModel> get connections => _connections;

  final List<TemplateModel> _templates = [
    TemplateModel(
      title: 'Tech',
      description: 'GitHub, Stack Overflow profiles',
      iconPath: ImageAssets.bookImg, // Replace with your own asset
    ),
    TemplateModel(
      title: 'Creative',
      description: 'Portfolio links, projects',
      iconPath: ImageAssets.bookImg, // Replace with your own asset
    ),
    TemplateModel(
      title: 'Tech',
      description: 'GitHub, Stack Overflow profiles',
      iconPath: ImageAssets.bookImg, // Replace with your own asset
    ),
    TemplateModel(
      title: 'Creative',
      description: 'Portfolio links, projects',
      iconPath: ImageAssets.bookImg, // Replace with your own asset
    ),
  ];

  List<TemplateModel> get templates => _templates;
}
