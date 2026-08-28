enum JobCategory {
  manufacturing, // 🏭 製造加工 (Sản xuất & May mặc, Cơ khí, Điện tử)
  logistics,     // 📦 倉儲物流 (Kho vận, Lái xe nâng, Giao nhận)
  fnb,           // ☕ 餐飲服務 (F&B, Pha chế, Phục vụ, Thu ngân)
  retail,        // 🛒 零售門市 (Bán lẻ, Siêu thị, Bán hàng)
  office,        // 🏢 行政辦公 (Hành chính, Kế toán, Nhân sự, Tiếng Trung)
  security       // 🛡️ 保全清潔 (Bảo vệ, Vệ sinh công nghiệp)
}

class CompanyReview {
  final String authorName;
  final String authorRole;
  final double rating;
  final String comment;
  final String date;
  final bool isVerified;

  CompanyReview({
    required this.authorName,
    required this.authorRole,
    required this.rating,
    required this.comment,
    required this.date,
    this.isVerified = true,
  });
}

class Job {
  final String id;
  final JobCategory category;
  final String sourceName; // e.g. "TopCV", "VietnamWorks", "Việc Làm 24h"
  final String sourceUrl;
  final String taxCode;
  final String companyNameZh;
  final String companyNameVi;
  final String logoUrl;
  final String titleZh;
  final String titleVi;
  
  // Salary Breakdown
  final double salaryMin;
  final double salaryMax;
  final String baseSalary;      // 投保底薪
  final String allowance;       // 各項津貼
  final String overtimeRate;    // 加班費率

  // Work Amenities
  final List<String> amenitiesZh;
  final List<String> amenitiesVi;

  // Map & Location
  final double latitude;
  final double longitude;
  final String industrialZone;
  final String commuteDistance;
  final String commuteTime;

  // Ratings & Authentic Reviews (Worker View Only)
  final double overallRating;
  final int reviewCount;
  final int onTimeSalaryRate; // e.g. 100%
  final List<CompanyReview> reviews;

  // Social & Communication Channels (Optional)
  final String? zaloUrl;
  final String? facebookUrl;
  final String? hotline;

  // Candidate Data (Employer View Only)
  final String candidateName;
  final String candidateAvatar;
  final int candidateStabilityScore;
  final String candidateAvgTenure;
  final String candidateSkills;
  final String candidateWorkHistory;

  Job({
    required this.id,
    required this.category,
    required this.sourceName,
    required this.sourceUrl,
    required this.taxCode,
    required this.companyNameZh,
    required this.companyNameVi,
    required this.logoUrl,
    required this.titleZh,
    required this.titleVi,
    required this.salaryMin,
    required this.salaryMax,
    required this.baseSalary,
    required this.allowance,
    required this.overtimeRate,
    required this.amenitiesZh,
    required this.amenitiesVi,
    required this.latitude,
    required this.longitude,
    required this.industrialZone,
    required this.commuteDistance,
    required this.commuteTime,
    required this.overallRating,
    required this.reviewCount,
    required this.onTimeSalaryRate,
    required this.reviews,
    this.zaloUrl,
    this.facebookUrl,
    this.hotline,
    required this.candidateName,
    required this.candidateAvatar,
    required this.candidateStabilityScore,
    required this.candidateAvgTenure,
    required this.candidateSkills,
    required this.candidateWorkHistory,
  });
}
