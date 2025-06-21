import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CastarSDK Client ID App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CastarSDKScreen(),
    );
  }
}

class CastarSDKScreen extends StatefulWidget {
  const CastarSDKScreen({super.key});

  @override
  State<CastarSDKScreen> createState() => _CastarSDKScreenState();
}

class _CastarSDKScreenState extends State<CastarSDKScreen> {
  final TextEditingController _clientIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _enteredClientId;
  bool _isSDKInitialized = false;
  static const platform = MethodChannel('com.example.castarsdk/channel');

  @override
  void initState() {
    super.initState();
    _initializeSDK();
  }

  @override
  void dispose() {
    _clientIdController.dispose();
    super.dispose();
  }

  Future<void> _initializeSDK() async {
    try {
      final bool result = await platform.invokeMethod('initializeCastarSDK');
      setState(() {
        _isSDKInitialized = result;
      });
    } on PlatformException catch (e) {
      print("Failed to initialize CastarSDK: '${e.message}'.");
    }
  }

  Future<void> _submitClientId() async {
    if (_formKey.currentState!.validate()) {
      final clientId = _clientIdController.text;

      try {
        final bool result = await platform.invokeMethod('setClientId', {
          'clientId': clientId,
        });

        if (result) {
          setState(() {
            _enteredClientId = clientId;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('CastarSDK initialized with Client ID: $clientId'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } on PlatformException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.message}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CastarSDK Manager'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // SDK Status
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isSDKInitialized
                        ? Colors.green.shade50
                        : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isSDKInitialized
                          ? Colors.green.shade200
                          : Colors.orange.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isSDKInitialized ? Icons.check_circle : Icons.warning,
                        color: _isSDKInitialized
                            ? Colors.green.shade600
                            : Colors.orange.shade600,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _isSDKInitialized
                              ? 'CastarSDK is ready'
                              : 'CastarSDK initializing...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isSDKInitialized
                                ? Colors.green.shade700
                                : Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // App Icon
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.monetization_on_outlined,
                    size: 60,
                    color: Colors.deepPurple.shade600,
                  ),
                ),

                const SizedBox(height: 40),

                // Title
                Text(
                  'CastarSDK Client ID',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade800,
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Enter your CastarSDK client ID to start monetizing your app',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Client ID Input Field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _clientIdController,
                    decoration: InputDecoration(
                      labelText: 'Client ID',
                      hintText: 'Enter your CastarSDK client ID...',
                      prefixIcon: Icon(
                        Icons.key,
                        color: Colors.deepPurple.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a client ID';
                      }
                      if (value.length < 5) {
                        return 'Client ID must be at least 5 characters';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Submit Button
                ElevatedButton(
                  onPressed: _isSDKInitialized ? _submitClientId : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'Initialize CastarSDK',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Display entered client ID
                if (_enteredClientId != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.shade200,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.green.shade600,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'CastarSDK Initialized Successfully!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Client ID: $_enteredClientId',
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your app is now ready to generate revenue!',
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
