# TD-00 — Kiến trúc dự án & Bộ thư viện (Phase 1)

> Tài liệu Tech Lead, áp dụng cho toàn bộ Phase 1 "Notes Task" (REQ-01 → REQ-05,
> xem [Notes Task Phase 1](https://claude.ai/code/artifact/26c9e609-c912-4056-843c-a21db1042948)).
> Quyết định ở đây là nền dùng chung cho mọi REQ — chốt một lần trước khi bắt đầu code,
> tránh đổi cấu trúc giữa chừng.

## 1. Cấu trúc thư mục

Chuyển sang `src/` (tách code khỏi file cấu hình ở root) và tổ chức theo **feature**,
vì Phase 1 có 5 domain riêng biệt sẽ phình to dần qua 4 tuần — route file trong `app/`
giữ mỏng, logic nằm theo từng feature.

```
src/
  app/                     → chỉ chứa route (page.tsx, layout.tsx)
  proxy.ts                 → bảo vệ route (Next.js 16: "proxy", không phải "middleware")
  features/
    auth/                  → REQ-01
    tasks/                 → REQ-02
    kanban/                → REQ-03
    notifications/         → REQ-04
    reports/               → REQ-05
  components/ui/           → component dùng chung, sinh ra bởi shadcn/ui CLI
  lib/
    supabase/               → client.ts (browser), server.ts (server)
    utils.ts
  types/
    database.ts             → type sinh tự động từ Supabase schema
supabase/
  migrations/                → SQL migration, quản lý qua Supabase CLI
```

Test đặt cạnh file logic tương ứng (colocate), không tách cây thư mục `__tests__`
riêng — ví dụ `features/kanban/status-rules.ts` đi kèm `status-rules.test.ts`.

## 2. Bộ thư viện — đã chốt

| Nhu cầu            | Chọn                                                                   | Ghi chú                                                                                                                                                                                      |
| ------------------ | ---------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| DB access          | `@supabase/supabase-js` trực tiếp, không thêm ORM                      | Type sinh tự động qua Supabase CLI, đủ an toàn cho schema nhỏ                                                                                                                                |
| Next.js × Supabase | `@supabase/ssr`                                                        | Đồng bộ session qua cookie cho Server Component/Action                                                                                                                                       |
| Validate input     | `zod`                                                                  | Dùng lại cho mọi Server Action (login, task form...)                                                                                                                                         |
| UI components      | `shadcn/ui` (Radix + Tailwind, copy vào repo)                          | Đã có Tailwind v4 sẵn; tiết kiệm thời gian dựng form/dialog/dropdown/toast cho REQ-02, REQ-05                                                                                                |
| Kéo-thả Kanban     | `@dnd-kit/core` + `@dnd-kit/sortable`                                  | Chuẩn hiện tại cho React, accessible                                                                                                                                                         |
| Ngày tháng         | `date-fns`                                                             | Rule auto-stamp ngày (REQ-02/03), tính ngưỡng cảnh báo (REQ-04) — API dạng hàm thuần, dễ unit test độc lập từng rule (không phải vì nhẹ hơn dayjs — xem [ADR-0008](../adr/0008-date-fns.md)) |
| Gửi email          | `resend`                                                               | REQ-04 — Kyle tự cung cấp API key trước Phase 4 (21/09), không block scaffolding                                                                                                             |
| Cron cảnh báo      | Vercel Cron (route handler + `vercel.json`)                            | Có sẵn trên nền tảng deploy đã chốt                                                                                                                                                          |
| State UI tương tác | Không thêm thư viện — dùng `useOptimistic` (React 19) + Server Actions | Đủ cho optimistic update khi kéo thẻ kanban                                                                                                                                                  |
| Unit test          | `vitest`                                                               | Chỉ viết test cho logic rủi ro cao — rule tự động cập nhật ngày tháng khi đổi trạng thái (REQ-03), phần còn lại QA thủ công theo checklist AC                                                |

## 3. Task T0 — Khởi tạo cấu trúc & thư viện (trước T1 của REQ-01)

| ID   | Task                        | Mô tả                                                                                                          | Est   |
| ---- | --------------------------- | -------------------------------------------------------------------------------------------------------------- | ----- |
| T0.1 | Chuyển sang cấu trúc `src/` | Di chuyển `app/`, tạo `features/`, `components/`, `lib/`, `types/`, cập nhật path alias trong `tsconfig.json`  | 0.25d |
| T0.2 | Cài thư viện core           | `@supabase/supabase-js`, `@supabase/ssr`, `zod`, `date-fns`, `@dnd-kit/core`, `@dnd-kit/sortable`              | 0.25d |
| T0.3 | Khởi tạo shadcn/ui          | Chạy CLI init, chọn theme, tạo `components/ui/`                                                                | 0.25d |
| T0.4 | Khởi tạo Vitest             | `vitest.config.ts`, script `test` trong `package.json`                                                         | 0.25d |
| T0.5 | Cài đặt Resend (khung)      | Thêm package `resend`, thêm `RESEND_API_KEY` vào `.env.example` — giá trị thật đợi Kyle cung cấp trước Phase 4 | 0.1d  |

**Tổng T0: ~1.1 ngày**, làm ngay đầu Tuần 1 (31/08), trước khi bắt đầu T1 của
[TD-01](./TD-01-dang-nhap-he-thong.md). Sau T0, các đường dẫn trong TD-01 (`lib/supabase/...`)
hiểu ngầm là `src/lib/supabase/...`.

## 4. Việc chưa quyết — để dành đến lúc cần

- **Chart cho REQ-05** (báo cáo tổng quan): chưa chọn thư viện, quyết định khi vào Phase 4 (21/09) — không ảnh hưởng cấu trúc hiện tại.
- **Danh sách cố định người giao/nhận việc** (input cho REQ-02): chờ Kyle xác nhận, không phải quyết định kỹ thuật.

## 5. Bằng chứng chi tiết cho từng quyết định

Mọi quyết định trong bảng ở mục 2 và task T0 đều có ADR riêng (Bối cảnh / Quyết định /
Lựa chọn khác đã cân nhắc / Bằng chứng / Hệ quả) tại [docs/adr/](../adr/README.md).
