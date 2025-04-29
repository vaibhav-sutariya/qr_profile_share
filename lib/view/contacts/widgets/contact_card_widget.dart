import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/model/contacts/contacts_model.dart';
import 'package:qr_profile_share/view/contacts/widgets/bottom_modal_widget.dart';
import 'package:qr_profile_share/view_model/controller/contact/contact_view_model.dart';

class ContactCard extends StatelessWidget {
  final ContactData contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, viewModel, _) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 100.0, end: 0.0),
          duration: Duration(milliseconds: 600),

          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value, 0), // X-axis slide
              child: Opacity(
                opacity: 1 - (value / 100), // fade in effect
                child: child,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightColor.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                viewModel.toggleCard(contact.sId!);
                log('Tapped on contact: ${contact.email}');
              },
              onLongPress: () {
                DeleteContactBottomSheet.show(
                  context,
                  onConfirmDelete: () {
                    // Call your delete contact function here
                    log('Delete contact: ${contact.sId}');
                    viewModel.deleteContact(contact.sId!);
                    viewModel.getContacts();
                  },
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Column(
                spacing: 7,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(contact.photo ?? ''),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact.name ?? "Name",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(contact.userRole ?? ""),
                              Text(
                                contact.company ?? "",
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (viewModel.isContactExpanded(contact.sId!)) ...[
                    Divider(
                      color: AppColors.lightColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    contactDetailRow(Feather.phone, contact.phoneNumber),
                    contactDetailRow(Icons.email_outlined, contact.email),
                    contactDetailRow(
                      Icons.location_on_outlined,
                      contact.location,
                    ),

                    if (contact.website != null)
                      contactDetailRow(Feather.link, contact.website),
                  ],
                  Divider(
                    color: AppColors.lightColor.withOpacity(0.2),
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      actionIcon(Feather.phone, contact.phoneNumber, "Call"),
                      actionIcon(Icons.email_outlined, contact.email, "Email"),
                      actionIcon(Feather.link, contact.website, "Visit"),
                    ],
                  ),

                  if (viewModel.isContactExpanded(contact.sId!)) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialIcons(
                          AntDesign.github,
                          contact.socialLinks!.github,
                        ),
                        socialIcons(
                          AntDesign.linkedin_square,
                          contact.socialLinks!.linkedIn,
                        ),
                        socialIcons(
                          AntDesign.instagram,
                          contact.socialLinks!.instagram,
                        ),
                        socialIcons(
                          AntDesign.twitter,
                          contact.socialLinks!.twitter,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget contactDetailRow(IconData icon, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget actionIcon(IconData icon, String? value, String? text) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            IconButton(
              onPressed:
                  value != null
                      ? () {
                        log('Action pressed: $value');
                      }
                      : null,
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      value != null
                          ? AppColors.primaryColor.withOpacity(0.15)
                          : Colors.grey[200],
                ),
                child: Icon(
                  icon,
                  color: value != null ? AppColors.primaryColor : Colors.grey,
                ),
              ),
            ),
            Text(text!),
          ],
        );
      },
    );
  }

  Widget socialIcons(IconData icon, String? value) {
    return IconButton(
      onPressed:
          value != null
              ? () {
                log('Action pressed: $value');
              }
              : null,
      icon: Icon(
        icon,
        size: 20,
        color: AppColors.primaryColor.withOpacity(0.8),
      ),
    );
  }
}
