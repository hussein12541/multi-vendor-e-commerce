
import 'package:dio/dio.dart';



class ApiServices {

  final Dio _dio = Dio(BaseOptions(

      baseUrl: 'https://hegfuluilgqgbcvtnymv.supabase.co/rest/v1/',

      headers: {

        "apikey":

       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhlZ2Z1bHVpbGdxZ2JjdnRueW12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM5NjY4MTAsImV4cCI6MjA2OTU0MjgxMH0.1_zZ2sKOW0FKobr9V8FwAfq2kaqF6CdiQS42PU71HfM"
      }));

  Future<Response> getData({required String path}) async {

    return await _dio.get(path);

  }

  Future<Response> deleteData({required String path}) async {

    return await _dio.delete(path);

  }



  Future<Response> postData(

      {required String path, required Map<String, dynamic> data}) async {

    return await _dio.post(

      path,

      data: data,

    );

  }



  Future<Response>



  patchData(

      {required String path, required Map<String, dynamic> data}) async {

    return await _dio.patch(path, data: data);

  }

}


