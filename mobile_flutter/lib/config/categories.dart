class JobCategory {
  final String id;
  final String icon;
  final String nameZh;
  final String nameVi;

  const JobCategory({
    required this.id,
    required this.icon,
    required this.nameZh,
    required this.nameVi,
  });
}

class AppTaxonomy {
  static const List<JobCategory> categories = [
    JobCategory(id: 'all', icon: '🌟', nameZh: '全部職缺', nameVi: 'Tất cả'),
    JobCategory(id: 'manufacturing', icon: '🏭', nameZh: '製造加工', nameVi: 'Sản xuất & Chế tạo'),
    JobCategory(id: 'logistics', icon: '📦', nameZh: '倉儲物流', nameVi: 'Kho vận & Logistics'),
    JobCategory(id: 'fnb', icon: '☕', nameZh: '餐飲服務', nameVi: 'F&B & Nhà hàng'),
    JobCategory(id: 'retail', icon: '🛒', nameZh: '零售門市', nameVi: 'Bán lẻ & Siêu thị'),
    JobCategory(id: 'office', icon: '🏢', nameZh: '行政辦公', nameVi: 'Hành chính & Văn phòng'),
    JobCategory(id: 'security', icon: '🛡️', nameZh: '保全清潔', nameVi: 'Bảo vệ & Tạp vụ'),
  ];
}
