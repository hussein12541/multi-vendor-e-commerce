import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('⏱️ الاتصال بالخادم استغرق وقتًا طويلاً');

      case DioExceptionType.sendTimeout:
        return ServerFailure('📤 لم يتم إرسال الطلب في الوقت المحدد');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('📥 لم يتم استقبال الاستجابة في الوقت المحدد');

      case DioExceptionType.badCertificate:
        return ServerFailure('🔐 فشل التحقق من الشهادة الأمنية');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure('❌ تم إلغاء الطلب');

      case DioExceptionType.connectionError:
        return ServerFailure('🔌 فشل الاتصال بالخادم، تحقق من الشبكة');

      case DioExceptionType.unknown:
        final message = dioError.message?.toLowerCase() ?? '';
        if (message.contains('socketexception')) {
          return ServerFailure('🚫 لا يوجد اتصال بالإنترنت');
        } else if (message.contains('handshake')) {
          return ServerFailure('🤝 مشكلة في التحقق من الاتصال (Handshake)');
        } else if (message.contains('network is unreachable')) {
          return ServerFailure('🌐 الشبكة غير متاحة، افصل وشبك تاني');
        } else if (message.contains('formatexception')) {
          return ServerFailure('📄 البيانات اللي رجعت من السيرفر مش مفهومة');
        } else if (message.contains('type') || message.contains('cast')) {
          return ServerFailure('🔁 خطأ في نوع البيانات (Casting issue)');
        } else if (message.contains('timeout')) {
          return ServerFailure('⌛ انتهت مهلة التنفيذ');
        }
        return ServerFailure('💥 حصل خطأ غير متوقع، حاول تاني');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    try {
      final message = response['error']['message'] ??
          response['message'] ??
          response.toString();

      switch (statusCode) {
        case 400:
          return ServerFailure('طلب غير صحيح: $message');
        case 401:
          return ServerFailure('غير مصرح به: $message');
        case 403:
          return ServerFailure('تم رفض الوصول: $message');
        case 404:
          return ServerFailure('❓ لم يتم العثور على الطلب');
        case 409:
          return ServerFailure('🔁 يوجد تعارض في البيانات: $message');
        case 422:
          return ServerFailure('📋 البيانات غير صالحة: $message');
        case 429:
          return ServerFailure('🚫 عدد كبير جدًا من المحاولات، استنى شوية');
        case 500:
          return ServerFailure('💣 مشكلة في الخادم، جرب تاني بعدين');
        case 502:
          return ServerFailure('🔧 الخادم لا يستجيب بشكل صحيح');
        case 503:
          return ServerFailure('🔌 الخادم مش متاح حاليًا');
        case 504:
          return ServerFailure('🕓 انتهت مهلة الرد من الخادم');
        default:
          return ServerFailure('😵 خطأ غير معروف (${statusCode ?? "؟"})');
      }
    } catch (e) {
      return ServerFailure('⚠️ حصل خطأ أثناء تحليل استجابة الخطأ');
    }
  }
}
