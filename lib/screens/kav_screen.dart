import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KavScreen extends StatefulWidget {
  const KavScreen({Key? key}) : super(key: key);

  @override
  _KavScreenState createState() => _KavScreenState();
}

class _KavScreenState extends State<KavScreen> {
  static const platform = MethodChannel('com.example.checkroot/channel');

  final List<Map<String, dynamic>> features = [
    {
      'name': 'Check Root',
      'icon': Icons.security,
      'enabled': false,
    },
    {
      'name': 'App Monitor',
      'icon': Icons.monitor,
      'enabled': false,
    },
    {
      'name': 'Easy Scan',
      'icon': Icons.qr_code_scanner,
      'enabled': false,
    },
    {
      'name': 'Web Filter',
      'icon': Icons.web,
      'enabled': false,
    },
  ];

  Future<void> checkRootStatus() async {
    try {
      final String result = await platform.invokeMethod('checkRoot');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Root Status'),
          content: Text(result == 'YES'
              ? 'This device is rooted.'
              : 'This device is not rooted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } on PlatformException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to check root status: ${e.message}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KavScreen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF4166F5),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.blue[50],
        child: ListView.builder(
          itemCount: features.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Icon(
                    features[index]['icon'],
                    color: Color(0xFF4166F5),
                  ),
                ),
                title: Text(
                  features[index]['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[800],
                  ),
                ),
                trailing: Switch(
                  value: features[index]['enabled'],
                  activeColor: Color(0xFF4166F5),
                  inactiveTrackColor: Colors.grey[100],
                  inactiveThumbColor: Colors.grey[500],
                  onChanged: (bool newValue) {
                    setState(() {
                      features[index]['enabled'] = newValue;
                      if (features[index]['name'] == 'Check Root' && newValue) {
                        checkRootStatus();
                      }
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
