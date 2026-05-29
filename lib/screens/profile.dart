import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    user = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const Login(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    String username =
        user?.displayName ?? "No Name";

    String email =
        user?.email ?? "No Email";

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4FBF4),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Image
            Stack(
              alignment:
                  Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage:
                      AssetImage(
                    'assets/images/profile.jpg',
                  ),
                ),

                CircleAvatar(
                  radius: 16,
                  backgroundColor:
                      Colors.green,
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color:
                        Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(
                height: 16),

            Text(
              username,
              style:
                  const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 8),

            Container(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration:
                  BoxDecoration(
                color: Colors
                    .green
                    .shade600,
                borderRadius:
                    BorderRadius
                        .circular(
                            20),
              ),
              child: Text(
                email,
                style:
                    const TextStyle(
                  color:
                      Colors.white,
                ),
              ),
            ),

            const SizedBox(
                height: 30),

            Card(
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius
                        .circular(
                            12),
              ),
              elevation: 2,
              child: Column(
                children: [
 
                  _menuTile(
                    icon:
                        Icons.edit,
                    title:
                        'Edit Profile',
                    onTap:
                        () async {
                      final updated =
                          await Navigator
                              .push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const EditProfilePage(),
                        ),
                      );

                      if (updated ==
                          true) {
                        await FirebaseAuth
                            .instance
                            .currentUser
                            ?.reload();

                        getUserData();
                      }
                    },
                  ),

                  _divider(),

                  _menuTile(
                    icon: Icons
                        .settings,
                    title:
                        'Settings',
                    onTap: () {},
                  ),

                  _divider(),

                  _menuTile(
                    icon: Icons
                        .person_add_alt,
                    title:
                        'Invite a friend',
                    onTap: () {},
                  ),

                  _divider(),

                  _menuTile(
                    icon:
                        Icons.logout,
                    title:
                        'Logout',
                    titleColor:
                        Colors.red,
                    iconColor:
                        Colors.red,
                    onTap: () {
                      _showLogoutDialog(
                          context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    Color iconColor =
        Colors.grey,
    Color titleColor =
        Colors.black,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
    );
  }

  void _showLogoutDialog(
      BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
        title:
            const Text(
                'Logout'),
        content:
            const Text(
          'Are you sure you want to logout?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(
                    context),
            child: const Text(
                'Cancel'),
          ),

          TextButton(
            onPressed:
                () async {
              Navigator.pop(
                  context);

              await logoutUser();
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color:
                    Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}