class AppError {
  /// Cria uma formatação de uma mensagem de erro vinda da [API] ou de uma [String] informada.

  bool success = false;
  String message = '';
  List<AppErrorDetail> details = [];

  AppError();

  AppError.withMessage(String message) {
    details.add(AppErrorDetail.withMessage(message));
  }

  AppError.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['details'] != null) {
      details = <AppErrorDetail>[];
      json['details'].forEach((v) {
        details.add(AppErrorDetail.fromJson(v));
      });
    } else {
      details = <AppErrorDetail>[];
      details.add(AppErrorDetail.withMessage(message));
    }
  }
}

class AppErrorDetail {
  int code = 0;
  String message = '';

  AppErrorDetail.withMessage(this.message);

  AppErrorDetail.fromJson(Map<String, dynamic> json) {
    code = int.tryParse(json['code'].toString()) ?? 0;
    message = json['message'] ?? json['mensagem'];
  }
}