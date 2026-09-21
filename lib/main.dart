import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:panorama_viewer/panorama_viewer.dart';

void main() {
  runApp(const StudentHostelApp());
}

// ── 1. MAIN APP WIDGET ──
class StudentHostelApp extends StatelessWidget {
  const StudentHostelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHostel Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const SplashScreen(),
    );
  }
}

// ── 2. REUSABLE MOBILE FRAME ──
class MobileFrame extends StatelessWidget {
  final Widget child;
  const MobileFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 80, 80),
      body: Center(
        child: Container(
          height: 700,
          width: 350,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255),
              width: 5,
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black87, blurRadius: 1, spreadRadius: 1),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SafeArea(child: child),
          ),
        ),
      ),
    );
  }
}

// ── 3. SPLASH SCREEN ──
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthNavigationWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.apartment, size: 100, color: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 4. AUTH NAVIGATION WRAPPER ──
class AuthNavigationWrapper extends StatefulWidget {
  const AuthNavigationWrapper({super.key});

  @override
  State<AuthNavigationWrapper> createState() => _AuthNavigationWrapperState();
}

class _AuthNavigationWrapperState extends State<AuthNavigationWrapper> {
  bool showLogin = true;

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(onRegisterTap: togglePages);
    } else {
      return RegisterScreen(onLoginTap: togglePages);
    }
  }
}

// ── 5. LOGIN PAGE ──

// Main Widget Class
class LoginPage extends StatefulWidget {
  final VoidCallback onRegisterTap;

