class AuthenticationService {
  Future<String> login(String email, String password) async {
    // Giả lập việc xác thực: thành công nếu email và mật khẩu đúng
    if (email == 'doanvinh@gmail.com' && password == 'password123') {
      return 'Token123';
    } else {
      throw Exception('Login Failed');
    }
  }
}