import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/model/home/connection_model.dart';
import 'package:qr_profile_share/view_model/controller/home/home_view_model.dart';

class RecentConnectionsWidget extends StatelessWidget {
  const RecentConnectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final connectionVM = Provider.of<HomeViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Recent Connections',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'See all',
              style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: getScreenHeight(context) * 0.21,
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(width: 4),
            padding: const EdgeInsets.all(4),
            scrollDirection: Axis.horizontal,
            itemCount: connectionVM.connections.length,
            itemBuilder: (context, index) {
              return ConnectionCardWidget(
                connection: connectionVM.connections[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class ConnectionCardWidget extends StatelessWidget {
  final ConnectionModel connection;

  const ConnectionCardWidget({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: getScreenWidth(context) * 0.39,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: CachedNetworkImageProvider(
                  connection.imageUrl,
                ),
              ),

              const SizedBox(height: 12),
              Text(
                connection.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                connection.role,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                connection.time,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        if (connection.isOnline)
          Positioned(
            top: 10,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
              child: const Icon(
                Icons.access_time,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
