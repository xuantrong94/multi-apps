# ADR-0004: Không dùng ORM — Supabase client trực tiếp

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** Toàn Phase 1, TD-00

## Bối cảnh

Cần chọn cách truy vấn Postgres cho toàn bộ Phase 1 (bảng `tasks`, `profiles`, và các
truy vấn tổng hợp cho REQ-05).

## Quyết định

Dùng `@supabase/supabase-js` (query builder có sẵn) trực tiếp, kèm type TypeScript sinh
tự động bằng Supabase CLI (`supabase gen types typescript`). Không thêm ORM riêng.

## Lựa chọn khác đã cân nhắc

- **Drizzle ORM** — type-safe hơn, migration-as-code, nhưng thêm một lớp trừu tượng và thời gian setup cho một schema chỉ ~2 bảng chính ở Phase 1.
- **Prisma** — phổ biến, nhưng nặng hơn, cold-start chậm hơn trên môi trường
  serverless/Vercel, dư thừa cho quy mô solo-user.

## Bằng chứng

Đây là đánh giá kỹ thuật của Tech Lead dựa trên độ phức tạp schema thực tế, không phải quyết định bắt buộc từ tài liệu bên ngoài:

- Artifact "Notes Task Phase 1" (mục "Cấu trúc Task"): chỉ một bảng task chính (~12
  field) + bảng `profiles` ([ADR-0003](0003-role-via-profiles-table.md)) — quy mô không
  đủ phức tạp để cần ORM riêng ở Phase 1.

## Hệ quả

Giảm một dependency và thời gian setup, đổi lại phải tự viết type cho các truy vấn phức
tạp (join, aggregate) ở REQ-05 thay vì được ORM hỗ trợ sẵn. **Sẽ xem lại quyết định này**
nếu schema hoặc số lượng truy vấn tổng hợp phình to đáng kể khi vào Phase 4 (REQ-05).
