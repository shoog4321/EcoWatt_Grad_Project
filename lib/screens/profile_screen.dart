import 'package:flutter/material.dart';
import '../widgets/ecowatt_widgets.dart';
import 'welcome_screen.dart';
import '../user_storage.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
void initState() {
  super.initState();
  loadUserData();
}

Future<void> loadUserData() async {
  final user = await UserStorage.getCurrentUser();

  if (user == null) return;

  setState(() {
    firstName = user['firstName'] ?? '';
    lastName = user['lastName'] ?? '';
    region = user['region'] ?? '';
    housingType = user['housingType'] ?? '';
    residents = user['residents'] ?? '';
    insulation = user['insulation'] ?? '';
    acType = user['acType'] ?? '';
    cookingFuel = user['cookingFuel'] ?? '';
  });
  final email = await UserStorage.getCurrentUserEmail();

if (email != null) {
  await UserStorage.saveUser(
    email: email,
    data: {
      'firstName': firstName,
      'lastName': lastName,
      'region': region,
      'housingType': housingType,
      'residents': residents,
      'insulation': insulation,
      'acType': acType,
      'cookingFuel': cookingFuel,
    },
  );
}
}
  String firstName = '';
  String lastName = '';  
  String region = '';
  String housingType = '';
  String residents = '';
  String insulation = '';
  String acType = '';
  String cookingFuel = '';

  void _openEditDialog() {
    final firstNameController = TextEditingController(text: firstName);
final lastNameController = TextEditingController(text: lastName);
    final residentsController = TextEditingController(text: residents);

    String tempRegion = region;
    String tempHousing = housingType;
    String tempInsulation = insulation;
    String tempAc = acType;
    String tempCooking = cookingFuel;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Edit Household Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    _EditLabel('First Name'),
                    _EditTextField(controller: firstNameController),

                    _EditLabel('Last Name'),
                    _EditTextField(controller: lastNameController),

                    _EditLabel('Region'),
                    _EditDropdown(
                      value: tempRegion,
                     items: const['Riyadh', 'Qassim', 'Eastern Region', 'Makkah', 'Madinah', 'Hail', 'Tabuk', 'Northern Borders', 'Aseer','Jazan', 'Najran', 'Al-Baha', 'Al-Jouf'],

                      onChanged: (v) => setDialogState(() => tempRegion = v!),
                    ),

                    _EditLabel('Housing Type'),
                    _EditDropdown(
                      value: tempHousing,
                      items: const ['Villa','Floor In Villa', 'Apartment', 'Traditional House','Floor In Traditional House'],
                      onChanged: (v) => setDialogState(() => tempHousing = v!),
                    ),

                    _EditLabel('Residents'),
                    _EditTextField(
                      controller: residentsController,
                      keyboardType: TextInputType.number,
                    ),

                    _EditLabel('Insulation'),
                    _EditDropdown(
                      value: tempInsulation,
                      items: const ['Yes', 'No'],
                      onChanged: (v) => setDialogState(() => tempInsulation = v!),
                    ),

                    _EditLabel('AC Type'),
                    _EditDropdown(
                      value: tempAc,
                      items: const ['Split Units', 'Window Unit', 'Central AC'],
                      onChanged: (v) => setDialogState(() => tempAc = v!),
                    ),

                    _EditLabel('Cooking Fuel'),
                    _EditDropdown(
                      value: tempCooking,
                      items: const ['Natural Gas', 'Electric'],
                      onChanged: (v) => setDialogState(() => tempCooking = v!),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ecowattGreen,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() {
                                firstName = firstNameController.text.trim();
                                lastName=lastNameController.text.trim();
                                residents = residentsController.text.trim();
                                region = tempRegion;
                                housingType = tempHousing;
                                insulation = tempInsulation;
                                acType = tempAc;
                                cookingFuel = tempCooking;
                              });
                              final email = await UserStorage.getCurrentUserEmail();

                                if (email != null) {
                                  await UserStorage.saveUser(
                                    email: email,
                                    data: {
                                      'firstName': firstName,
                                      'lastName': lastName,
                                      'region': region,
                                      'housingType': housingType,
                                      'residents': residents,
                                      'insulation': insulation,
                                      'acType': acType,
                                      'cookingFuel': cookingFuel,
                                    },
                                  );
                                }
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.save, size: 18),
                            label: const Text('Save Changes'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 70),
              color: ecowattGreen,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your household information',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -38),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: const BoxDecoration(
                              color: ecowattGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person_outline, color: Colors.white, size: 42),
                          ),
                          const SizedBox(height: 14),
                          Text(
                          firstName+ ' '+lastName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ecowattDark),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$region • $housingType',
                            style: const TextStyle(color: ecowattText, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    Row(
                      children: [
                        const Text(
                          'Household Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ecowattDark),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _openEditDialog,
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: ecowattGreen, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    _ProfileTile(icon: Icons.person_outline, title: 'Region', value: region),
                    _ProfileTile(icon: Icons.home_outlined, title: 'Housing Type', value: housingType),
                    _ProfileTile(icon: Icons.groups_outlined, title: 'Residents', value: residents),
                    _ProfileTile(icon: Icons.thermostat_outlined, title: 'Insulation', value: insulation),
                    _ProfileTile(icon: Icons.air_outlined, title: 'AC Type', value: acType),
                    _ProfileTile(icon: Icons.kitchen_outlined, title: 'Cooking Fuel', value: cookingFuel),

                    const SizedBox(height: 18),

                    _AboutCard(),

                    const SizedBox(height: 22),

                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    (route) => false,
  );
},
                        icon: const Icon(Icons.logout, color: Colors.red, size: 18),
                        label: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ecowattLightGray),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ecowattText, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: ecowattText, fontSize: 13)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ecowattLightGray),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Ecowatt', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          SizedBox(height: 12),
          Text(
            'Ecowatt is your AI-powered companion for understanding and optimizing electricity consumption. '
            'We help Saudi households make informed energy decisions and reduce costs through awareness and insights.',
            style: TextStyle(color: ecowattText, height: 1.5),
          ),
          SizedBox(height: 16),
          Text('Version 1.0.0', style: TextStyle(color: ecowattGray, fontSize: 12)),
        ],
      ),
    );
  }
}

class _EditLabel extends StatelessWidget {
  final String text;
  const _EditLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _EditTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _EditTextField({
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF3F3F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _EditDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _EditDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF3F3F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }
}