  const LoginPage({super.key, required this.onRegisterTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _passwordController;
  bool _ispasswordObscure = true;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/images/logo.jpg',
                  height: 100,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.apartment,
                    size: 80,
                    color: Color.fromARGB(255, 17, 5, 75),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome Hostel Pro",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 4, 75),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: _ispasswordObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forget Password",
                      style: TextStyle(color: Color.fromARGB(255, 0, 140, 255)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // AUTHENTICATION SUCCESS: GO TO MAIN DASHBOARD
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationWrapper(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 39, 5, 75),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onRegisterTap,
                      child: const Text(
                        "Create New Account",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── 6. REGISTRATION PAGE ──

class RegisterScreen extends StatefulWidget {
  final VoidCallback onLoginTap;
  const RegisterScreen({super.key, required this.onLoginTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _fathernameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _cnicissuedateController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobilenumberController = TextEditingController();
  final _parentmobilenumberController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _instituteController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;
  String? _selectedGender;

  // Image Files
  File? _cnicFrontImage;
  File? _cnicBackImage;
  File? _liveSelfieImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _fathernameController.dispose();
    _cnicController.dispose();
    _cnicissuedateController.dispose();
    _emailController.dispose();
    _mobilenumberController.dispose();
    _parentmobilenumberController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _instituteController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Helper: Calendar Date Picker
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // Helper: Image Selection Function
  Future<void> _pickImage(
    ImageSource source,
    Function(File) onImageSelected,
  ) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        onImageSelected(File(pickedFile.path));
      });
    }
  }

  // Custom Image Upload Box Widget
  Widget _buildImageUploadTile({
    required String title,
    required File? imageFile,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 19, 5, 75),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade50,
            ),
            child: imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 36, color: Colors.grey),
                      const SizedBox(height: 6),
                      Text(
                        "Tap to capture / upload",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text(
            'HostelPro - Register',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 19, 5, 75),
          elevation: 4,
        ),
        body: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 2) {
                setState(() => _currentStep += 1);
              } else {
                _handleRegistration();
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() => _currentStep -= 1);
              }
            },
            steps: [
              // ---------------- STEP 1: PERSONAL INFO ----------------
              Step(
                title: const Text("Personal"),
                isActive: _currentStep >= 0,
                state: _currentStep > 0
                    ? StepState.complete
                    : StepState.editing,
                content: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Full Name', Icons.person),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _surnameController,
                      decoration: _inputDecoration('Surname', Icons.badge),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _fathernameController,
                      decoration: _inputDecoration(
                        'Father Name',
                        Icons.supervisor_account,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Calendar Field: Date of Birth
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      onTap: () => _selectDate(context, _dobController),
                      decoration: _inputDecoration(
                        'Date Of Birth',
                        Icons.calendar_month,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Gender Option
                    DropdownButtonFormField<String>(
                      initialValue: _selectedGender,
                      decoration: _inputDecoration('Select Gender', Icons.wc),
                      items: ['Male', 'Female', 'Other'].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedGender = val),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _instituteController,
                      decoration: _inputDecoration(
                        'University / College Name / Company Name',
                        Icons.school,
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------- STEP 2: CNIC & CONTACTS ----------------
              Step(
                title: const Text("Identity"),
                isActive: _currentStep >= 1,
                state: _currentStep > 1
                    ? StepState.complete
                    : StepState.editing,
                content: Column(
                  children: [
                    TextFormField(
                      controller: _cnicController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        'CNIC NO',
                        Icons.credit_card,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Calendar Field: CNIC Issue Date
                    TextFormField(
                      controller: _cnicissuedateController,
                      readOnly: true,
                      onTap: () =>
                          _selectDate(context, _cnicissuedateController),
                      decoration: _inputDecoration(
                        'CNIC Issue Date',
                        Icons.calendar_month,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _mobilenumberController,
                      keyboardType: TextInputType.phone,
                      decoration: _inputDecoration(
                        'Mobile Number',
                        Icons.phone_android,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _parentmobilenumberController,
                      keyboardType: TextInputType.phone,
                      decoration: _inputDecoration(
                        'Parents Mobile Number',
                        Icons.phone_android,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _addressController,
                      decoration: _inputDecoration(
                        'Full Address',
                        Icons.location_city,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // CNIC Image Pickers
                    _buildImageUploadTile(
                      title: "1. CNIC Front Picture",
                      imageFile: _cnicFrontImage,
                      icon: Icons.add_a_photo,
                      onTap: () => _pickImage(
                        ImageSource.gallery,
                        (file) => _cnicFrontImage = file,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildImageUploadTile(
                      title: "2. CNIC Back Picture",
                      imageFile: _cnicBackImage,
                      icon: Icons.add_a_photo,
                      onTap: () => _pickImage(
                        ImageSource.gallery,
                        (file) => _cnicBackImage = file,
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------- STEP 3: SECURITY & VERIFICATION ----------------
              Step(
                title: const Text("Security"),
                isActive: _currentStep >= 2,
                state: StepState.editing,
                content: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration('Email', Icons.email),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordObscure,
                      onChanged: (v) => setState(() {}),
                      decoration: _inputDecoration('Password', Icons.lock)
                          .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(
                                () => _isPasswordObscure = !_isPasswordObscure,
                              ),
                            ),
                          ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _isConfirmPasswordObscure,
                      onChanged: (v) => setState(() {}),
                      decoration:
                          _inputDecoration(
                            'Confirm Password',
                            Icons.lock_clock_rounded,
                          ).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(
                                () => _isConfirmPasswordObscure =
                                    !_isConfirmPasswordObscure,
                              ),
                            ),
                          ),
                    ),
                    const SizedBox(height: 8),
                    if (_passwordController.text.isNotEmpty ||
                        _confirmPasswordController.text.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            _passwordController.text ==
                                    _confirmPasswordController.text
                                ? Icons.check_circle
                                : Icons.error,
                            color:
                                _passwordController.text ==
                                    _confirmPasswordController.text
                                ? Colors.green
                                : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _passwordController.text ==
                                    _confirmPasswordController.text
                                ? "Passwords Match"
                                : "Passwords Do Not Match",
                            style: TextStyle(
                              color:
                                  _passwordController.text ==
                                      _confirmPasswordController.text
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    // Live Selfie Verification (Camera Only)
                    _buildImageUploadTile(
                      title: "3. Live Verification Photo (Take Selfie)",
                      imageFile: _liveSelfieImage,
                      icon: Icons.camera_front,
                      onTap: () => _pickImage(
                        ImageSource.camera,
                        (file) => _liveSelfieImage = file,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already Have An Account? "),
                        GestureDetector(
                          onTap: widget.onLoginTap,
                          child: const Text(
                            'Login Now',
                            style: TextStyle(
                              color: Color.fromARGB(255, 19, 5, 75),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Common Input Decoration
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  // Final Registration Validation
  void _handleRegistration() {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar("Passwords do not match.", Colors.red);
      return;
    }

    if (_cnicFrontImage == null ||
        _cnicBackImage == null ||
        _liveSelfieImage == null) {
      _showSnackBar(
        "Please upload CNIC Front, Back, and Live Selfie.",
        Colors.orange,
      );
      return;
    }

    _showSnackBar("Registration successful!", Colors.green);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}

// ── 7. FORGOT PASSWORD FULL FLOW ──
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int _currentStep = 1;
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(
                Icons.lock_reset_rounded,
                size: 70,
                color: Color.fromARGB(255, 19, 5, 75),
              ),
              const SizedBox(height: 15),
              const Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  labelText: 'Enter Email / Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 19, 5, 75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Send Reset Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 8. MAIN DASHBOARD WRAPPER & SCREENS ──
class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;
  int _currentAddListingStep = 1;

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const DashboardScreen(),
            const Center(child: Text('Explore Screen')),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: AddListingStepsPart2(
                  step: _currentAddListingStep,
                  onStepChange: (step) =>
                      setState(() => _currentAddListingStep = step),
                  onSubmit: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Listing Submitted!')),
                    );
                  },
                ),
              ),
            ),
            const HostelStudentsPortalWidget(hostelName: "INDUS BOYES HOSTEL"),
            ProfileScreen(setScreen: (screen) {}),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(1),
            topRight: Radius.circular(1),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromARGB(255, 19, 5, 75),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'ADD'),
              BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Portal'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 9. DASHBOARD SCREEN ──
// ── COLOR CONSTANTS ──
const Color B1 = Color.fromARGB(255, 19, 5, 75);
const Color B2 = Color.fromARGB(255, 22, 1, 143);
const Color B3 = Color(0xFFEFF6FF);
const Color B4 = Color(0xFFBFDBFE);
const Color B5 = Colors.white;
const Color W = Colors.white;
const Color G1 = Color(0xFFF8FAFC);
const Color G2 = Color(0xFFE2E8F0);
const Color G3 = Color(0xFF94A3B8);
const Color G4 = Color(0xFF64748B);
const Color G5 = Color(0xFF334155);
const Color T = Color(0xFF0F172A);
const Color GR = Color(0xFF16A34A);
const Color AM = Color.fromARGB(255, 217, 6, 59);
const Color RD = Color.fromARGB(255, 0, 225, 255);
const Color S = Color(0xFFF1F5F9);

// ── DASHBOARD SCREEN ──
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedCat = "All";
  String searchQuery = "";
  String selectedCity = "All Pakistan";

  final List<String> categories = [
    "All",
    "Boys",
    "Girls",
    "Hostel",
    "Flat Pool",
    "Room Sharing",
  ];

  final List<Map<String, dynamic>> listings = [
    {
      "id": "1",
      "name": "INDUS BOYS HOSTEL",
      "emoji": "🏢",
      "kind": "hostel",
      "type": "Private",
      "gender": "Boys",
      "slots": 3,
      "city": "Hyderabad",
      "prov": "Sindh",
      "addr": "Qasimabad, Near Wadhu Wah Rd",
      "rating": 4.5,
      "rev": 28,
      "price": 12000,
      "timeFromUni": "10 min drive",
      "distanceKm": 4.2,
      "facs": [
        {"l": "Wi-Fi", "i": "📶"},
        {"l": "Mess", "i": "🍲"},
        {"l": "AC", "i": "❄️"},
      ],
    },
    {
      "id": "2",
      "name": "Flat For Girls",
      "emoji": "🏘️",
      "kind": "flat",
      "type": "Shared Flat",
      "gender": "Girls",
      "slots": 5,
      "city": "Jamshoro",
      "prov": "Sindh",
      "addr": "Near University of Sindh",
      "rating": 4.8,
      "rev": 14,
      "price": 8500,
      "timeFromUni": "5 min walk",
      "distanceKm": 0.5,
      "facs": [
        {"l": "Wi-Fi", "i": "📶"},
        {"l": "Kitchen", "i": "🍳"},
      ],
    },
  ];

  void _showCityPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final cities = [
          "All Pakistan",
          ...listings.map((h) => h["city"].toString()).toSet(),
        ];
        return SimpleDialog(
          title: const Text("Select City"),
          children: cities.map((city) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCity = city;
                });
                Navigator.pop(context);
              },
              child: Text(city),
            );
          }).toList(),
        );
      },
    );
  }

  Color _getKindColor(String kind) {
    if (kind == "flat") return GR;
    if (kind == "room") return AM;
    return B1;
  }

  String _getKindLabel(String kind) {
    if (kind == "flat") return "Flat Pool";
    if (kind == "room") return "Room Sharing";
    return "Hostel";
  }

  @override
  Widget build(BuildContext context) {
    final filteredListings = listings.filter((h) {
      bool mC =
          selectedCat == "All" ||
          (selectedCat == "Hostel" && h["kind"] == "hostel") ||
          (selectedCat == "Flat Pool" && h["kind"] == "flat") ||
          (selectedCat == "Room Sharing" && h["kind"] == "room") ||
          (selectedCat == "Boys" && h["gender"] == "Boys") ||
          (selectedCat == "Girls" && h["gender"] == "Girls");

      bool mQ =
          searchQuery.isEmpty ||
          h["name"].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          h["city"].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      bool mCity = selectedCity == "All Pakistan" || h["city"] == selectedCity;

      return mC && mQ && mCity;
    }).toList();

    // Header Dashboard Options Welcome, Name, Pak, Search

    return MobileFrame(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(17, 47, 17, 19),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [B1, B1, B2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 11.5,
                                ),
                              ),
                              Text(
                                "Azad Ahmed",
                                style: TextStyle(
                                  color: W,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          // Cities Selector
                          InkWell(
                            onTap: _showCityPickerDialog,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                  0,
                                  255,
                                  255,
                                  255,
                                ).withValues(alpha: 0.12),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    22,
                                    255,
                                    255,
                                    255,
                                  ).withValues(alpha: 0.22),
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "🇵🇰",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    selectedCity == "All Pakistan"
                                        ? "All PK"
                                        : selectedCity,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: W,
                                    ),
                                  ),
                                  const Text(
                                    "Change",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Header Searching Box Option
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                          ),
                        ),
                        child: TextField(
                          onChanged: (val) => setState(() => searchQuery = val),
                          style: const TextStyle(color: W, fontSize: 13),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Color.fromARGB(179, 255, 255, 255),
                              size: 18,
                            ),
                            hintText: "Search hostel, flat, room, city...",
                            labelText: "Searching...",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(242, 255, 255, 255),
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Browsing All Pakistan Option
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(75, 255, 255, 255),
                      border: Border.all(color: B4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Text("🇵🇰", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedCity == "All Pakistan"
                                    ? "Browsing all Pakistan"
                                    : "Showing listings in $selectedCity",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: B2,
                                ),
                              ),
                              Text(
                                selectedCity == "All Pakistan"
                                    ? "Tap to filter by city"
                                    : "Tap to change city",
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  color: G4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Change",
                          style: TextStyle(
                            fontSize: 10.5,
                            color: B1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Application Updates
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 7, 15, 0),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      border: Border.all(color: const Color(0xFFFCD34D)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Text("🔔", style: TextStyle(fontSize: 13)),
                        SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            "Welcome Daily New Posties For Hostels, Flat Pooling, Room Sharing In All Over Pakistan Easy To Use For Users...!",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // CHIPS CATEGARE Filtering option
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isSel = selectedCat == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSel,
                          selectedColor: B1,
                          backgroundColor: W,
                          labelStyle: TextStyle(
                            color: isSel ? W : G5,
                            fontSize: 11.5,
                            fontWeight: isSel
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          onSelected: (val) {
                            setState(() => selectedCat = cat);
                          },
                        ),
                      );
                    },
                  ),
                ),
                // LISTING OPTION
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  child: Text(
                    "${filteredListings.length} listings",
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: G4,
                    ),
                  ),
                ),
                // Dashboard sa hostel Listing
                ...filteredListings.map((h) {
                  final kc = _getKindColor(h["kind"]);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: W,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: G2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 115,
                            decoration: BoxDecoration(
                              color: kc.withValues(alpha: 0.1),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(13),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(13),
                                    ),
                                    child: Image.asset(
                                      h["image"] ??
                                          "assets/images/boyshostel.jpeg",
                                      width: double.infinity,
                                      height: 115,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                height: 50,
                                                color: Colors.grey.shade300,
                                                child: const Icon(
                                                  Icons.apartment,
                                                  size: 40,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: _buildBadge(
                                    _getKindLabel(h["kind"]),
                                    kc,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: _buildBadge(
                                    h["gender"],
                                    Colors.black54,
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  left: 8,
                                  child: _buildBadge(
                                    "${h["slots"]} slots",
                                    h["slots"] < 4
                                        ? GR
                                        : const Color.fromARGB(
                                            255,
                                            255,
                                            0,
                                            179,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: _buildBadge(
                                    "📍 ${h["city"]}",
                                    Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          h["name"],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: T,
                                          ),
                                        ),
                                        Text(
                                          "${h["addr"]}, ${h["city"]}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: G4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: G1,
                                        border: Border.all(color: G2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "★ ${h["rating"]}",
                                            style: const TextStyle(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.bold,
                                              color: T,
                                            ),
                                          ),
                                          Text(
                                            "${h["rev"]} rev",
                                            style: const TextStyle(
                                              fontSize: 8.5,
                                              color: G3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "From",
                                          style: TextStyle(
                                            fontSize: 9.5,
                                            color: G3,
                                          ),
                                        ),
                                        Text(
                                          "PKR ${h["price"]}/mo",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: B1,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Hostel View Button
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: B1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HostelDetailScreen(hostel: h),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "View",
                                        style: TextStyle(color: W),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Listing Controller Options
  Widget _buildMetricCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        decoration: BoxDecoration(
          color: W,
          borderRadius: BorderRadius.circular(15),
          border: Border(
            top: BorderSide(color: color, width: 3),
            left: const BorderSide(color: Colors.amber),
            right: const BorderSide(color: Colors.white),
            bottom: const BorderSide(color: Colors.pink),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 9.5,
                color: G4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: W,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

extension ListFilter<T> on List<T> {
  Iterable<T> filter(bool Function(T element) test) => where(test);
}

class AddListingStepsPart2 extends StatefulWidget {
  final int step;
  final Function(int) onStepChange;
  final VoidCallback onSubmit;

  const AddListingStepsPart2({
    Key? key,
    required this.step,
    required this.onStepChange,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _AddListingStepsPart2State createState() => _AddListingStepsPart2State();
}

class _AddListingStepsPart2State extends State<AddListingStepsPart2> {
  String selectedKind = '';
  final Map<String, bool> _nearbyPoints = {
    'food': false,
    'mosque': false,
    'hospital': false,
    'transport': false,
    'market': false,
    'bank': false,
  };

  final Map<String, bool> _facilities = {
    'gen': false,
    'ups': false,
    'sol': false,
    'wifi': false,
    'mess': false,
    'cctv': false,
  };
  // ADD Navigation Options
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _addnearuniController = TextEditingController();
  final TextEditingController _openTimeController = TextEditingController();
  final TextEditingController _closeTimeController = TextEditingController();
  final TextEditingController _visitingHoursController =
      TextEditingController();
  final TextEditingController _gateClosingController = TextEditingController();
  final TextEditingController _oNameController = TextEditingController();
  final TextEditingController _oCnicController = TextEditingController();
  final TextEditingController _oPhoneController = TextEditingController();

  final Color primaryColor = const Color(0xFF1E3A8A);
  final Color secondaryBg = const Color(0xFFF1F5F9);
  final Color borderColor = const Color(0xFFE2E8F0);
  final Color textColor = const Color(0xFF0F172A);

  @override
  Widget build(BuildContext context) {
    // Added Step 1 implementation so layout is never empty
    if (widget.step == 1) return _buildStep1();
    if (widget.step == 2) return _buildStep2();
    if (widget.step == 3) return _buildStep3();
    if (widget.step == 4) return _buildStep4();
    return _buildStep1();
  }

  // ADD OPTION STEP 1
  Widget _buildStep1() {
    // Option Data List
    final List<Map<String, String>> listingTypes = [
      {
        "id": "hostel",
        "emoji": "🏢",
        "title": "Hostel",
        "desc": "University or private hostel with warden and facilities",
      },
      {
        "id": "flat",
        "emoji": "🏘",
        "title": "Flat Pool",
        "desc": "Private apartment — share rent with students",
      },
      {
        "id": "room",
        "emoji": "🏠",
        "title": "Room Sharing",
        "desc": "Furnished rooms — bills split or included",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What are you listing?",
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),

        // Listing Type Selection Cards
        Column(
          children: listingTypes.map((item) {
            bool isSelected = selectedKind == item["id"];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedKind = item["id"]!;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFEBF2FF) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1447E6)
                        : const Color(0xFFE2E8F0),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Text(item["emoji"]!, style: const TextStyle(fontSize: 30)),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? const Color(0xFF1447E6)
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item["desc"]!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1447E6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 14),

        // Continue Button
        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1447E6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              elevation: 3,
            ),
            onPressed: () {
              if (selectedKind.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Select listing type.")),
                );
                return;
              }

              // Step 2 par jane ka action
              widget.onStepChange(2);
            },
            child: const Text(
              "Continue to Step 2",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ADD OPTION STEP 2
  Widget _buildStep2() {
    final nearbyItems = [
      ['food', '🍔', 'Food / Dhaba'],
      ['mosque', '🕌', 'Mosque'],
      ['hospital', '🏥', 'Hospital / Clinic'],
      ['transport', '🚌', 'University Points / Transport'],
      ['market', '🛒', 'Market / Store'],
      ['bank', '🏦', 'ATM / Bank'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('📍', style: TextStyle(fontSize: 15)),
                  SizedBox(width: 6),
                  Text(
                    'Nearby Points of Interest',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.2,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                ),
                itemCount: nearbyItems.length,
                itemBuilder: (context, index) {
                  final item = nearbyItems[index];
                  final isSelected = _nearbyPoints[item[0]] ?? false;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _nearbyPoints[item[0]] = !isSelected;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        color: isSelected ? null : Colors.white,
                        border: Border.all(
                          color: isSelected ? primaryColor : borderColor,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item[1], style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 2),
                          Text(
                            item[2],
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                          if (isSelected)
                            const Text(
                              'Nearby',
                              style: TextStyle(
                                fontSize: 8.5,
                                color: Colors.white70,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _buildTextField(
          '📝',
          'Description',
          'Describe your listing...',
          _descController,
        ),
        _buildTextField(
          '🏛',
          'Near University',
          'Enter Near University',
          _addnearuniController,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => widget.onStepChange(1),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  backgroundColor: secondaryBg,
                  side: BorderSide(color: borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => widget.onStepChange(3),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ADD OPTION STEP 3
  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Power Backup',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildFacilityButton('gen', 'Generator', '🏭'),
            _buildFacilityButton('ups', 'UPS / Battery', '🔋'),
            _buildFacilityButton('sol', 'Solar Panel', '☀️'),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Key Facilities',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildFacilityButton('wifi', 'WiFi', '📶'),
            _buildFacilityButton('mess', 'Mess', '🍽'),
            _buildFacilityButton('cctv', 'CCTV', '📷'),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          '📸 Hostel Images',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 7,
          mainAxisSpacing: 7,
          children:
              [
                ['📷', 'Main Building'],
                ['🛏', 'Rooms'],
                ['🍽', 'Mess Hall'],
                ['📚', 'Study Room'],
                ['🚿', 'Bathroom'],
                ['🚗', 'Parking'],
              ].map((img) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFEFF6FF),
                    border: Border.all(
                      color: const Color(0xFFBFDBFE),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            img[0],
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        color: Colors.white,
                        child: Text(
                          img[1],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF1D4ED8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            border: Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              Text('📤', style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              Text(
                'Upload Your Photos',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF1E3A8A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'JPG, PNG · Max 10MB each',
                style: TextStyle(fontSize: 9.5, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          '🕐 Timings',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            _buildTextField(
              '🌅',
              'Opening Time',
              'e.g. 6:00 AM',
              _openTimeController,
            ),
            _buildTextField(
              '🌙',
              'Closing Time',
              'e.g. 11:00 PM',
              _closeTimeController,
            ),
            _buildTextField(
              '👥',
              'Visiting Hours',
              'e.g. 10AM - 8PM',
              _visitingHoursController,
            ),
            _buildTextField(
              '🔒',
              'Gate Closing',
              'e.g. 10:00 PM',
              _gateClosingController,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => widget.onStepChange(2),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  backgroundColor: secondaryBg,
                  side: BorderSide(color: borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => widget.onStepChange(4),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            border: Border.all(color: const Color(0xFFBFDBFE)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Owner identity verification required for listing approval.',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF1D4ED8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _buildTextField(
          '👤',
          'Owner Full Name',
          'Legal name on CNIC',
          _oNameController,
        ),
        _buildTextField(
          '🪪',
          'CNIC Number',
          '42301-1234567-1',
          _oCnicController,
        ),
        _buildTextField(
          '📱',
          'Contact Number',
          '03xx-xxxxxxx',
          _oPhoneController,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Listing Summary',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildSummaryRow('Type', 'Hostel'),
              _buildSummaryRow('Name', 'INDUS BOYES HOSTEL'),
              _buildSummaryRow('City', 'Jamshoro'),
              _buildSummaryRow('Gender', 'Boys'),
              _buildSummaryRow('Price', 'PKR 12,000/mo'),
              _buildSummaryRow('Slots', '12'),
              _buildSummaryRow('Nearest Uni', 'University Of Sindh Jamshoro'),
              _buildSummaryRow('Distance', '0.5 km — 5 mins'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  'Nearby Points',
                  style: TextStyle(fontSize: 11.5, color: Colors.grey),
                ),
              ),
              Wrap(
                spacing: 4,
                children: _nearbyPoints.entries.where((e) => e.value).map((e) {
                  return Chip(
                    label: Text(e.key.toUpperCase()),
                    backgroundColor: const Color(0xFFEFF6FF),
                    side: const BorderSide(color: Color(0xFFBFDBFE)),
                    labelStyle: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF1D4ED8),
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => widget.onStepChange(3),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  backgroundColor: secondaryBg,
                  side: BorderSide(color: borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFacilityButton(String key, String label, String emoji) {
    final selected = _facilities[key] ?? false;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _facilities[key] = !selected),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF1E3A8A) : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: selected ? const Color(0xFF1E3A8A) : borderColor,
            ),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String icon,
    String label,
    String placeholder,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(icon, style: const TextStyle(fontSize: 14)),
          ),
          labelText: label,
          hintText: placeholder,
          labelStyle: const TextStyle(fontSize: 11),
          hintStyle: const TextStyle(fontSize: 11, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 11.5, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// PROFILE SCREEN
class ProfileScreen extends StatefulWidget {
  final Function(String) setScreen;

  const ProfileScreen({Key? key, required this.setScreen}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  bool showPicker = false;
  int pickerStep = 1;

  final Map<String, String> userData = {
    'fullName': 'Azad Ahmed',
    'surname': 'Bhurgrri',
    'email': 'azad.ahmed.bhurgrri@example.com',
    'fatherName': 'Shabir Ahmed',
    'cnic': '41104-XXXXXXX-X',
    'mob': '0300-2259414',
    'uni': 'University of Sindh, Jamshoro',
    'dept': 'Computer Science',
    'roll': '2K23/CSME/9',
  };

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    _buildAdmissionCard(),
                    if (!isEditing) _buildPersonalInfoCard(),
                    if (isEditing) _buildEditProfileCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 3, 13, 41),
            Color.fromARGB(255, 7, 15, 36),
            Color.fromARGB(255, 2, 26, 83),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(17, 48, 17, 19),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 14,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        userData['fullName']![0],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userData['fullName']} ${userData['surname']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userData['email']!,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          _buildHeaderBadge(
                            'Student',
                            Colors.white12,
                            Colors.white,
                          ),
                          const SizedBox(width: 5),
                          _buildHeaderBadge(
                            'Verified',
                            const Color(0x4716A34A),
                            const Color(0xFF86EFAC),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () => setState(() => isEditing = !isEditing),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 6,
                  ),
                ),
                child: Text(
                  isEditing ? 'Cancel' : 'Edit',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              _buildHeaderStat('📋', '3', 'Applications'),
              const SizedBox(width: 6),
              _buildHeaderStat('✅', 'Admitted', 'Status'),
              const SizedBox(width: 6),
              _buildHeaderStat('⭐', '5', 'Reviews'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 11),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0x1216A34A),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Color(0xFF16A34A),
                    child: Text(
                      '✓',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 9),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Resident',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF16A34A),
                        ),
                      ),
                      Text(
                        'You are currently admitted and residing.',
                        style: TextStyle(fontSize: 10.5, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              CircleAvatar(radius: 4, backgroundColor: Color(0xFF16A34A)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Row(
              children: [
                Text('🏫', style: TextStyle(fontSize: 22)),
                SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'INDUS BOYS HOSTEL',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Hyderabad, Sindh',
                        style: TextStyle(fontSize: 10.5, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => widget.setScreen('card'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              minimumSize: const Size(double.infinity, 38),
            ),
            child: const Text(
              'Full Card 🪪',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 11),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            '👤 Full Name',
            '${userData['fullName']} ${userData['surname']}',
          ),
          _buildInfoRow('👨 Father Name', userData['fatherName']!),
          _buildInfoRow('🪪 CNIC', userData['cnic']!),
          _buildInfoRow('📱 Mobile', userData['mob']!),
          _buildInfoRow('🏛 University', userData['uni']!),
          _buildInfoRow('📚 Department', userData['dept']!),
        ],
      ),
    );
  }

  Widget _buildEditProfileCard() {
    return Container(
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(labelText: 'Full Name'),
            controller: TextEditingController(text: userData['fullName']),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Father Name'),
            controller: TextEditingController(text: userData['fatherName']),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Mobile'),
            controller: TextEditingController(text: userData['mob']),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => setState(() => isEditing = false),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 9, color: text, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildHeaderStat(String emoji, String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.13)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            Text(
              val,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 8.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11.5, color: Colors.grey),
          ),
          Text(
            val,
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// PORTAL SCREEN
class StudentModel {
  final String fullName;
  final String userType;
  final String university;
  final String department;
  final String parentPhone;
  final String studentnumber;
  final String roomNumber;
  final String bedNumber;

  StudentModel({
    required this.fullName,
    required this.userType,
    required this.university,
    required this.department,
    required this.parentPhone,
    required this.studentnumber,
    required this.roomNumber,
    required this.bedNumber,
  });
}

class HostelStudentsPortalWidget extends StatefulWidget {
  final String hostelName;

  const HostelStudentsPortalWidget({Key? key, required this.hostelName})
    : super(key: key);

  @override
  State<HostelStudentsPortalWidget> createState() =>
      _HostelStudentsPortalWidgetState();
}

class _HostelStudentsPortalWidgetState
    extends State<HostelStudentsPortalWidget> {
  final List<StudentModel> students = [
    StudentModel(
      fullName: "Azad Ahmed",
      userType: "Student",
      university: "University Of Sindh",
      department: "Computer Science",
      studentnumber: "+92 300 2259414",
      parentPhone: "+92 300 0XXXXXX",
      roomNumber: "111",
      bedNumber: "Bed 2",
    ),
    StudentModel(
      fullName: "Avinash",
      userType: "Student",
      university: "University Of Sindh",
      department: "Computer Science",
      studentnumber: "313 6795956",
      parentPhone: "+92 313 XXXXXXX",
      roomNumber: "109",
      bedNumber: "Bed 1",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: Text("${widget.hostelName} - Portal"),
          backgroundColor: const Color.fromARGB(255, 19, 5, 75),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 18,
          ),
          elevation: 0,
          toolbarHeight: 100.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF2FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF1447E6),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Registered Boarders",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Total: ${students.length} Residents",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 53, 69, 92),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.people_alt,
                      color: Color(0xFF1447E6),
                      size: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  student.fullName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 5, 3, 3),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: student.userType == "Student"
                                        ? Colors.blue.withValues(alpha: 0.15)
                                        : Colors.orange.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    student.userType,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: student.userType == "Student"
                                          ? const Color(0xFF1447E6)
                                          : Colors.orange[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 18),
                            _buildDetailRow(
                              Icons.domain,
                              "Uni/Company:",
                              student.department,
                            ),
                            const Divider(height: 18),
                            _buildDetailRow(
                              Icons.domain,
                              "Dept/Role:",
                              student.department,
                            ),
                            const SizedBox(height: 6),
                            _buildDetailRow(
                              Icons.meeting_room,
                              "Room / Bed:",
                              "Room ${student.roomNumber} (${student.bedNumber})",
                            ),
                            const SizedBox(height: 6),
                            _buildDetailRow(
                              Icons.phone_android,
                              "Parent Phone:",
                              student.parentPhone,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Text(
          "$label ",
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

// HOSTEL DETAIL SCREEN
class HostelDetailScreen extends StatelessWidget {
  final Map<String, dynamic> hostel;

  const HostelDetailScreen({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 19, 5, 75);
    const lightBg = Color(0xFFF8FAFC);

    return MobileFrame(
      child: Scaffold(
        backgroundColor: lightBg,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  // HEADER BANNER
                  Container(
                    width: double.infinity,
                    color: primaryColor,
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24,
                            elevation: 0,
                            minimumSize: const Size(60, 32),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // ADD HOSTEL IMAGE
                        GestureDetector(
                          onTap: () {
                            // 360 Degree Viewer Dialog Open Karein
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 24,
                                ),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 400,
                                      maxWidth: 700,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        children: [
                                          PanoramaViewer(
                                            child: Image.asset(
                                              "assets/images/boyshostel.jpeg",
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Image.asset(
                                  "assets/images/boyshostel.jpeg",
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                // 360 Badge Overlay
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.threed_rotation,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Tap for 360°",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          hostel["name"] ?? "INDUS BOYS HOSTEL",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${hostel["addr"] ?? 'Gate 1, MUET Campus'}, ${hostel["city"] ?? 'Hyderabad'}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            _buildBadge(
                              "Hostel",
                              const Color.fromARGB(75, 202, 199, 18),
                            ),
                            _buildBadge(
                              "University",
                              const Color.fromARGB(75, 202, 199, 18),
                            ),
                            _buildBadge(
                              "Boys",
                              const Color.fromARGB(75, 202, 199, 18),
                            ),
                            _buildBadge(
                              "12 slots",
                              const Color.fromARGB(75, 202, 199, 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ADD LOCATION BUTTON AND CONNECT GOOGLE API FOR LIVE LOCATION
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${hostel['addr'] ?? 'Live Location'}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.location_pin,
                          color: Color.fromARGB(255, 65, 33, 243),
                        ), // 🗺️ Map Icon Button
                        onPressed: () {
                          // Backend / Google Maps Integration baad me idhar laga gy
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Map Button Clicked")),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        // NEAR UNIVERSITIES
                        _buildCard(
                          title: "🎓 Near Universities",
                          trailing: _buildBadge(
                            "30 mint at bike",
                            Colors.blue.shade100,
                            textColor: primaryColor,
                          ),
                          child: Column(
                            children: [
                              _buildUniTile(
                                "MUET Jamshoro",
                                "18 • 30 min bike",
                                "90",
                                Colors.green,
                              ),
                              const SizedBox(height: 8),
                              _buildUniTile(
                                "Sindh University",
                                "20 km • 30 min by bike",
                                "98",
                                Colors.orange,
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Proximity Score:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // NEARBY POINTS OF INTEREST
                        _buildCard(
                          title: "📍 Nearby Points of Interest",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSubCategory("🍔 Food", [
                                "Cafeteria 50m",
                                "Dhaba 100m",
                                "Canteen 200m",
                              ]),
                              _buildSubCategory("🕌 Mosque", [
                                "Campus Masjid 80m",
                                "Jama Masjid 300m",
                              ]),
                              _buildSubCategory("🏥 Medical", [
                                "UOS Clinic 200m",
                                "Civil Hospital 3km",
                              ]),
                              _buildSubCategory("🚌 Transport", [
                                "Bus Stop 100m",
                                "Auto Stand 500m",
                              ]),
                              _buildSubCategory("🛍️ Shopping", [
                                "Mini Market 150m",
                                "General Store 300m",
                              ]),
                              _buildSubCategory("🏦 Bank", [
                                "HBL ATM 200m",
                                "UBL ATM 400m",
                              ]),
                            ],
                          ),
                        ),

                        // TIME & SCHEDULE
                        _buildCard(
                          title: "🕒 Timings & Schedule",
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTimeBox("🌅 OPENS", "6:00 AM"),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildTimeBox(
                                      "🌙 CLOSES",
                                      "11:00 PM",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTimeBox(
                                      "👥 VISITING",
                                      "10 AM - 8 PM",
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildTimeBox(
                                      "🔗 GATE CLOSE",
                                      "11:00 PM",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // ESTABLISHED SERVICE
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "🏛️ Established in 2005 · 21+ years of service",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // RATINGS
                        _buildCard(
                          title: "Ratings",
                          child: Column(
                            children: [
                              _buildRatingProgress("Power", 0.90, "90%"),
                              _buildRatingProgress("Hygiene", 0.78, "78%"),
                              _buildRatingProgress("Management", 0.82, "82%"),
                              _buildRatingProgress("Mess", 0.85, "85%"),
                              _buildRatingProgress("Security", 0.88, "88%"),
                            ],
                          ),
                        ),

                        // ACCOMMODATION OPTION
                        _buildCard(
                          title: "Accommodation Options",
                          child: Column(
                            children: [
                              _buildAccOption(
                                "Single",
                                "AC + Attached Bath",
                                "PKR 6,500",
                              ),
                              const SizedBox(height: 8),
                              _buildAccOption(
                                "Double",
                                "Fan + Shared Bath",
                                "PKR 4,500",
                              ),
                              const SizedBox(height: 8),
                              _buildAccOption(
                                "Triple",
                                "Fan + Common Bath",
                                "PKR 3,200",
                              ),
                            ],
                          ),
                        ),
                        // FACILITIES IN HOSTEL
                        _buildCard(
                          title: "Facilities",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  _buildBadge(
                                    "📶 Wifi 50MB",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                  _buildBadge(
                                    "📷 CCTV",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                  _buildBadge(
                                    "📚 Study Hall",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                  _buildBadge(
                                    "🍽️ Mess",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                  _buildBadge(
                                    "🏍 Parking",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                  _buildBadge(
                                    "💦 Water 24/7",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                  _buildBadge(
                                    "👕 Laundry",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                  _buildBadge(
                                    "🚿 Saperate Washroom",
                                    const Color(0xFFEFF6FF),
                                    textColor: primaryColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // POWER BACKUP
                              const Text(
                                "Power Backup",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildBackupBox(
                                      "🏭",
                                      "Generator",
                                      "Available",
                                      const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildBackupBox(
                                      "🔋",
                                      "UPS",
                                      "Available",
                                      const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildBackupBox(
                                      "☀️",
                                      "Solar",
                                      "N/A",
                                      Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // MESS MENU
                        _buildCard(
                          title: "Mess Menu",
                          trailing: _buildBadge(
                            "TODAY",
                            const Color.fromARGB(255, 17, 3, 43),
                            textColor: Colors.white,
                          ),
                          backgroundColor: const Color(0xFFEFF6FF),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 2.2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children: [
                              _buildMenuItem("BREAKFAST", "Paratha, Egg, Tea"),
                              _buildMenuItem("LUNCH", "Dal, Rice, Salad"),
                              _buildMenuItem("DINNER", "Biryani / Karahi"),
                              _buildMenuItem("SNACKS", "Samosa, Juice"),
                            ],
                          ),
                        ),
                        // REVIEWS USERS
                        _buildCard(
                          title: "Reviews",
                          child: Column(
                            children: [
                              _buildReviewItem(
                                "A",
                                Colors.blue.shade800,
                                "Shahzad Ali Laghari",
                                "CS 3rd Year",
                                "Power backup is flawless. Management responds quickly.",
                              ),
                              const SizedBox(height: 8),
                              _buildReviewItem(
                                "B",
                                Colors.blue.shade700,
                                "Basheer Ahmed Marri",
                                "EE 2nd Year",
                                "Best mess food in MUET. Highly recommended!",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 11. BOTTOM APPLY NOW BAR
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Starting from",
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                        Text(
                          "PKR 4,500/mo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Application Submitted Successfully!",
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Apply Now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // END OF DEMO DATA IN HOSTELS PAGE

  // Helper Widgets
  Widget _buildCard({
    required String title,
    required Widget child,
    Widget? trailing,
    Color backgroundColor = Colors.white,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, {Color textColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildUniTile(
    String name,
    String details,
    String score,
    Color scoreColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text("🏛️", style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  details,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: scoreColor.withValues(alpha: 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  score,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                  ),
                ),
                const Text(
                  "score",
                  style: TextStyle(fontSize: 7, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategory(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "• $item",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF334155),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // RATINGS OPTIONS
  Widget _buildRatingProgress(String label, double val, String percent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: val,
              backgroundColor: const Color(0xFFF1F5F9),
              color: const Color(0xFF1D4ED8),
              minHeight: 6,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            percent,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D4ED8),
            ),
          ),
        ],
      ),
    );
  }

  // ACCOMMODATION OPTIONS
  Widget _buildAccOption(String title, String desc, String price) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D4ED8),
                  fontSize: 13,
                ),
              ),
              const Text(
                "per month",
                style: TextStyle(fontSize: 9, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // POWER BACKUP
  Widget _buildBackupBox(
    String emoji,
    String title,
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color == const Color.fromARGB(255, 5, 4, 85)
            ? const Color(0xFFF0FDF4)
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color == Colors.green
              ? const Color(0xFFDCFCE7)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // MESS MENU
  Widget _buildMenuItem(String meal, String detail) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            meal,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D4ED8),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            detail,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // REVIEWS USER
  Widget _buildReviewItem(
    String letter,
    Color bg,
    String name,
    String sub,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: bg,
                child: Text(
                  letter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      sub,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Text("⭐⭐⭐⭐⭐", style: TextStyle(fontSize: 9)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 11, color: Color(0xFF334155)),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String label, String time) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}
