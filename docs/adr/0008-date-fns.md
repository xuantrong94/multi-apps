# ADR-0008: date-fns cho xử lý ngày tháng

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-02, REQ-03, REQ-04, TD-00

## Bối cảnh

REQ-02/03 cần rule tự động gán ngày theo trạng thái (5 trường ngày, rẽ nhánh
Fix/Pending/On Hold, xóa/ghi đè khi kéo lùi). REQ-04 cần tính ngưỡng cảnh báo "1 ngày
trước hạn" và loại trừ task có tổng thời gian dưới 2 ngày.

## Quyết định

Dùng **date-fns** (tập hàm thuần túy, mỗi hàm một file, import theo nhu cầu).

## Lựa chọn khác đã cân nhắc

- **dayjs** — bundle nhỏ hơn khi đo tổng thể.

## Bằng chứng

Tra cứu web ngày 2026-08-29 (PkgPulse, reintech.io, DhiWise — so sánh date-fns/dayjs
2026): dayjs nhẹ hơn về tổng bundle (~2KB so với date-fns), nhưng date-fns được khuyến
nghị cho dự án TypeScript nhờ cấu trúc một-hàm-một-file, dễ tree-shake và **dễ unit test
độc lập từng hàm** — khớp trực tiếp với [ADR-0012](0012-vitest-scoped-testing.md) (chỉ
viết Vitest cho rule ngày tháng rủi ro cao ở REQ-03).

> **Tự sửa sau khi tra cứu:** Bản nháp đầu của TD-00 ghi lý do chọn date-fns là "nhẹ hơn
> dayjs/moment" — thông tin này **không chính xác** (dayjs nhẹ hơn về bundle). Lý do chọn
> thực sự là khả năng test từng hàm độc lập, không phải bundle size. Đã sửa lại
> [TD-00](../tech-design/TD-00-kien-truc-va-thu-vien.md) cho khớp với bằng chứng thực tế.

## Hệ quả

Không tối ưu bundle size bằng dayjs nếu sau này có nhiều thao tác ngày tháng chạy ở
client, nhưng phần lớn logic ngày tháng của Phase 1 chạy ở server (Server Action, cron
job REQ-04) nên bundle client không phải yếu tố quyết định ở giai đoạn này.
