# ADR-0009: Resend cho gửi email

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-04, TD-00

## Bối cảnh

REQ-04 cần gửi email cảnh báo trễ hạn/sắp đến hạn. BA doc để ngỏ "Resend/SMTP", Kyle tự
cung cấp API key (đã ghi nhận là rủi ro "Cao" nếu chậm cung cấp, owner: Kyle).

## Quyết định

Dùng **Resend**.

## Lựa chọn khác đã cân nhắc

- **SMTP thuần qua nodemailer** — không cần đăng ký dịch vụ mới nếu đã có SMTP sẵn (vd
  Gmail app password, SMTP công ty), nhưng phải tự quản lý deliverability, không có
  API/dashboard theo dõi trạng thái gửi.

## Bằng chứng

- Quyết định trực tiếp từ Kyle trong phiên trao đổi kỹ thuật ngày 2026-08-29 — câu hỏi
  "Email service", chọn **"Resend"**.
- Tra cứu web ngày 2026-08-29: Resend có tài liệu tích hợp Next.js chính thức
  (resend.com/nextjs, resend.com/docs/send-with-nextjs), hỗ trợ Server Actions và tương
  thích App Router.
- Artifact "Notes Task Phase 1" (mục Quyết định đã chốt): "Email service: Kyle tự cung
  cấp API key (Resend/SMTP)" — Resend đã được nêu tên sẵn như một lựa chọn khách hàng
  cân nhắc.

## Hệ quả

Cần Kyle tạo tài khoản Resend và cung cấp `RESEND_API_KEY` trước Phase 4 (21/09) — đã ghi
nhận trong BA doc mục Rủi ro (tác động Cao, owner Kyle). Việc cài package (T0.5) không bị
chặn bởi việc chưa có key thật.
