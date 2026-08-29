# TD-01 — Đăng nhập hệ thống (Technical Design & Task Breakdown)

> Tài liệu Tech Lead, bàn giao từ [REQ-01](../requirements/REQ-01-dang-nhap-he-thong.md).
> Diễn giải kỹ thuật cho yêu cầu và acceptance criteria đã chốt — không mở rộng phạm vi ngoài REQ-01.

|                      |                         |
| -------------------- | ----------------------- |
| **Liên kết yêu cầu** | REQ-01                  |
| **Phase**            | P1 (31/08 – 04/09/2026) |
| **Ước tính tổng**    | ~4.5 ngày công          |
| **Trạng thái**       | Sẵn sàng triển khai     |

## 1. Quyết định kỹ thuật

> Bối cảnh, lựa chọn khác đã cân nhắc, và bằng chứng chi tiết cho từng quyết định dưới
> đây nằm ở [ADR-0001](../adr/0001-supabase-auth.md), [ADR-0002](../adr/0002-proxy-dal-route-protection.md),
> [ADR-0003](../adr/0003-role-via-profiles-table.md) — mục này chỉ tóm tắt kết luận.

- **Auth provider: Supabase Auth (email/password).** DB đã chốt là Postgres/Supabase, nên dùng luôn Auth của Supabase thay vì tự viết cơ chế hash mật khẩu/JWT — Next.js chính thức khuyến nghị dùng auth library thay vì tự làm để tránh lỗ hổng bảo mật. ([ADR-0001](../adr/0001-supabase-auth.md))
- **Tích hợp Next.js: `@supabase/ssr`** — tạo Supabase client riêng cho browser và cho server (Server Component/Server Action/Route Handler), đồng bộ session qua cookie `HttpOnly`. ([ADR-0001](../adr/0001-supabase-auth.md))
- **Bảo vệ route: `proxy.ts`** (Next.js 16 đổi tên từ `middleware.ts` — breaking change so với kiến thức nền, đã xác nhận lại trong `node_modules/next/dist/docs`). Đặt ở root repo, đọc cookie session để redirect optimistic (chưa đăng nhập → `/login`; đã đăng nhập mà vào `/login` → vào trang task list).
- **Data Access Layer (`lib/dal.ts`)** — lớp xác thực "chắc chắn" (secure check), gọi `supabase.auth.getUser()`, dùng `cache()` để tránh gọi lặp trong 1 lần render. Mọi Server Component/Server Action/Route Handler đọc dữ liệu task ở REQ-02+ đều phải đi qua lớp này, không dựa vào `proxy.ts` làm tuyến phòng thủ duy nhất (đúng khuyến nghị chính thức: Proxy chỉ optimistic, kiểm tra thật phải ở gần data nhất). ([ADR-0002](../adr/0002-proxy-dal-route-protection.md))
- **Form đăng nhập/đăng xuất: React Server Actions** (`<form action={login}>` + `useActionState`) — không cần dựng API route riêng cho login/logout.
- **Trường vai trò (role):** bảng `profiles` (public schema), 1-1 với `auth.users` qua `id`, có cột `role` (enum, giá trị khởi tạo Phase 1: `admin`). Không dùng `app_metadata` của Supabase vì cần query/filter dễ dàng ở app layer sau này khi multi-user. ([ADR-0003](../adr/0003-role-via-profiles-table.md))
- **Tài khoản Phase 1:** tạo thủ công qua Supabase Dashboard (hoặc seed script chạy tay), gán sẵn `role = admin`, tắt yêu cầu xác nhận email cho tài khoản này — đúng phần "ngoài phạm vi" của REQ-01 (không có UI đăng ký).

Không phát sinh nhu cầu vượt "Ngoài phạm vi" của REQ-01 (không cần 2FA, không cần SSO, không cần đăng ký) — không cần escalate lại cho BA.

## 2. Task Breakdown (WBS)

| ID  | Task                                     | Mô tả                                                                                                                     | Est   | Phụ thuộc | AC liên quan            |
| --- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ----- | --------- | ----------------------- |
| T1  | Khởi tạo Supabase project                | Tạo project, lấy URL/anon key/service key, thêm vào `.env.local` + Vercel env, cập nhật `.env.example`                    | 0.5d  | —         | nền tảng                |
| T2  | Cấu hình Supabase client cho Next.js     | Cài `@supabase/ssr`, tạo `lib/supabase/client.ts` (browser) và `lib/supabase/server.ts` (server, dùng `cookies()`)        | 0.25d | T1        | nền tảng                |
| T3  | Migration bảng `profiles` + role         | Enum `role`, bảng `profiles` (FK → `auth.users.id`), trigger tự tạo profile khi có user mới                               | 0.5d  | T1        | AC5                     |
| T4  | Seed tài khoản admin                     | Tạo tài khoản Phase 1 thủ công, gán `role = admin`, xác nhận email sẵn                                                    | 0.25d | T3        | AC5                     |
| T5  | UI trang đăng nhập                       | `app/login/page.tsx` — form email/password                                                                                | 0.5d  | T2        | AC1, AC2                |
| T6  | Server Action `login`                    | Gọi `supabase.auth.signInWithPassword`, redirect khi thành công                                                           | 0.5d  | T2, T5    | AC1                     |
| T7  | Hiển thị lỗi đăng nhập                   | `useActionState` trả thông báo lỗi rõ ràng khi sai tài khoản/mật khẩu                                                     | 0.25d | T6        | AC2                     |
| T8  | `proxy.ts` — optimistic route protection | Redirect chưa đăng nhập → `/login`; đã đăng nhập mà vào `/login` → vào trang task list                                    | 0.5d  | T2        | AC3                     |
| T9  | Data Access Layer (`lib/dal.ts`)         | `verifySession()` / `getUser()` dùng `cache()`, là điểm bắt buộc cho mọi truy vấn dữ liệu task                            | 0.5d  | T2        | AC3 (nền cho REQ-02→05) |
| T10 | Server Action `logout`                   | `supabase.auth.signOut()`, xoá session, redirect `/login`                                                                 | 0.25d | T6        | AC4                     |
| T11 | Trang task list (placeholder)            | `app/(protected)/tasks/page.tsx` — điểm đến sau đăng nhập, dùng DAL lấy user, có nút đăng xuất (UI đầy đủ thuộc REQ-02+)  | 0.5d  | T9, T10   | AC1, AC4                |
| T12 | Kiểm thử theo checklist AC               | Đăng nhập đúng/sai, truy cập URL trực tiếp khi chưa đăng nhập, đăng xuất xong không còn truy cập được, role hiển thị đúng | 0.5d  | T1–T11    | AC1–AC5                 |

**Thứ tự thực hiện đề xuất:** T1 → T2 → (T3 → T4 song song với T5) → T6 → T7 → T8 → T9 → T10 → T11 → T12.

## 3. Rủi ro / lưu ý kỹ thuật

- `proxy.ts` (không phải `middleware.ts`) là quy ước bắt buộc từ Next.js 16 — nếu tạo nhầm tên file, route sẽ không được bảo vệ mà không có cảnh báo rõ ràng lúc build.
- Proxy chỉ nên đọc cookie (optimistic check) — không query DB trong `proxy.ts` để tránh chậm mọi request; việc xác thực thật nằm ở DAL (T9).
- Cần đảm bảo tài khoản seed (T4) không bị Supabase yêu cầu xác nhận email lần đầu, nếu không đăng nhập sẽ thất bại ở bước đầu tiên khi test (T12).
