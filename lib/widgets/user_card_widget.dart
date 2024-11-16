import 'package:community/models/User.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {super.key, required this.user, this.isUser = false, this.onEdit});

  final User? user;
  final bool isUser;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user?.photo != null
                  ? NetworkImage(user?.photo)
                  : const AssetImage('assets/defaultImage.avif'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user?.firstName} ${user?.lastName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.email ?? 'Email del usuario',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.phoneNumber ?? 'Telefono del usuario',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            isUser
                ? IconButton(
                    onPressed: onEdit ?? () {},
                    icon: const Icon(Icons.edit, color: Colors.amber),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
