import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_supabase/main.dart';
import 'package:todo_app_supabase/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() { _isLoading = true; });

    try {
      await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Success! Account created.')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on AuthException catch (error) {
      print('--- TERJADI ERROR SUPABASE AUTH (SIGN UP) ---');
      print(error.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } catch (error) {
      print('--- TERJADI ERROR UMUM (SIGN UP) ---');
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred'), backgroundColor: Colors.red),
      );
    }

    if (mounted) {
      setState(() { _isLoading = false; });
    }
  }

  Future<void> _signIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() { _isLoading = true; });

    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on AuthException catch (error) {
      print('--- TERJADI ERROR SUPABASE AUTH (SIGN IN) ---');
      print(error.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } catch (error) {
      print('--- TERJADI ERROR UMUM (SIGN IN) ---');
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred'), backgroundColor: Colors.red),
      );
    }

    if (mounted) {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            const Text('Sign in via email and password'),
            const SizedBox(height: 18),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (val) {
                if (val == null || val.isEmpty) { return 'Required'; }
                return null;
              },
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (val) {
                if (val == null || val.isEmpty) { return 'Required'; }
                return null;
              },
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn,
              child: Text(_isLoading ? 'Loading...' : 'Sign In'),
            ),
            TextButton(
              onPressed: _isLoading ? null : _signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}