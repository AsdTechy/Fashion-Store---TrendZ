import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState
    extends State<EditProfilePage> {
  final TextEditingController
      nameController =
      TextEditingController();

  bool isLoading = false;
  User? user;

  @override
  void initState() {
    super.initState();

    user =
        FirebaseAuth.instance.currentUser;

    nameController.text =
        user?.displayName ?? "";
  }

  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      await user?.updateDisplayName(
        nameController.text.trim(),
      );

      await user?.reload();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Profile updated successfully",
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4FBF4),

      appBar: AppBar(
        title: const Text(
          "Edit Profile",
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller:
                  nameController,
              decoration:
                  InputDecoration(
                labelText:
                    "Full Name",
                filled: true,
                fillColor:
                    Colors.white,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
              ),
            ),

            const SizedBox(
                height: 25),

            SizedBox(
              width:
                  double.infinity,
              height: 50,
              child:
                  ElevatedButton(
                onPressed:
                    isLoading
                        ? null
                        : updateProfile,
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors
                            .white,
                      )
                    : const Text(
                        "Save Changes",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}