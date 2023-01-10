import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user/lib.dart';

//Add Age selector

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  String? myGender;
  String? phone, phoneNumber, phoneCountryCode, phoneCountryISOCode;
  String? country, countryCode, countryDialCode, countryFlag;

  bool showP = true, showC = true;

  Future signup() async {
    // if(!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    Provider.of<UserInformation>(context, listen: false).updateUserInformation(
      newEmail: email.text.trim(), newFirstName: firstName.text.trim(), newLastName: lastName.text.trim(), newPhone: phone.toString(),
      newPhoneNumber: phoneNumber.toString(), newPassword: password.text.trim(), newEmailAddress: email.text.trim(),
      newCountry: country.toString(), newCountryDialCode: countryDialCode.toString(), newGender: myGender.toString(),
      newPhoneCountryCode: phoneCountryCode.toString(), newPhoneCountryISOCode: phoneCountryISOCode.toString(),
    );
    Get.offAll(() => const ChooseServiceScreen());
    // final authProvide = Provider.of<Auth>(context, listen: false);
    // authProvide.signUp(
    //   password: password.text.trim(), email: email.text.trim(), firstName: firstName.text.trim(),
    //   lastName: lastName.text.trim(), phoneNumber: phoneNumber.toString(), gender: myGender.toString(), country: country.toString(),
    //   countryCode: countryCode.toString(), countryDialCode: countryDialCode.toString(), countryFlag: countryFlag.toString(),
    //   phone: phone.toString(), phoneCountryCode: phoneCountryCode.toString(), phoneCountryISOCode: phoneCountryISOCode.toString()
    // );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: screenPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SText(
              text: "Create a Serch Account",
              weight: FontWeight.w900,
              size: 22,
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            const SizedBox(height: 5),
            const SText(
              text: "We can't wait to see you onboard",
              weight: FontWeight.w500,
              size: 16,
              color: SColors.hint
            ),
            const SizedBox(height: 40),
            SFormField(
              labelText: "John",
              formName: "First Name *",
              controller: firstName,
              validate: Validators.name,
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).scaffoldBackgroundColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            SFormField(
              labelText: "Doe",
              formName: "Last Name *",
              controller: lastName,
              validate: Validators.name,
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).scaffoldBackgroundColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            SFormField(
              labelText: "johndoe@gmail.com",
              formName: "Email Address *",
              controller: email,
              validate: Validators.email,
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).scaffoldBackgroundColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            SPhoneField(
              labelText: "Your legal phone number",
              formName: "Phone Number *",
              formStyle: STexts.authForm(context),
              onPhoneChanged: (value) {
                setState(() => phoneNumber = value.completeNumber);
                setState(() => phoneCountryISOCode = value.countryISOCode);
                setState(() => phoneCountryCode = value.countryCode.toString());
                setState(() => phone = value.number);
              },
              onCountryChanged: (value) {
                setState(() => country = value.name);
                setState(() => countryCode = value.code);
                setState(() => countryDialCode = value.dialCode);
                setState(() => countryFlag = value.flag);
              },
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            SDropDown(
              list: gender,
              hintText: "Select your gender",
              formName: "Gender *",
              validate: Validators.gender,
              onChanged: (value) => setState(() => myGender = value.toString()),
              onSaved: (value) => setState(() => myGender = value.toString()),
              fillColor: Theme.of(context).primaryColor,
              formColor: Theme.of(context).scaffoldBackgroundColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
            ),
            SFormField.password(
              labelText: "Create a strong password",
              formName: "Password *",
              controller: password,
              obscureText: showP,
              icon: showP ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
              onPressed: () => setState(() => showP = !showP),
              validate: Validators.password,
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).scaffoldBackgroundColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
              suffixColor: Theme.of(context).primaryColorLight,
            ),
            SFormField.password(
              labelText: "Enter your strong password again",
              formName: "Confirm Password *",
              controller: confirm,
              obscureText: showC,
              icon: showC ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
              onPressed: () => setState(() => showC = !showC),
              validate: (value) => value != password.text ? "Password does not match" : null,
              inputAction: TextInputAction.done,
              cursorColor: Theme.of(context).scaffoldBackgroundColor,
              fillColor: Theme.of(context).primaryColor,
              formStyle: STexts.authForm(context),
              formColor: Theme.of(context).scaffoldBackgroundColor,
              enabledBorderColor: Theme.of(context).backgroundColor,
              suffixColor: Theme.of(context).primaryColorLight,
            ),
            const SizedBox(height: 40),
            Consumer<Auth>(
              builder: (context, authProvide, _) => SButton(
                text: "Sign me up",
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                textWeight: FontWeight.bold,
                textSize: 18,
                loading: authProvide.isLoading,
                onClick: () => signup(),
              ),
            ),
            const SizedBox(height: 40),
            SButtonText(
              text: "Already have an account?",
              textButton: "Log Me In",
              textColor: Theme.of(context).scaffoldBackgroundColor,
              textButtonColor: SColors.lightPurple,
              onClick: () => Get.to(() => const LoginScreen()),
            ),
            const SizedBox(height: 40)
          ],
        )
      ),
    );
  }
}