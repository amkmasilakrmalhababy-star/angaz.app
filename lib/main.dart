import 'package:flutter/material.dart';

void main() {
  runApp(const EnjazApp());
}

class EnjazApp extends StatefulWidget {
  const EnjazApp({super.key});

  @override
  State<EnjazApp> createState() => _EnjazAppState();
}

class _EnjazAppState extends State<EnjazApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق إنجاز',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'YE'), // توجيه التطبيق باللغة العربية ومن اليمين لليسار
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF4F6EF7),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        cardColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4F6EF7),
          secondary: Color(0xFFF7A44F), // Accent color
          error: Color(0xFFE74C3C),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6B8AFF),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
        cardColor: const Color(0xFF1A1A2E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6B8AFF),
          secondary: Color(0xFFF7B06A),
          error: Color(0xFFF06050),
        ),
        useMaterial3: true,
      ),
      home: MainDashboard(
        isDarkMode: _isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}

// الشاشة الرئيسية التي تحتوي على شريط التنقل السفلي (Bottom Navigation)
class MainDashboard extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainDashboard({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  // قائمة المهام التجريبية لمحاكاة القالب
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'مراجعة كود فلاتر الجديد', 'category': 'عمل', 'priority': 'high', 'isCompleted': false},
    {'title': 'قراءة كتاب الدارات المنطقية', 'category': 'دراسة', 'priority': 'medium', 'isCompleted': true},
  ];

  @override
  Widget build(BuildContext context) {
    // الفهرس يحدد أي واجهة تعرض للمطور
    final List<Widget> views = [
      _buildTasksView(),
      _buildAchievementsView(),
      _buildStatsView(),
      _buildRewardsView(),
      _buildProfileView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('✅ ', style: TextStyle(fontSize: 22)),
            Text('إنجاز', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        elevation: 2,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => widget.onThemeChanged(!widget.isDarkMode),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: views[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'المهام'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'الإنجازات'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'إحصائيات'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'مكافآت'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'بروفايل'),
        ],
      ),
    );
  }

  // 1. واجهة المهام الرئيسية
  Widget _buildTasksView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // كرت الترحيب ذو التدرج اللوني الجميل المتناسق مع CSS القالب
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4F6EF7), Color(0xFF7B68EE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📋 مهام اليوم', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('انطلق نحو أهدافك الحالية', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF4F6EF7)),
                onPressed: () {},
                child: const Text('✚ إضافة مهمة'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // قائمة استعراض المهام
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final task = _tasks[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Checkbox(
                  value: task['isCompleted'],
                  onChanged: (val) {
                    setState(() {
                      task['isCompleted'] = val;
                    });
                  },
                ),
                title: Text(
                  task['title'],
                  style: TextStyle(
                    decoration: task['isCompleted'] ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('الفئة: ${task['category']}'),
                trailing: Icon(
                  Icons.circle,
                  color: task['priority'] == 'high' ? Colors.red : Colors.amber,
                  size: 14,
                ),
              ),
            );
          },
        )
      ],
    );
  }

  // 2. واجهة الإنجازات
  Widget _buildAchievementsView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('🏆 قائمة الإنجازات المميزة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Card(
          child: ListTile(
            leading: Text('🥇', style: TextStyle(fontSize: 28)),
            title: Text('البداية القوية'),
            subtitle: Text('قمت بإنجاز أول مهمة برمجية لك بنجاح!'),
            trailing: Text('اليوم', style: TextStyle(color: Colors.grey)),
          ),
        ),
      ],
    );
  }

  // 3. واجهة الإحصائيات
  Widget _buildStatsView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📊 نظرة شاملة على الأداء', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard('إجمالي المهام', '${_tasks.length}', Colors.blue.shade100),
              _buildStatCard('المهام المنجزة', '${_tasks.where((t) => t['isCompleted']).length}', Colors.green.shade100),
              _buildStatCard('المهام المعلقة', '${_tasks.where((t) => !t['isCompleted']).length}', Colors.amber.shade100),
              _buildStatCard('أيام متتالية', '5 🔥', Colors.orange.shade100),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color bgColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4F6EF7))),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  // 4. واجهة المكافآت الشخصية
  Widget _buildRewardsView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.between,
          children: [
            const Text('🎁 نظام المكافآت والتحفيز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(onPressed: () {}, child: const Text('✚ إضافة')),
          ],
        ),
        const SizedBox(height: 15),
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFF7A44F), width: 1.5, style: BorderStyle.dashed),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const ListTile(
            leading: Text('🎬', style: TextStyle(fontSize: 30)),
            title: Text('مشاهدة حلقة من مسلسل Teşkilat'),
            subtitle: Text('يتطلب إنجاز 5 مهام برمجية متتالية'),
            trailing: Icon(Icons.lock, color: Colors.amber),
          ),
        ),
      ],
    );
  }

  // 5. واجهة البروفايل والإعدادات
  Widget _buildProfileView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF4F6EF7),
                child: Text('👤', style: TextStyle(fontSize: 40)),
              ),
              SizedBox(height: 10),
              Text('المطور الحالي', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.language, color: Color(0xFF4F6EF7)),
                title: Text('اللغة الافتراضية'),
                trailing: Text('العربية (Yemen)'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.storage, color: Color(0xFF4F6EF7)),
                title: Text('إدارة تخزين البيانات المlocal'),
                subtitle: Text('تصدير/استيراد ملفات JSON التلقائية'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade50,
            foregroundColor: Colors.red,
            minimumSize: const Size(double.infinity, 45),
          ),
          onPressed: () {},
          icon: const Icon(Icons.delete_sweep),
          label: const Text('مسح جميع البيانات المحلية للتطبيق'),
        )
      ],
    );
  }
}
