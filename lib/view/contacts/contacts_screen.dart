import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/components/custom_app_bar.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view/contacts/widgets/contact_card_shimmer_widget.dart';
import 'package:qr_profile_share/view/contacts/widgets/contact_card_widget.dart';
import 'package:qr_profile_share/view/contacts/widgets/search_bar_widget.dart';
import 'package:qr_profile_share/view_model/controller/contact/contact_view_model.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, contactViewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            text: 'My Contacts',
            isActionButtonVisible: true,
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.addNewContactScreen);
            },
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await contactViewModel.getContacts();
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SearchBarWidget(),
                const SizedBox(height: 16),

                // Main Section
                if (contactViewModel.getcontactsLoading) ...[
                  const ContactCardShimmer(),
                  const ContactCardShimmer(),
                  const ContactCardShimmer(),
                ] else if (contactViewModel.contacts?.data?.isEmpty ??
                    true) ...[
                  Text(
                    'No Contacts Found',

                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ] else ...[
                  ...List.generate(
                    contactViewModel.contacts?.data?.length ?? 0,
                    (index) {
                      final contact = contactViewModel.contacts!.data![index];
                      return ContactCard(contact: contact);
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
