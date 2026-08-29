# ADR-0001: Supabase Auth + `@supabase/ssr` làm nền auth

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-01, TD-01

## Bối cảnh

REQ-01 cần cơ chế đăng nhập/đăng xuất. REQ-01 chốt sẵn: dữ liệu lưu trên PostgreSQL (Supabase), và để ngỏ việc chọn nhà cung cấp auth cụ thể cho Tech Lead quyết định.

## Quyết định

Dùng **Supabase Auth** (email/password) tích hợp Next.js App Router qua
**`@supabase/ssr`**.

## Lựa chọn khác đã cân nhắc

- **Tự viết auth** (jose + cookie thủ công theo ví dụ giáo dục của Next.js) — bị loại vì chính tài liệu Next.js coi đây là ví dụ minh họa, không khuyến nghị dùng cho production.
- **NextAuth.js / Auth.js** — phổ biến, nhưng là một hệ thống auth tách biệt khỏi Postgres/Supabase đã chọn, cần thêm adapter để nối 2 hệ thống.
- **Clerk / Auth0** — dịch vụ auth ngoài trả phí theo user, dư thừa cho 1 tài khoản admin duy nhất ở Phase 1.

## Bằng chứng

- `node_modules/next/dist/docs/01-app/02-guides/authentication.md:25` — Next.js khuyến nghị dùng auth library thay vì tự viết để đảm bảo bảo mật.
- `node_modules/next/dist/docs/01-app/02-guides/authentication.md:1641` — Supabase nằm trong danh sách Auth Libraries chính thức mà Next.js liệt kê.
- Supabase docs (tra cứu 2026-08-29, supabase.com/docs/guides/auth/auth-helpers/nextjs): Supabase chính thức khuyến nghị `@supabase/ssr` cho Next.js App Router (gói `auth-helpers-nextjs` cũ đã deprecated); template chính thức của Supabase tạo sẵn `lib/supabase/client.ts` (browser) và `lib/supabase/server.ts` (server) — trùng khớp cấu trúc đã chọn ở [TD-00](../tech-design/TD-00-kien-truc-va-thu-vien.md).
- Artifact "Notes Task Phase 1" (mục Ràng buộc): "Nơi lưu trữ dữ liệu: PostgreSQL (Supabase) — đã chốt với khách hàng" → dùng chung Supabase cho DB lẫn Auth giảm một hệ thống cần quản lý.

## Hệ quả

Phụ thuộc vào nền tảng Supabase cho cả DB lẫn Auth — chấp nhận được vì đã là quyết định nền tảng từ đầu dự án. Đổi lại tận dụng được session/cookie management có sẵn, giảm rủi ro tự viết cơ chế bảo mật sai.
