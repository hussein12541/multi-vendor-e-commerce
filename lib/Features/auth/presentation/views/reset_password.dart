import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';

import '../../../../core/utils/functions/show_message.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../../core/utils/widgets/custom_text_field.dart';
import '../../../../core/utils/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../manger/reset_password_cubit/reset_password_cubit.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController=TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).forget_password_title),
          centerTitle: true,
        ),
        body: BlocConsumer<ResetPasswordCubit,ResetPasswordState>(
          builder: (context, state) {
            if(state is ResetPasswordLoading){
              return Center(child: loadingWidget(context));
            }else{

              return SingleChildScrollView(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  SizedBox(height: 10,),

                  Text(S.of(context).forget_password_content,style: AppStyles.semiBold16(context)),
                  SizedBox(height: 30),
                  CustomTextFormField(hintText: S.of(context).email, controller: emailController)
                  , SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomButton(onPressed: () async {
                      await context.read<ResetPasswordCubit>().sendEmail(toEmail: emailController.text);
                    }, text:S.of(context).forget_password_title ),
                  )
                ],),
              ),);
            }
          }, listener: (BuildContext context, ResetPasswordState state) {
          if(state is ResetPasswordSuccess){
            emailController.clear();
            ShowMessage.showToast(S.of(context).sendOTP,backgroundColor: Colors.green);

          }
          if(state is ResetPasswordError){
            ShowMessage.showToast(S.of(context).sendOTP_error,);

          }
        },
        ),
      ),
    );
  }
}
