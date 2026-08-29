# ADR-0002: `proxy.ts` + Data Access Layer — 2 lớp bảo vệ route

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-01 (AC3), TD-01

## Bối cảnh

REQ-01 AC3 yêu cầu: truy cập trực tiếp bất kỳ URL nào khi chưa đăng nhập phải bị chuyển
hướng về `/login`, không xem được dữ liệu. Kiến thức nền gọi file chặn request này là
`middleware.ts` — nhưng `AGENTS.md` của repo cảnh báo phiên bản Next.js đã cài có breaking
changes so với training data, cần xác minh lại trong tài liệu cài kèm trước khi dùng.

## Quyết định

Dùng **`proxy.ts`** (không phải `middleware.ts`) ở gốc `src/` làm lớp kiểm tra
**optimistic** (chỉ đọc cookie, redirect nhanh), kết hợp **Data Access Layer**
(`features/auth/dal.ts`) gọi `supabase.auth.getUser()` làm lớp kiểm tra **secure** — bắt
buộc gọi trước khi bất kỳ Server Component/Server Action/Route Handler nào trả dữ liệu
task.

## Lựa chọn khác đã cân nhắc

- **Chỉ dùng `proxy.ts`** — bị loại: tài liệu chính thức cảnh báo Proxy chạy trên mọi
  request kể cả prefetch nên không nên query DB ở đây, và một thay đổi `matcher` có thể
  âm thầm bỏ sót một route.
- **Chỉ dùng DAL, không có proxy** — bị loại: mỗi request phải render tới tận Server
  Component mới redirect được, chậm hơn so với chặn sớm ở proxy.

## Bằng chứng

- `node_modules/next/dist/docs/01-app/01-getting-started/16-proxy.md:15` — "Starting with
  Next.js 16, Middleware is now called Proxy to better reflect its purpose."
- `node_modules/next/dist/docs/01-app/03-api-reference/03-file-conventions/proxy.md:11` —
  "The `middleware` file convention is deprecated and has been renamed to `proxy`."
- `node_modules/next/dist/docs/01-app/02-guides/authentication.md:1026-1233` (mục
  "Optimistic checks with Proxy" và "Creating a Data Access Layer (DAL)") — khuyến nghị
  chính thức mô hình 2 lớp optimistic (Proxy) + secure (DAL), không dùng Proxy làm tuyến
  phòng thủ duy nhất.
- `node_modules/next/dist/docs/01-app/03-api-reference/03-file-conventions/proxy.md:249-251`
  — cảnh báo: một thay đổi `matcher` hoặc refactor route có thể âm thầm bỏ Proxy coverage;
  khuyến nghị luôn xác thực lại bên trong từng Server Function.

## Hệ quả

Thêm một lớp code (DAL) so với chỉ dùng proxy, nhưng đúng khuyến nghị bảo mật chính thức
và tái dùng được cho REQ-02 → REQ-05 mỗi khi cần xác thực trước khi trả dữ liệu task.
