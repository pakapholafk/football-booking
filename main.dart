import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'จองสนามฟุตบอล',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  final name = TextEditingController();
  final phone = TextEditingController();
  final date = TextEditingController();
  final time = TextEditingController();

  final List<String> bookings = [];

  final List<String> fields = [
    'สนาม Green Arena - 600 บาท/ชั่วโมง',
    'สนาม Football Park - 800 บาท/ชั่วโมง',
    'สนาม Champion Field - 1,000 บาท/ชั่วโมง',
  ];

  void bookField(String field) {
    name.clear();
    phone.clear();
    date.clear();
    time.clear();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('จองสนามฟุตบอล')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(field, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'ชื่อผู้จอง',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'เบอร์โทรศัพท์',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: date,
                  decoration: const InputDecoration(
                    labelText: 'วันที่จอง เช่น 25/10/2026',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: time,
                  decoration: const InputDecoration(
                    labelText: 'เวลาจอง เช่น 18:00',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    if (name.text.isEmpty ||
                        phone.text.isEmpty ||
                        date.text.isEmpty ||
                        time.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('กรุณากรอกข้อมูลให้ครบ'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      bookings.add(
                        '$field\\nชื่อ: ${name.text}\\n'
                        'โทร: ${phone.text}\\n'
                        'วันที่: ${date.text}\\nเวลา: ${time.text}',
                      );
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('จองสนามสำเร็จ'),
                      ),
                    );
                  },
                  child: const Text('ยืนยันการจอง'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    date.dispose();
    time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚽ Football Booking')),
      body: page == 0
          ? ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'เลือกสนามฟุตบอล',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...fields.map(
                  (field) => Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.sports_soccer,
                        color: Colors.green,
                        size: 40,
                      ),
                      title: Text(field),
                      subtitle: const Text('เปิดให้บริการทุกวัน'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => bookField(field),
                    ),
                  ),
                ),
              ],
            )
          : page == 1
              ? bookings.isEmpty
                  ? const Center(child: Text('ยังไม่มีรายการจอง'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: bookings.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          title: Text(bookings[index]),
                          isThreeLine: true,
                        ),
                      ),
                    )
              : const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, size: 70, color: Colors.green),
                      SizedBox(height: 12),
                      Text(
                        'ผู้ใช้งาน Football Booking',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (index) {
          setState(() => page = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'รายการจอง',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
        ],
      ),
    );
  }
}
