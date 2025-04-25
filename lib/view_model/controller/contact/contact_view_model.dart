import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_profile_share/model/contacts/contacts_model.dart';
import 'package:qr_profile_share/repository/contacts/delete_contact_repository.dart';
import 'package:qr_profile_share/repository/contacts/get_contacts_repository.dart';
import 'package:qr_profile_share/view_model/services/get_data/get_access_token.dart';

class ContactViewModel extends ChangeNotifier {
  // Singleton pattern to ensure only one instance of the class exists
  ContactViewModel._privateConstructor() {
    // Fetch data on initialization
    getContacts();
  }

  static final ContactViewModel _instance =
      ContactViewModel._privateConstructor();

  factory ContactViewModel() {
    return _instance;
  }
  final Set<String> _expandedContactIds = {}; // 👈 NEW

  bool isContactExpanded(String id) => _expandedContactIds.contains(id);

  void toggleCard(String id) {
    if (_expandedContactIds.contains(id)) {
      _expandedContactIds.remove(id);
    } else {
      _expandedContactIds
          .clear(); // 👈 Optional: If you want only one card expanded at a time
      _expandedContactIds.add(id);
    }
    notifyListeners();
  }

  ContactModel? _contacts;

  ContactModel? get contacts => _contacts;

  bool _getcontactsLoading = false;
  bool get getcontactsLoading => _getcontactsLoading;

  setgetContactsLoading(bool value) {
    _getcontactsLoading = value;
    notifyListeners();
  }

  String _searchText = '';
  String _filterText = '';

  String get getSearchText => _searchText;
  String get getFilterText => _filterText;

  void onSearchChanged(String value) {
    _searchText = value;
    log('Searching: $value');
    notifyListeners();
  }

  void onFilterPressed(String value) {
    _filterText = value;
    // Handle your filter logic here
    log('Filter icon pressed');
  }

  Future<void> getContacts() async {
    try {
      setgetContactsLoading(true);
      notifyListeners();

      String token = await getAccessToken();

      final contacts = await GetContactsRepository().getAllContacts(token);
      _contacts = contacts;
      setgetContactsLoading(false);
    } catch (e) {
      setgetContactsLoading(false);
      log("Error fetching all contacts: $e");
    } finally {
      setgetContactsLoading(false);
      notifyListeners();
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      setgetContactsLoading(true);
      notifyListeners();

      String token = await getAccessToken();

      await DeleteContactRepository().deletContact(id, token);
      log("Contact deleted successfully");
      setgetContactsLoading(false);
    } catch (e) {
      setgetContactsLoading(false);
      log("Error fetching all contacts: $e");
    } finally {
      setgetContactsLoading(false);
      notifyListeners();
    }
  }
}
