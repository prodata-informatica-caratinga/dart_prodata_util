import 'dart:convert';

import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:dart_prodata_util/src/exceptions/api-error-exception.dart';
import 'package:dart_prodata_util/src/http/interceptors/logging.dart';
import 'package:dart_prodata_util/src/models/api-data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIProvider {
  /// Cria um provedor para requisições em uma API.
  ///
  /// Obs: O parâmetro [baseUrl] deve ser configurado na classe [ProConfig].

  APIProvider._();

  static final APIProvider api = APIProvider._();

  final Dio _apiClient = Dio(
    BaseOptions(
      connectTimeout: 180000, // valor q tá padrão 180000
      sendTimeout: 180000, // valor q tá padrão 180000
      receiveTimeout: 180000, // valor q tá padrão 180000
    ),
  );

  /// Verifica o status do sevidor da API.
  Future<bool> statusServidor() async {
    if (ProConfig.baseUrl.isEmpty) {
      throw ApiErrorException(customMessage: 'URL de comunicação com o servidor não definida.');
    }

    if (_apiClient.interceptors.isEmpty) {
      // se ainda não tiver um interceptor vou adicionar
      _apiClient.interceptors.add(Logging());
    }

    try {
      Response retorno;
      retorno = await _apiClient.get(ProConfig.baseUrl);
      if (retorno.statusCode != 200) {
        throw ApiErrorException(response: retorno);
      }

      return true;
    } on DioError catch (e,s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          (e.type == DioErrorType.other && e.message.contains('SocketException'))
      ) {
        throw ApiErrorException(customMessage: 'Servidor não encontrado ou não respondeu.');
      }

      if (kDebugMode) {
        print('Passou no DioError do APIProvider.statusServidor: ${e.response}\n$s');
      }

      throw ApiErrorException(response: e.response);
    } catch (e,s) {
      if (kDebugMode) {
        print('Passou no catch do APIProvider.statusServidor: $e\n$s');
      }

      throw ApiErrorException(customMessage: e.toString());
    }
  }

  /// Executa uma requisição [get] na API e retorna a [data] de sua [Response].
  Future<dynamic> get(String url) async {
    if (ProConfig.baseUrl.isEmpty) {
      throw ApiErrorException(customMessage: 'URL de comunicação com o servidor não definida.');
    }

    if (_apiClient.interceptors.isEmpty) {
      // se ainda não tiver um interceptor vou adicionar
      _apiClient.interceptors.add(Logging());
    }

    try {
      Response retorno;
      retorno = await _apiClient.get('$ProConfig.baseUrl/$url');
      if (retorno.statusCode != 200 || retorno.data == null) {
        throw ApiErrorException(response: retorno);
      }

      return retorno.data;
    } on DioError catch (e,s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          (e.type == DioErrorType.other && e.message.contains('SocketException'))
      ) {
        throw ApiErrorException(customMessage: 'Servidor não encontrado ou não respondeu.');
      }

      if (kDebugMode) {
        print('Passou no DioError do APIProvider.get: ${e.response}\n$s');
      }
      throw ApiErrorException(response: e.response);
    } catch (e,s) {
      if (kDebugMode) {
        print('Passou no catch do APIProvider.get: $e\n$s');
      }

      throw ApiErrorException(customMessage: e.toString());
    }
  }

  /// Executa uma requisição [post] na API e retorna a [data] de sua [Response].
  Future<dynamic> post(String url, {Map? headers, body, encoding}) async {
    if (_apiClient.interceptors.isEmpty) {
      // se ainda não tiver um interceptor vou adicionar
      _apiClient.interceptors.add(Logging());
    }

    if (ProConfig.baseUrl.isEmpty) {
      throw ApiErrorException(customMessage: 'URL de comunicação com o servidor não definida.');
    }

    try {
      Response retorno;
      retorno = await _apiClient.post('$ProConfig.baseUrl/$url', data: jsonEncode(body));
      if (retorno.statusCode != 200 || retorno.data == null) {
        throw ApiErrorException(response: retorno);
      }

      return retorno.data;
    } on DioError catch (e,s) {
      if (kDebugMode) {
        print('Passou no DioError do APIProvider.post: $e\n$s');
      }

      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          (e.type == DioErrorType.other && e.message.contains('SocketException'))) {
        throw ApiErrorException(customMessage: 'Servidor não encontrado ou não respondeu. Url: $ProConfig.baseUrl/$url - ${e.message} - ${e.type}');
      }

      throw ApiErrorException(response: e.response);
    } catch (e,s) {
      if (kDebugMode) {
        print('Passou no catch do APIProvider.post: $e\n$s');
      }

      throw ApiErrorException(customMessage: e.toString());
    }
  }

  /// Executa uma requisição [post] na API com base no [filtro] informado e retorna uma [List] de dados da sua [Response].
  Future<List> getAll(String url, {ApiData? filtro}) async {
    try {
      final dados = ApiData();
      dados.perPage = 99999;
      dados.page = 1;

      final res = await post(url, body: (filtro ?? dados).toJson());

      return res['data'];
    } on ApiErrorException catch (e,s) {
      if(kDebugMode) {
        print('Passou no ApiErrorException do APIProvider.getAll: $e\n$s');
      }
      e.showSnackBar();
    } catch (e,s) {
      // criar um tratamento padrão pra erros genericos depois
      if (kDebugMode) {
        print('Passou no catch do APIProvider.getAll: $e\n$s');
      }
    }

    return [];
  }

  /// Executa um [delete] na API com base no [body] informado.
  Future<bool> delete(String url, {Map? headers, body}) async {
    if (_apiClient.interceptors.isEmpty) {
      // se ainda não tiver um interceptor vou adicionar
      _apiClient.interceptors.add(Logging());
    }

    if (ProConfig.baseUrl.isEmpty) {
      throw ApiErrorException(customMessage: 'URL de comunicação com o servidor não definida.');
    }

    try {
      Response retorno;
      retorno = await _apiClient.delete('$ProConfig.baseUrl/$url', data: jsonEncode(body));
      if (retorno.statusCode != 200 || retorno.data == null) {
        throw ApiErrorException(response: retorno);
      }

      return true;
    } on DioError catch (e,s) {
      if (kDebugMode) {
        print('Passou no DioError do APIProvider.delete: $e\n$s');
      }

      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          (e.type == DioErrorType.other && e.message.contains('SocketException'))) {
        throw ApiErrorException(customMessage: 'Servidor não encontrado ou não respondeu. Url: $ProConfig.baseUrl/$url - ${e.message} - ${e.type}');
      }

      if (kDebugMode) {
        print(e.response);
      }
      throw ApiErrorException(response: e.response);
    } catch (e,s) {
      if (kDebugMode) {
        print('Passou no catch do APIProvider.delete: $e\n$s');
      }

      throw ApiErrorException(customMessage: e.toString());
    }
  }
}