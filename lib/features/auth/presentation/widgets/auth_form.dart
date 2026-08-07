import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';

class AuthForm extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final VoidCallback onForgotPassword;
  final bool isLogin;
  final bool showError;
  final String? errorMessage;

  const AuthForm({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.onForgotPassword,
    this.isLogin = true,
    this.showError = false,
    this.errorMessage,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();
  final _nameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePin = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _pinController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!widget.isLogin) ...[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email (optional)',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            validator: widget.isLogin
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  }
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _pinController,
            decoration: InputDecoration(
              labelText: '4-Digit PIN',
              prefixIcon: const Icon(Icons.pin_outlined),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePin
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _obscurePin = !_obscurePin);
                },
              ),
            ),
            obscureText: _obscurePin,
            keyboardType: TextInputType.number,
            maxLength: 4,
            validator: (value) {
              if (value == null || value.length < 4) {
                return 'Please enter a 4-digit PIN';
              }
              return null;
            },
          ),
          if (widget.showError && widget.errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.errorMessage!,
              style: TextStyle(color: AppColors.error),
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.isLogin ? _handleLogin : _handleRegister,
            child: Text(widget.isLogin ? 'LOGIN' : 'REGISTER'),
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onLogin();
    }
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onRegister();
    }
  }
}
