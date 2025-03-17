class AuthenticationService {
  Future<String> login(String email, String password) async {
    // Giả lập việc xác thực: thành công nếu email và mật khẩu đúng
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email or password cannot be empty');
    } else if (!emailRegex.hasMatch(email)) {
      throw Exception('Invalid email format');
    } else if (password.length < 6) {
      throw Exception('Password must be at least 6 characters long');
    } else if (email == 'doanvinh@gmail.com' && password == 'password123') {
      return 'Token123';
    } else if (email != 'doanvinh@gmail.com') {
      throw Exception('Email not found');
    } else if (password != 'password123') {
      throw Exception('Incorrect password');
    } else {
      throw Exception('Login Failed');
    }
  }
}