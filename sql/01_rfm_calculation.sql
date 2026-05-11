-- ============================================================
-- FILE 01: RFM CALCULATION
-- Mục đích: Tính toán chỉ số Recency, Frequency, Monetary
--           có chuẩn hóa theo tuổi hợp đồng (Customer Age)
-- Database: MySQL
-- Mốc tham chiếu: 01/09/2022
-- ============================================================

WITH RFM AS (
    SELECT
        CT.customerid,

        -- RECENCY: Số ngày từ lần mua cuối đến mốc tham chiếu
        -- Giá trị càng thấp = mua càng gần đây = tốt hơn
        DATEDIFF('2022-09-01', DATE(MAX(CT.purchase_date))) AS recency,

        -- FREQUENCY: Số giao dịch trung bình mỗi năm
        -- Dùng GREATEST(..., 1) để tránh chia cho 0 với KH mới < 1 năm
        ROUND(
            COUNT(DATE(CT.purchase_date)) / 
            GREATEST(FLOOR(TIMESTAMPDIFF(MONTH, CR.CREATED_DATE, '2022-09-01') / 12), 1),
        2) AS frequency,

        -- MONETARY: Tổng GMV trung bình mỗi năm (VNĐ)
        ROUND(
            SUM(CT.GMV) / 
            GREATEST(FLOOR(TIMESTAMPDIFF(MONTH, CR.CREATED_DATE, '2022-09-01') / 12), 1),
        2) AS monetary,

        -- CUSTOMER AGE: Tuổi đời khách hàng tính theo năm
        FLOOR(TIMESTAMPDIFF(MONTH, CR.CREATED_DATE, '2022-09-01') / 12) AS contract_age

    FROM customer_transaction CT
    JOIN CUSTOMER_REGISTERED CR
        ON CT.CUSTOMERID = CR.ID
    WHERE
        purchase_date IS NOT NULL
        AND CT.customerid != 0   -- Loại bỏ giao dịch không có CustomerID
    GROUP BY 
        CT.customerid, 
        CR.CREATED_DATE
)

SELECT * FROM RFM;

-- ============================================================
-- KẾT QUẢ MẪU:
-- customerid | recency | frequency | monetary  | contract_age
-- 71739      | 62      | 0.14      | 15000.00  | 0
-- 72014      | 62      | 0.29      | 36298.71  | 0
-- 72052      | 31      | 0.14      | 20714.29  | 0
-- ============================================================
