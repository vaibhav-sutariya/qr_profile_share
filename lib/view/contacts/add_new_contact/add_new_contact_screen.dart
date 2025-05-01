import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/components/custom_app_bar.dart';
import 'package:qr_profile_share/configs/components/field_widget.dart';
import 'package:qr_profile_share/view/contacts/add_new_contact/widgets/add_photo_widget.dart';
import 'package:qr_profile_share/view_model/controller/contact/add_contact_view_model.dart';

class AddNewContactScreen extends StatelessWidget {
  const AddNewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddContactViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            isActionButtonVisible: true,
            icon:
                viewModel.addNewContactLoading
                    ? AntDesign.loading2
                    : Ionicons.save_outline,

            onPressed: () {
              viewModel.addNewContact(context);
            },
            isBackButtonVisible: true,
            text: 'Add New Contact',
          ),
          body: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 16),
                AddPhotoWidget(),
                FieldWidget(
                  duration: 400,
                  title: 'Full Name',
                  icon: Icons.person_2_outlined,
                  text: 'Enter full name',
                  onChanged: (value) => viewModel.setName(value),
                  keyboardType: TextInputType.name,
                ),
                FieldWidget(
                  duration: 500,

                  title: 'Email',
                  icon: Icons.email_outlined,
                  text: 'Enter email address',
                  onChanged: (value) => viewModel.setEmail(value),
                  keyboardType: TextInputType.name,
                ),
                FieldWidget(
                  duration: 600,

                  title: 'Phone',
                  icon: Feather.phone,
                  text: 'Enter phone number',
                  onChanged: (value) => viewModel.setPhoneNumber(value),
                  keyboardType: TextInputType.name,
                ),
                FieldWidget(
                  duration: 700,

                  title: 'Location',
                  icon: Icons.location_on_outlined,
                  text: 'Enter location',
                  onChanged: (value) => viewModel.setLocation(value),
                  keyboardType: TextInputType.name,
                ),
                FieldWidget(
                  duration: 750,

                  title: 'Company',
                  icon: Icons.work_outline_rounded,
                  text: 'Enter company name',
                  onChanged: (value) => viewModel.setCompany(value),
                  keyboardType: TextInputType.name,
                ),
                FieldWidget(
                  duration: 800,

                  title: 'Role',
                  icon: Icons.work_outline_rounded,
                  text: 'Enter job title',
                  onChanged: (value) => viewModel.setRole(value),
                  keyboardType: TextInputType.name,
                ),
                FieldWidget(
                  duration: 850,

                  title: 'Website',
                  icon: Feather.link,
                  text: 'Enter website URL',
                  onChanged: (value) => viewModel.setWebsite(value),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
