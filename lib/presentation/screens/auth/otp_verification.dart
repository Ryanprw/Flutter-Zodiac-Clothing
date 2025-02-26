import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'change_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final int _otpCodeLength = 4;
  bool _enableButton = false;
  bool _isLoadingButton = false;

  void _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      if (otpCode.length == _otpCodeLength) {
        _enableButton = true;
      } else {
        _enableButton = false;
      }
    });
  }

  void _verifyOtp() {
    setState(() {
      _isLoadingButton = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoadingButton = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter OTP',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We have sent a code to your number.\nEnter it below to verify.',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              TextFieldPin(
                textController: _otpController,
                autoFocus: true,
                codeLength: _otpCodeLength,
                alignment: MainAxisAlignment.center,
                defaultBoxSize: 50.0,
                margin: 12,
                selectedBoxSize: 50.0,
                textStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                defaultDecoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(8),
                ),
                selectedDecoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                onChange: (code) {
                  _onOtpCallBack(code, false);
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _enableButton ? Colors.black : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      _enableButton && !_isLoadingButton ? _verifyOtp : null,
                  child:
                      _isLoadingButton
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                            'Verify',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend Code',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
