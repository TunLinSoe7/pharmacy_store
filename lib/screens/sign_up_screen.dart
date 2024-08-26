import 'package:flutter/material.dart';
import 'package:pharmacy_store/provider/sign_up_provider.dart';
import 'package:pharmacy_store/screens/sign_in_screen.dart';
import 'package:pharmacy_store/utils/constants/colors.dart';
import 'package:pharmacy_store/utils/validators/validators.dart';
import 'package:provider/provider.dart';
import '../utils/helper_functions/helper_functions.dart';
import '../widgets/auth_widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>SignUpProvider(),
      child: Consumer<SignUpProvider>(
        builder: (_,provider,__)=>SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: ()=>Navigator.of(context).pop(),
                child: const Icon(Icons.clear),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Text('Sign Up',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20
                  ),),
                  const SizedBox(height: 20,),
                  TextFormFieldWidget(
                    validator: (value)=>Validators.validateName(value),
                    errorText: provider.nameError,
                    hintText: 'Name',controller: provider.nameController,
                  ),

                  TextFormFieldWidget(
                    validator: (value)=>Validators.validateEmail(value),
                    errorText: provider.emailError,
                    hintText: 'Email',controller: provider.emailController,),
                  TextFormFieldWidget(
                    validator: (value)=>Validators.validateMyanmarPhoneNumber(value),
                    errorText: provider.phoneError,
                    hintText: 'Phone Number',controller:provider.phoneController,),
                  TextFormFieldWidget(
                    validator: (value)=>Validators.validatePassword(value),
                    errorText: provider.passwordError,
                    hintText: 'Password',obscureText: true,
                    controller: provider.passwordController,),
                  TextFormFieldWidget(
                    validator: (value)=>Validators.validateConfirmPassword(value, provider.passwordController.text),
                    errorText: provider.confirmPasswordError,
                    hintText: 'Confirm Password',obscureText: true,
                    controller: provider.confirmPasswordController,
                    suffixIcon: Icons.visibility_off,
                  ),

                  LoginAndSignUpBtnWidget(title: 'Sing up',onTap: (){
                    provider.submit(context);
                  },
                    isLoading: provider.isLoading,
                  ),
                  const SocialLoginButtonWidget(title: 'SignUp with Facebook',borderColor: kPrimaryColor,titleColor: kPrimaryColor,),
                  const SocialLoginButtonWidget(title: 'SignUp with Google',borderColor: Colors.red,titleColor: Colors.red,),
                  HaveAnAccWidget(onTap:(){
                    navigateToScreen(const SignInScreen(), context);
                  },title: 'Already have an account?',subTitle: ' Login',)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





