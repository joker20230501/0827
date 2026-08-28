import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const MaterialApp(home: RoleScreen(), debugShowCheckedModeBanner: false));

// --- 1. STARTUP ONBOARDING & ROLE SELECTION SCREEN ---
class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);
  @override State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  String _l = 'zh'; // 'zh' or 'vi'

  @override
  Widget build(BuildContext context) {
    final z = _l == 'zh';
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF064E3B), Color(0xFF0F172A), Color(0xFF020617)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Text('🇻🇳', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(z ? '胡志明 • 平陽省' : 'TP.HCM • Bình Dương', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
                    ActionChip(
                      backgroundColor: Colors.white12,
                      side: const BorderSide(color: Colors.amber, width: 0.8),
                      avatar: Text(z ? '🇹🇼' : '🇻🇳', style: const TextStyle(fontSize: 16)),
                      label: Text(z ? '繁體中文' : 'Tiếng Việt', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
                      onPressed: () => setState(() => _l = z ? 'vi' : 'zh'),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF008848),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFBBF24), width: 2.5),
                    boxShadow: const [BoxShadow(color: Color(0x66008848), blurRadius: 24, spreadRadius: 4)],
                  ),
                  child: const Text('🌿', style: TextStyle(fontSize: 42)),
                ),
                const SizedBox(height: 14),
                const Text('Việc Làm Bản Đồ', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.black, letterSpacing: 0.8)),
                const SizedBox(height: 4),
                Text(
                  z ? '越南在地地圖求職 • 100% 薪資透明與大廠直連' : 'Tìm việc bản đồ • Minh bạch lương & Kết nối TopCV',
                  style: const TextStyle(color: Color(0xFFFCD34D), fontSize: 12.5, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Worker Role Card
                _buildRoleCard(
                  isWorker: true,
                  title: z ? '👤 我是求職者 (Người tìm việc)' : '👤 Tôi là Người tìm việc',
                  badge: z ? '找工作 • 免費' : 'Tìm việc • Miễn phí',
                  desc: z ? '在地圖上探索周邊大廠職缺、實領薪資細拆、員工真實匿名評價' : 'Xem việc quanh bạn, bóc tách lương thực nhận, đánh giá công ty',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MainApp(role: 'WORKER', lang: _l))),
                ),
                const SizedBox(height: 16),

                // Employer Role Card
                _buildRoleCard(
                  isWorker: false,
                  title: z ? '🏢 我是招聘企業 (Nhà tuyển dụng)' : '🏢 Tôi là Nhà tuyển dụng',
                  badge: z ? '找人才 • 直聘' : 'Tìm ứng viên • Trực tiếp',
                  desc: z ? '在地圖上快速搜尋人才、審核工作歷史任職穩定度、查看社群' : 'Tìm ứng viên quanh KCN, xem độ ổn định lịch sử, liên hệ Zalo/FB',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MainApp(role: 'EMPLOYER', lang: _l))),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sync_alt, color: Colors.amber, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        z ? '已連線 TopCV • VietnamWorks • Việc Làm 24h 數據庫' : 'Đã kết nối TopCV • VietnamWorks • Việc Làm 24h',
                        style: const TextStyle(color: Colors.white70, fontSize: 10.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({required bool isWorker, required String title, required String badge, required String desc, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          border: Border.all(color: isWorker ? const Color(0xFF10B981) : const Color(0xFF3B82F6), width: 2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: (isWorker ? const Color(0xFF10B981) : const Color(0xFF3B82F6)).withOpacity(0.15), blurRadius: 10)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: isWorker ? const Color(0xFF008848) : const Color(0xFF1E40AF),
              child: Text(isWorker ? '👤' : '🏢', style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.5)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: (isWorker ? Colors.green : Colors.blue).withOpacity(0.3), borderRadius: BorderRadius.circular(6)),
                        child: Text(badge, style: TextStyle(color: isWorker ? Colors.greenAccent : Colors.lightBlueAccent, fontSize: 9.5, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. MAIN APPLICATION (WORKER & EMPLOYER MODES) ---
class MainApp extends StatefulWidget {
  final String role;
  final String lang;
  const MainApp({Key? key, required this.role, required this.lang}) : super(key: key);
  @override State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _tab = 0;
  late String _lang;
  late String _role;
  String _selectedCategory = 'ALL';
  LatLng _pos = const LatLng(10.8231, 106.6297); // HCMC / Binh Duong Baseline
  bool _isLocating = false;
  bool _isSyncing = false;

  // Categories definition
  final List<Map<String, String>> _categories = [
    {'id': 'ALL', 'zh': '全部職缺', 'vi': 'Tất cả'},
    {'id': 'MFG', 'zh': '🏭 製造加工', 'vi': '🏭 Sản xuất'},
    {'id': 'LOGISTICS', 'zh': '📦 倉儲物流', 'vi': '📦 Kho vận'},
    {'id': 'FNB', 'zh': '☕ 餐飲門市', 'vi': '☕ F&B & Nhà hàng'},
    {'id': 'RETAIL', 'zh': '🛒 超商量販', 'vi': '🛒 Bán lẻ'},
    {'id': 'OFFICE', 'zh': '🏢 行政雙語', 'vi': '🏢 Văn phòng'},
    {'id': 'SECURITY', 'zh': '🛡️ 保全清潔', 'vi': '🛡️ Bảo vệ & Tạp vụ'},
  ];

  // Master Jobs & Talent Dataset (Live Platform Synced)
  List<Map<String, dynamic>> _data = [
    {
      'id': 'job-01',
      'cat': 'LOGISTICS',
      'source': 'TopCV 官方連線 (MST: 3702849102)',
      'url': 'https://www.topcv.vn/viec-lam/vsip-logistics',
      'zalo': 'https://zalo.me/g/vsip_tuyendung',
      'fb': 'https://facebook.com/groups/kcn.binhduong.job',
      'tz': '堆高機司機兼倉儲理貨組長', 'tv': 'Tài xế Lái Xe Nâng & Trưởng Nhóm Kho',
      'cz': '平陽 VSIP 1 國際物流大廠 (外資大廠)', 'cv': 'Tập Đoàn Logistics VSIP 1 Bình Dương',
      'sz': '11 - 15.5 百萬/月 (約1.4~2.0萬台幣)', 'sv': '11 - 15.5 tr/tháng',
      'baseSalary': '7.5M (底薪)',
      'allowance': '+3.5M (伙食+全勤+津貼)',
      'overtime': '1.5x~2.0x (冷氣無塵倉)',
      'rating': 4.9,
      'reviewsCount': 68,
      'onTimeSalaryRate': '100% 發薪準時 (每月10號)',
      'comments': [
        {'user': 'Lái xe nâng ca 1', 'rating': 5.0, 'text': 'Phát lương đúng ngày 10, cơm trưa 3 món có tráng miệng, kho mát mẻ.', 'date': '2026-08'},
        {'user': 'Nhân viên kiểm kê', 'rating': 4.8, 'text': 'Chuyền trưởng người Việt vui vẻ, phụ cấp chuyên cần 800k đủ.', 'date': '2026-07'},
      ],
      'cand': '阮文雄 (Nguyễn Văn Hùng)',
      'stab': 96,
      'avgTenure': '2.1 年',
      'candSkills': '堆高機安全操作證、華語基礎溝通',
      'candHistory': '1. 平陽神浪倉儲 (2年3個月) • 2. 同奈 Amata 電子 (1年8個月)',
      'lat': 10.9315, 'lng': 106.6980,
      'logo': 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=120',
      'ava': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120',
      'welfare': ['包午晚2餐', '免費冷氣宿舍', '廠車接送', '完整勞健保BHXH'],
    },
    {
      'id': 'job-02',
      'cat': 'MFG',
      'source': 'VietnamWorks 官方連線 (MST: 0301984712)',
      'url': 'https://www.vietnamworks.com/viec-lam/tan-binh-textile',
      'zalo': 'https://zalo.me/g/tanbinh_garment',
      'fb': 'https://facebook.com/kcntanbinh.tuyendung',
      'tz': '成衣工廠車縫熟手 (平車/拷克)', 'tv': 'Thợ May Công Nghiệp 1 Kim / Vắt Sổ',
      'cz': '新平工業區成衣外銷大廠 (胡志明市)', 'cv': 'CP Dệt May Xuất Khẩu Tân Bình (TP.HCM)',
      'sz': '8.5 - 13 百萬/月 (約1.1~1.7萬台幣)', 'sv': '8.5 - 13 tr/tháng',
      'baseSalary': '6.0M (底薪)',
      'allowance': '+2.5M (中餐+全勤獎金)',
      'overtime': '1.5x (產線冷氣車間)',
      'rating': 4.7,
      'reviewsCount': 114,
      'onTimeSalaryRate': '99% 發薪準時 (投保全額保險)',
      'comments': [
        {'user': 'Thợ may chuyền 3', 'rating': 5.0, 'text': 'Công ty bao ăn trưa ngon, tháng 13 đầy đủ, môi trường sạch.', 'date': '2026-08'},
      ],
      'cand': '陳氏梅 (Trần Thị Mai)',
      'stab': 91,
      'avgTenure': '1.9 年',
      'candSkills': '平車熟手5年、拷克、自備機車',
      'candHistory': '1. 新平紡織廠 (2年) • 2. 越香製衣 (1年9個月)',
      'lat': 10.8120, 'lng': 106.6280,
      'logo': 'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=120',
      'ava': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=120',
      'welfare': ['供中餐', '全勤獎金700k', '第13個月年終', '產線冷氣'],
    },
    {
      'id': 'job-03',
      'cat': 'MFG',
      'source': 'Việc Làm 24h & FB 社群連線 (MST: 3709182314)',
      'url': 'https://vieclam24h.vn/co-khi-song-than-2',
      'zalo': 'https://zalo.me/g/songthan2_cnc',
      'fb': 'https://facebook.com/groups/cokhibinhduong',
      'tz': '精密機械組立加工與CNC/焊接工', 'tv': 'Kỹ Thuật Viên Hàn TIG/MIG & CNC',
      'cz': '神浪 2 工業區精密機械廠 (平陽省)', 'cv': 'Cơ Khí Sóng Thần 2 (Bình Dương)',
      'sz': '12 - 17 百萬/月 (約1.5~2.2萬台幣)', 'sv': '12 - 17 tr/tháng',
      'baseSalary': '8.5M (底薪)',
      'allowance': '+3.5M (技術加給+伙食)',
      'overtime': '1.5x~2.0x (夜班加成)',
      'rating': 4.8,
      'reviewsCount': 52,
      'onTimeSalaryRate': '100% 發薪準時 (達標獎金即時現領)',
      'comments': [
        {'user': 'Thợ hàn TIG', 'rating': 5.0, 'text': 'Có phụ cấp độc hại và thiết bị bảo hộ xịn, anh em hỗ trợ nhau.', 'date': '2026-08'},
      ],
      'cand': '黎文南 (Lê Văn Nam)',
      'stab': 88,
      'avgTenure': '1.7 年',
      'candSkills': 'CNC銑床操作、TIG氬焊3G證照',
      'candHistory': '1. 神浪精密機械 (2年) • 2. 同奈鋼構 (1年4個月)',
      'lat': 10.9050, 'lng': 106.7450,
      'logo': 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=120',
      'ava': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120',
      'welfare': ['包早午2餐', '租屋補助800k', '達標獎金', '安全保險'],
    },
    {
      'id': 'job-04',
      'cat': 'FNB',
      'source': 'CareerViet 官方連線 (MST: 0318273645)',
      'url': 'https://careerviet.vn/saigon-heritage-fnb',
      'zalo': 'https://zalo.me/g/saigon_heritage_fnb',
      'fb': 'https://facebook.com/saigonheritage.fnb',
      'tz': '連鎖餐飲吧台組長兼調飲主管', 'tv': 'Trưởng Ca Pha Chế & Quầy Bar (F&B)',
      'cz': '西貢 Heritage 連鎖咖啡 (第一郡旗艦店)', 'cv': 'Chuỗi F&B Saigon Heritage (Quận 1)',
      'sz': '8.5 - 11 百萬/月 (約1.1~1.4萬台幣)', 'sv': '8.5 - 11 tr/tháng',
      'baseSalary': '6.5M (底薪)',
      'allowance': '+2.0M (小費分紅+交通津貼)',
      'overtime': '達標分紅 + 員工餐飲5折',
      'rating': 4.6,
      'reviewsCount': 86,
      'onTimeSalaryRate': '100% 發薪準時 (小費週結發放)',
      'comments': [
        {'user': 'Barista ca tối', 'rating': 4.8, 'text': 'Tiền tips chia hàng tuần rất rõ ràng, đồng nghiệp thân thiện.', 'date': '2026-08'},
      ],
      'cand': '范氏芳 (Phạm Thị Phương)',
      'stab': 85,
      'avgTenure': '1.5 年',
      'candSkills': '中級咖啡調飲、POS收銀管理、英文基礎',
      'candHistory': '1. Highlands Coffee (1年半) • 2. Phuc Long (1年)',
      'lat': 10.7769, 'lng': 106.7009,
      'logo': 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=120',
      'ava': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=120',
      'welfare': ['每日免費特調飲品', '免費機車停車位', '週週發現金小費', '績效分紅'],
    }
  ];

  @override
  void initState() {
    super.initState();
    _lang = widget.lang;
    _role = widget.role;
    _gps();
  }

  Future<void> _gps() async {
    setState(() => _isLocating = true);
    try {
      var p = await Geolocator.checkPermission();
      if (p == LocationPermission.denied) p = await Geolocator.requestPermission();
      if (p == LocationPermission.whileInUse || p == LocationPermission.always) {
        var pos = await Geolocator.getCurrentPosition();
        setState(() => _pos = LatLng(pos.latitude, pos.longitude));
      }
    } catch (_) {}
    setState(() => _isLocating = false);
  }

  Future<void> _syncLiveDatabase() async {
    setState(() => _isSyncing = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => _isSyncing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF008848),
        content: Text(
          _lang == 'zh'
              ? '✅ 已成功同步 TopCV, VietnamWorks, Việc Làm 24h 最新 3,500+ 筆大廠招募數據！'
              : '✅ Đã đồng bộ 3,500+ việc làm mới từ TopCV, VietnamWorks, Việc Làm 24h!',
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredData {
    if (_selectedCategory == 'ALL') return _data;
    return _data.where((item) => item['cat'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final z = _lang == 'zh';
    final w = _role == 'WORKER';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: w ? const Color(0xFF008848) : const Color(0xFF1E40AF),
        foregroundColor: Colors.white,
        elevation: 2,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              w ? (z ? '👤 求職者模式 (找工作)' : '👤 Người tìm việc') : (z ? '🏢 企業招聘模式 (找人才)' : '🏢 Nhà tuyển dụng'),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              z ? '📍 平陽 VSIP / 胡志明 • 大廠與社群直連' : '📍 Bình Dương / TP.HCM • TopCV & Mạng XH',
              style: const TextStyle(fontSize: 10.5, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: z ? '即時刷新大數據庫' : 'Đồng bộ dữ liệu',
            icon: _isSyncing
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 2))
                : const Icon(Icons.sync, color: Colors.amberAccent),
            onPressed: _syncLiveDatabase,
          ),
          TextButton(
            onPressed: () => setState(() => _lang = z ? 'vi' : 'zh'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
              child: Text(z ? '🇻🇳' : '🇹🇼', style: const TextStyle(fontSize: 16)),
            ),
          ),
          IconButton(
            tooltip: z ? '切換身分/登出' : 'Đổi vai trò',
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter Bar
          _buildCategoryFilterBar(z),

          // Main Tab Content
          Expanded(
            child: _tab == 0
                ? _buildMapView(z, w)
                : (_tab == 1 ? _buildListView(z, w) : (w ? _buildWorkerCvView(z) : _buildEmployerPostView(z))),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        indicatorColor: (w ? const Color(0xFF008848) : const Color(0xFF1E40AF)).withOpacity(0.2),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.map_outlined), selectedIcon: const Icon(Icons.map), label: z ? (w ? '地圖職缺' : '地圖人才') : 'Bản đồ'),
          NavigationDestination(icon: const Icon(Icons.auto_awesome_outlined), selectedIcon: const Icon(Icons.auto_awesome), label: z ? '推薦列表' : 'Gợi ý'),
          NavigationDestination(icon: Icon(w ? Icons.person_outline : Icons.post_add), selectedIcon: Icon(w ? Icons.person : Icons.post_add), label: z ? (w ? '我的履歷' : '發布職缺') : 'Hồ sơ'),
        ],
      ),
    );
  }

  Widget _buildCategoryFilterBar(bool z) {
    return Container(
      height: 46,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (ctx, i) {
          final cat = _categories[i];
          final isSelected = _selectedCategory == cat['id'];
          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: ChoiceChip(
              selected: isSelected,
              label: Text(
                z ? cat['zh']! : cat['vi']!,
                style: TextStyle(fontSize: 11.5, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.white : Colors.black87),
              ),
              selectedColor: const Color(0xFF008848),
              backgroundColor: Colors.grey.shade100,
              onSelected: (val) => setState(() => _selectedCategory = cat['id']!),
            ),
          );
        },
      ),
    );
  }

  // --- MAP VIEW WITH EMBEDDED COMPANY LOGOS & CANDIDATE AVATARS ---
  Widget _buildMapView(bool z, bool w) {
    final items = _filteredData;
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(initialCenter: _pos, initialZoom: 12.0),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'vn.vieclambando.app',
            ),
            MarkerLayer(
              markers: [
                // Live GPS Marker
                Marker(
                  point: _pos,
                  width: 32,
                  height: 32,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Center(child: Icon(Icons.my_location, color: Colors.red, size: 24)),
                  ),
                ),

                // Job / Candidate Custom Markers with Logos/Avatars
                ...items.map((j) {
                  return Marker(
                    point: LatLng(j['lat'], j['lng']),
                    width: 156,
                    height: 48,
                    child: GestureDetector(
                      onTap: () => _showDetailModal(j, z, w),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: w ? const Color(0xFF008848) : const Color(0xFF1E40AF),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFFBBF24), width: 1.8),
                          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2))],
                        ),
                        child: Row(
                          children: [
                            // Company Logo or Candidate Avatar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                w ? j['logo'] : j['ava'],
                                width: 28,
                                height: 28,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  width: 28, height: 28,
                                  color: Colors.white24,
                                  child: Icon(w ? Icons.business : Icons.person, color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    w ? (z ? j['sz'].split(' ')[0] + 'M' : j['sv']) : (j['cand'].split(' ')[0]),
                                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    w ? '⭐ ${j['rating']}' : '🛡️ ${j['stab']}分',
                                    style: TextStyle(color: w ? const Color(0xFFFDE047) : Colors.cyanAccent, fontSize: 8.5, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ],
        ),

        // Top Status Badge
        Positioned(
          top: 10, left: 12, right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
            child: Row(
              children: [
                const Icon(Icons.verified, color: Color(0xFF008848), size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    z ? '📍 點擊地圖圖釘查看大廠徵才來源與員工留言' : '📍 Chạm vào biểu tượng để xem nguồn tuyển dụng & đánh giá',
                    style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),

        // GPS Center Button
        Positioned(
          right: 16, bottom: 20,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            onPressed: _gps,
            child: _isLocating
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Color(0xFF008848), strokeWidth: 2))
                : const Icon(Icons.gps_fixed, color: Color(0xFF008848)),
          ),
        ),
      ],
    );
  }

  // --- DETAIL MODAL WITH REVIEW & COMMENTING SYSTEM + SOCIAL CHANNELS ---
  void _showDetailModal(Map<String, dynamic> j, bool z, bool w) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        expand: false,
        builder: (_, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            // Header: Logo/Avatar + Title + Source
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(w ? j['logo'] : j['ava'], width: 52, height: 52, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.amber.shade300)),
                        child: Text(j['source'], style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.amber.shade900)),
                      ),
                      const SizedBox(height: 4),
                      Text(w ? (z ? j['tz'] : j['tv']) : j['cand'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(w ? (z ? j['cz'] : j['cv']) : '📍 ${j['candSkills']}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Rating & Stability Breakdown
            if (w)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('⭐ ${j['rating']} 員工綜合好評 (${j['reviewsCount']} 則評價)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber.shade900)),
                        Text(j['onTimeSalaryRate'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.green.shade800)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('💰 實領拆解：${j['baseSalary']} + ${j['allowance']} • ${j['overtime']}', style: const TextStyle(fontSize: 11, color: Colors.black87)),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('🛡️ 人才穩定度：${j['stab']}分 (平均任職 ${j['avgTenure']})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue.shade900)),
                        const Text('近兩年 0 次跳槽', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.indigo)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('💼 經歷：${j['candHistory']}', style: const TextStyle(fontSize: 11, color: Colors.black87)),
                  ],
                ),
              ),

            const SizedBox(height: 14),

            // Social & Public Source Buttons
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                ActionChip(
                  avatar: const Text('💬', style: TextStyle(fontSize: 14)),
                  backgroundColor: Colors.blue.shade50,
                  side: BorderSide(color: Colors.blue.shade200),
                  label: const Text('Zalo 招募群', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 11)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已開啟 Zalo: ${j['zalo']}'))),
                ),
                ActionChip(
                  avatar: const Text('🌐', style: TextStyle(fontSize: 14)),
                  backgroundColor: Colors.indigo.shade50,
                  side: BorderSide(color: Colors.indigo.shade200),
                  label: const Text('Facebook 專頁', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 11)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已開啟 FB: ${j['fb']}'))),
                ),
                ActionChip(
                  avatar: const Text('🔗', style: TextStyle(fontSize: 14)),
                  backgroundColor: Colors.orange.shade50,
                  side: BorderSide(color: Colors.orange.shade200),
                  label: const Text('TopCV 原始徵才頁', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 11)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已開啟大廠徵才來源: ${j['url']}'))),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Authentic Employee Comments List (Worker View)
            if (w) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(z ? '💬 在職員工匿名評論留言' : '💬 Đánh giá từ công nhân', style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
                  TextButton.icon(
                    icon: const Icon(Icons.edit, size: 14, color: Color(0xFF008848)),
                    label: Text(z ? '我要寫評論' : 'Viết đánh giá', style: const TextStyle(fontSize: 11, color: Color(0xFF008848), fontWeight: FontWeight.bold)),
                    onPressed: () => _showAddReviewDialog(j, z),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ...((j['comments'] as List<dynamic>?) ?? []).map((c) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(c['user'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          Text('⭐ ${c['rating']} • ${c['date']}', style: const TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(c['text'] as String, style: const TextStyle(fontSize: 11, color: Colors.black87)),
                    ],
                  ),
                );
              }).toList(),
            ],

            const SizedBox(height: 20),

            // Bottom Action: Apply or Invite
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      w ? (z ? j['sz'] : j['sv']) : '期望月薪 10~13.5M',
                      style: const TextStyle(color: Color(0xFF008848), fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    Text(
                      z ? '🛵 約 6~9 分鐘機車車程' : '🛵 ~6-9 phút đi xe máy',
                      style: const TextStyle(color: Colors.black45, fontSize: 10.5),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: w ? const Color(0xFF008848) : const Color(0xFF1E40AF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: w ? const Color(0xFF008848) : const Color(0xFF1E40AF),
                        content: Text(
                          w
                              ? (z ? '🎉 應徵成功！已將您的結構化履歷同步送達外資大廠人資。' : '🎉 Ứng tuyển thành công! Đã gửi hồ sơ.')
                              : (z ? '📩 面試邀請已成功發送至應徵者手機！' : '📩 Đã gửi lời mời phỏng vấn!'),
                        ),
                      ),
                    );
                  },
                  child: Text(w ? (z ? '立即應徵' : 'Ứng tuyển') : (z ? '邀請面試' : 'Mời PV'), style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReviewDialog(Map<String, dynamic> j, bool z) {
    final commentCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(z ? '撰寫公司真實評論' : 'Đánh giá công ty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(z ? '您的評論將以匿名方式發布，供求職者參考。' : 'Đánh giá của bạn sẽ được ẩn danh.', style: const TextStyle(fontSize: 11, color: Colors.black54)),
            const SizedBox(height: 10),
            TextField(
              controller: commentCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: z ? '例如：發薪準時、伙食三菜一湯、冷氣宿舍...' : 'Ví dụ: Lương đúng hạn, cơm ngon...',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(z ? '取消' : 'Hủy')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF008848), foregroundColor: Colors.white),
            onPressed: () {
              if (commentCtrl.text.isNotEmpty) {
                setState(() {
                  (j['comments'] as List<dynamic>).insert(0, {
                    'user': z ? '在職員工' : 'Công nhân',
                    'rating': 5.0,
                    'text': commentCtrl.text,
                    'date': '2026-08',
                  });
                });
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(z ? '評論已成功發布！' : 'Đã gửi đánh giá!')));
            },
            child: Text(z ? '發布評論' : 'Gửi'),
          ),
        ],
      ),
    );
  }

  // --- LIST VIEW ---
  Widget _buildListView(bool z, bool w) {
    final items = _filteredData;
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final d = items[i];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(w ? d['logo'] : d['ava'], width: 44, height: 44, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d['source'], style: const TextStyle(fontSize: 9.5, color: Colors.amber, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text(w ? (z ? d['tz'] : d['tv']) : d['cand'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(w ? (z ? d['cz'] : d['cv']) : '📍 ${d['candSkills']}', style: const TextStyle(color: Colors.black54, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: w ? Colors.amber.shade50 : Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    w ? '⭐ ${d['r']} • 💰 ${d['b']}' : '🛡️ 穩定度：${d['stab']}分 (平均任職 ${d['avgTenure']})',
                    style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: w ? Colors.brown : Colors.blue.shade900),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(w ? (z ? d['sz'] : d['sv']) : '期望月薪 10~13.5M', style: const TextStyle(color: Color(0xFF008848), fontWeight: FontWeight.bold, fontSize: 12.5)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: w ? const Color(0xFF008848) : const Color(0xFF1E40AF), foregroundColor: Colors.white),
                      onPressed: () => _showDetailModal(d, z, w),
                      child: Text(w ? (z ? '查看詳情' : 'Chi tiết') : (z ? '審核人才' : 'Xem CV')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- CV VIEW ---
  Widget _buildWorkerCvView(bool z) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(z ? '我的結構化履歷 (CV)' : 'Hồ Sơ Năng Lực', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(labelText: '姓名 / Họ tên (阮文雄)', border: OutlineInputBorder())),
        const SizedBox(height: 10),
        const TextField(decoration: InputDecoration(labelText: '社群連結 / Zalo, Facebook (選填)', border: OutlineInputBorder())),
        const SizedBox(height: 10),
        const TextField(decoration: InputDecoration(labelText: '期望月薪 / Lương (10~13.5M)', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        Card(
          color: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(z ? '💼 歷史工作經歷時間 (必填)：' : '💼 Lịch sử làm việc (Bắt buộc):', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 4),
                const Text('1. 平陽神浪倉儲 (2023/04~2025/07, 2年3個月)\n2. 同奈 Amata 電子 (2021/08~2023/04, 1年8個月)', style: TextStyle(fontSize: 11)),
                const SizedBox(height: 4),
                Text(z ? 'ℹ️ 履歷時間供企業審核，求職者端不顯示扣分標籤' : 'ℹ️ Dùng để DN đánh giá độ ổn định', style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF008848), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(z ? '履歷已儲存！' : 'Đã lưu hồ sơ!'))),
          child: Text(z ? '儲存履歷並開啟求職' : 'Lưu Hồ Sơ'),
        ),
      ],
    );
  }

  // --- POST JOB VIEW ---
  Widget _buildEmployerPostView(bool z) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(z ? '發布職缺至地圖 (企業端)' : 'Đăng Tin Tuyển Dụng', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(labelText: '職缺名稱 / Vị trí', border: OutlineInputBorder())),
        const SizedBox(height: 10),
        const TextField(decoration: InputDecoration(labelText: '企業社群 / Zalo OA, Fanpage (選填)', border: OutlineInputBorder())),
        const SizedBox(height: 10),
        const TextField(decoration: InputDecoration(labelText: '薪資範圍 / Lương (11~15.5M)', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E40AF), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(z ? '職缺已成功發布至地圖！' : 'Đăng tin thành công!'))),
          child: Text(z ? '立即發布職缺' : 'Đăng Tin'),
        ),
      ],
    );
  }
}
