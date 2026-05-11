# 🏦 Customer 360 & RFM Segmentation Analysis

> **Phân khúc khách hàng bằng mô hình RFM kết hợp Ma trận BCG — sử dụng MySQL & Tableau**

---

## 📌 Project Overview

Dự án phân tích hơn **937,000 khách hàng** và **1M+ giao dịch** trong giai đoạn 01/06–31/08/2022 nhằm xây dựng mô hình phân khúc khách hàng toàn diện (Customer 360) dựa trên hành vi giao dịch thực tế.

Mô hình RFM (Recency, Frequency, Monetary) được tích hợp với **Ma trận BCG** để chuyển hóa kết quả phân tích thành chiến lược kinh doanh cụ thể cho từng nhóm khách hàng.

---

## 🎯 Business Questions

1. Phân loại khách hàng thành các nhóm có hành vi tương đồng dựa trên dữ liệu giao dịch.
2. Nhóm khách hàng nào đóng góp doanh thu lớn nhất?
3. Nhóm nào đang có nguy cơ rời bỏ và cần tái kích hoạt?
4. Chiến lược marketing tối ưu cho từng phân khúc là gì?

---

## 🛠️ Tools & Technologies

| Tool | Mục đích |
|------|----------|
| **MySQL** | Xử lý dữ liệu, tính toán RFM, phân hạng Quartile |
| **Tableau Public** | Visualization & Dashboard |
| **BCG Matrix** | Framework chiến lược kinh doanh |

---

## 📁 Project Structure

```
customer-360-rfm-analysis/
├── README.md
├── sql/
│   ├── 01_rfm_calculation.sql        ← Tính R, F, M có chuẩn hóa theo tuổi HĐ
│   ├── 02_rfm_scoring.sql            ← Chấm điểm theo Quartile (1-4)
│   └── 03_rfm_segmentation.sql       ← Phân nhóm & gán Customer Segment
├── images/
│   ├── dashboard_overview.png
│   ├── scatter_recency_monetary.png
│   └── revenue_by_segment.png
└── presentation/
    └── Customer360_RFM_Portfolio.pdf
```

---

## 📊 Dashboard

![Dashboard Overview](dashboard_overview.png)

🔗 **[View Interactive Dashboard on Tableau Public](#)** 

---

## 🔍 Analysis Process

### Bước 1 — Xác định mốc tham chiếu

Mốc tham chiếu: **01/09/2022** (ngay sau kỳ dữ liệu 31/08/2022)

### Bước 2 — Tính toán chỉ số RFM

| Chỉ số | Công thức | Ý nghĩa |
|--------|-----------|---------|
| **Recency (R)** | `RefDate - MAX(purchase_date)` | Số ngày kể từ lần mua cuối |
| **Frequency (F)** | `COUNT(transactions) / CustomerAge(Years)` | Số giao dịch trung bình/năm |
| **Monetary (M)** | `SUM(GMV) / CustomerAge(Years)` | Doanh thu trung bình/năm |

> **Normalization**: Chia cho "Tuổi đời khách hàng" (Customer Age) để đảm bảo công bằng giữa khách hàng lâu năm và khách hàng mới.

### Bước 3 — Phân hạng theo Quartile

Sử dụng `ROW_NUMBER()` để chia đều khách hàng vào 4 nhóm (1–4):

- **Recency**: Càng thấp (mua gần đây) → điểm càng **cao**
- **Frequency & Monetary**: Càng cao → điểm càng **cao**

### Bước 4 — Phân nhóm Customer Segment

| RFM Segment | RFM Score | Mô tả | BCG |
|-------------|-----------|-------|-----|
| **VIP Core** | 444, 443, 344 | Giao dịch gần đây, thường xuyên, giá trị cao | ⭐ Star |
| **Loyal Growers** | 441, 342, 432 | Trung thành, có tiềm năng tăng trưởng | ❓ Question Mark |
| **High-Value Occasional** | 414, 324, 423 | Ít giao dịch nhưng mỗi lần giá trị lớn | 🐄 Cash Cow |
| **New Promising** | 411, 421, 311 | Khách hàng mới, cần nuôi dưỡng | ❓ Question Mark |
| **Lapsed Loyal** | 144, 243, 143 | Trước đây giá trị cao, nay giảm giao dịch | 🐄→🐕 |
| **At Risk / Dormant** | 122, 211, 111 | Giá trị thấp, ít hoặc không còn hoạt động | 🐕 Dog |

---

## 📈 Key Findings

### Phân bổ khách hàng & doanh thu

| Segment | Số KH | % KH | % Doanh thu |
|---------|-------|------|-------------|
| VIP Core | 6,622 | 16.53% | **29.58%** |
| New Promising | 13,669 | **29.58%** | 16.88% |
| At Risk/Dormant | 9,681 | 21.02% | thấp |
| Lapsed Loyal | 6,817 | — | — |
| Loyal Growers | 3,498 | 7.40% | — |
| High-Value Occasional | 3,027 | 8.59% | — |

### Insights chính

**1. VIP Core** tuy chỉ chiếm 16.53% số lượng nhưng đóng góp 29.58% tổng doanh thu — đây là nhóm cần ưu tiên bảo vệ cao nhất.

**2. New Promising** chiếm 29.58% số lượng nhưng chỉ đóng góp 16.88% doanh thu — tiềm năng chuyển hóa lớn nếu được onboarding đúng cách.

**3. Lapsed Loyal** có Recency cao (lâu không mua) nhưng Monetary vẫn cao — cần ưu tiên chiến dịch win-back trước khi nhóm này chuyển sang Dog.

**4. At Risk/Dormant** có cả Recency và Monetary thấp — nên hạn chế đầu tư marketing để tối ưu chi phí.

---

## 💡 Recommendations

### ⭐ VIP Core — Giữ chân & tối đa CLV
- Triển khai chương trình chăm sóc đặc quyền (personalized offers, ưu đãi sinh nhật)
- Gợi ý sản phẩm cross-sell/upsell dựa trên hành vi giao dịch
- Phân công nhân viên quan hệ khách hàng cao cấp

### ❓ Loyal Growers & New Promising — Đầu tư có chọn lọc
- **Loyal Growers**: Gửi đề xuất sản phẩm premium để nâng hạng lên VIP
- **New Promising**: Tăng cường onboarding, hướng dẫn sử dụng, ưu đãi kích hoạt lần 2–3

### 🐄 High-Value Occasional — Tăng tần suất giao dịch
- Gửi thông báo nhắc nhở theo chu kỳ: *"Bạn đã 60 ngày chưa mua sắm – ưu đãi 15% hôm nay!"*
- Cá nhân hóa khuyến mãi theo phân khúc sản phẩm thường mua

### 🔄 Lapsed Loyal — Tái kích hoạt (Win-back)
- Gửi chiến dịch *"We miss you"* với voucher, free shipping
- Thiết lập ngưỡng cảnh báo sớm: Recency > 90 ngày → kích hoạt tự động

### 🐕 At Risk / Dormant — Tối ưu chi phí
- Hạn chế gửi email/SMS hàng loạt
- Nếu không phản hồi sau 6 tháng → loại khỏi danh sách marketing chủ động

---

## 📞 Contact

**Nguyễn Minh Hiếu** — Data Analyst

📱 0972.026.185  
📧 hieunm0908.work@gmail.com  
💼 [linkedin.com/in/hieunm0908-work](https://linkedin.com/in/hieunm0908-work)
