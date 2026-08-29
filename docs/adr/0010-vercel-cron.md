# ADR-0010: Vercel Cron cho job cảnh báo định kỳ

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-04, TD-00

## Bối cảnh

REQ-04 cần kiểm tra định kỳ (1 lần/ngày) để gửi cảnh báo "1 ngày trước hạn".

## Quyết định

Dùng **Vercel Cron Jobs** (route handler + cấu hình `vercel.json`), chạy 1 lần/ngày.

## Lựa chọn khác đã cân nhắc

- **Dịch vụ cron ngoài** (cron-job.org, GitHub Actions scheduled workflow) — thêm một hệ
  thống ngoài cần quản lý secret/kết nối, không cần thiết khi đã deploy trên Vercel.

## Bằng chứng

- Artifact "Notes Task Phase 1" (mục Ràng buộc): "Nơi triển khai: Vercel — đã chốt với
  khách hàng".
- Tra cứu web ngày 2026-08-29 (Vercel changelog & docs): kể từ 20/01/2026, Vercel cho
  phép tới 100 cron job/project trên **mọi gói kể cả Hobby (free)**; giới hạn duy nhất
  trên Hobby là tần suất — tối đa **1 lần/ngày mỗi job** — khớp chính xác với nhu cầu
  thực tế của REQ-04 (chỉ cần chạy 1 lần/ngày), không cần nâng cấp gói Pro.

## Hệ quả

Không phát sinh chi phí ở gói Hobby hiện tại. Nếu sau này cần cron chạy nhiều lần/ngày
(ngoài phạm vi REQ-04 hiện tại), sẽ phải nâng cấp gói Pro — ghi nhận để cân nhắc nếu scope
thay đổi.
