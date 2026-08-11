import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

typedef AuthSubmit =
    Future<bool> Function(String phone, String email, String password, String pin, String name);

class AuthForm extends StatefulWidget {
  final AuthSubmit onSubmit;
  final VoidCallback onSwitchMode;
  final VoidCallback onForgotPassword;
  final bool isLogin;

  const AuthForm({
    super.key,
    required this.onSubmit,
    required this.onSwitchMode,
    required this.onForgotPassword,
    this.isLogin = true,
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
  bool _submitting = false;

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
    final errorMessage = context.watch<AuthProvider>().errorMessage;

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
            validator: (value) {
              if (widget.isLogin && _pinController.text.trim().isEmpty &&
                  (value == null || value.isEmpty)) {
                return 'Enter a password or PIN';
              }
              return null;
            },
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
              final trimmed = value?.trim() ?? '';
              if (trimmed.isEmpty) {
                if (_passwordController.text.isEmpty && !widget.isLogin) {
                  return 'Enter a password or PIN';
                }
                if (widget.isLogin && _passwordController.text.isEmpty) {
                  return null; // error already shown on the password field
                }
                return null;
              }
              if (trimmed.length != 4) {
                return 'Enter a 4-digit PIN';
              }
              return null;
            },
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: TextStyle(color: AppColors.error),
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitting ? null : _handleSubmit,
            child: _submitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(widget.isLogin ? 'LOGIN' : 'REGISTER'),
          ),
          TextButton(
            onPressed: widget.isLogin ? () => widget.onSwitchMode() : widget.onSwitchMode,
            child: Text(widget.isLogin ? "Don't have an account? Register" : 'Already have an account? Login'),
          ),
          TextButton(
            onPressed: widget.onForgotPassword,
            child: const Text('Forgot your password?'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _submitting = true);
      await widget.onSubmit(
        _phoneController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
        _pinController.text,
        _nameController.text.trim(),
      );
      if (!mounted) return;
      setState(() => _submitting = false);
    }
  }
}