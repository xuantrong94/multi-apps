# ADR-0003: Trường `role` qua bảng `profiles` riêng

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-01 (AC5), TD-01

## Bối cảnh

REQ-01 AC5 yêu cầu mỗi tài khoản có sẵn trường vai trò (role), dù Phase 1 chỉ dùng một
vai trò `admin` duy nhất — chuẩn bị cho multi-user ở các phase sau mà không phải làm lại
cơ chế xác thực.

## Quyết định

Tạo bảng `profiles` (public schema), quan hệ 1-1 với `auth.users` qua `id`, có cột `role`
(enum). Dùng trigger DB để tự tạo `profiles` row khi có user mới trong `auth.users`.

## Lựa chọn khác đã cân nhắc

- **Dùng `app_metadata`/`user_metadata` sẵn có của Supabase** — bị loại: các trường này
  chỉ sửa được qua Supabase Admin API (service role), khó join/filter bằng SQL thường khi
  các phase sau cần hiển thị danh sách người dùng theo role.

## Bằng chứng

- `node_modules/next/dist/docs/01-app/02-guides/authentication.md:625` — session payload
  nên chứa "the user's ID, role, etc." → xác nhận role là field chuẩn nên có trong user
  model theo khuyến nghị Next.js.
- [REQ-01](../requirements/REQ-01-dang-nhap-he-thong.md) AC5 (dòng 36-37): yêu cầu trực
  tiếp từ tài liệu BA.

## Hệ quả

Thêm một bảng + một trigger so với dùng field có sẵn của Supabase, đổi lại query role
bằng SQL thường, không phụ thuộc Supabase Admin API ở các phase sau.
