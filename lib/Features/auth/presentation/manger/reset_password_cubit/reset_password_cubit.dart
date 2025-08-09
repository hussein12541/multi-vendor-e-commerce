import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../../../../core/utils/api_services.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final ApiServices _api =ApiServices();
  Future<void> sendEmail({required String toEmail}) async {
    emit(ResetPasswordLoading());

    try {
      final response = await _api.getData(path: "users?select=password&email=eq.$toEmail");
      if (response.data == null || response.data.isEmpty) {
        emit(ResetPasswordError());
        print('No user found with this email.');
        return;
      }
      String body = response.data[0]["password"];

      String username = 'multivendorflutter@gmail.com';
      String password = 'apli bvxw ikpu xutr'; // تأكد من أن هذا App Password

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, 'المتجر الإلكتروني')
        ..recipients.add(toEmail)
        ..subject = 'استعادة كلمة المرور'
        ..html = '''
        <h3>مرحبًا!</h3>
        ${(body == '')
            ? '<p>لقد قمت بالتسجيل باستخدام جوجل، لذا لا يمكننا إرسال كلمة المرور. يرجى تسجيل الدخول باستخدام حساب جوجل.</p>'
            : '<p>كلمة المرور الخاصة بك هي : <strong>$body</strong></p>'}
        <p>إذا لم تطلب استعادة كلمة المرور، يرجى التواصل معنا على <a href="mailto:support@shop.com">support@shop.com</a>.</p>
        <p>إذا وصلت هذه الرسالة إلى البريد العشوائي، يرجى نقلها إلى البريد الوارد وإضافة بريدنا إلى جهات الاتصال.</p>
        <p>شكرًا، فريق المتجر الإلكتروني</p>
      ''';

      final sendReport = await send(message, smtpServer);
      print('Email sent: $sendReport');
      emit(ResetPasswordSuccess());
    } on MailerException catch (e) {
      emit(ResetPasswordError());
      print('Email not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
