# Backlog thực thi — Phase 1

> Danh sách task để chạy thực tế, gộp từ [TD-00](../tech-design/TD-00-kien-truc-va-thu-vien.md)
> (T0) và [TD-01](../tech-design/TD-01-dang-nhap-he-thong.md) (T1–T12).
>
> **Cập nhật ([ADR-0013](../adr/0013-github-issues-projects.md)):** việc track trạng thái
> chuyển sang GitHub Issues + Project — xem [GITHUB-SETUP.md](GITHUB-SETUP.md). File này
> giữ nguyên làm bản ghi kế hoạch gốc (mã task T0.x/T1–T12 dùng để đối chiếu với tiêu đề
> issue), không cập nhật ☐/▶/☑/⏸ ở đây nữa sau khi issue tương ứng đã được tạo.

Chú thích trạng thái: `☐` Chưa bắt đầu · `▶` Đang làm · `☑` Xong · `⏸` Blocked

## T0 — Khởi tạo cấu trúc & thư viện dự án

Làm trước tiên, một lần duy nhất, trước khi chạm vào bất kỳ REQ nào. Không có task nào
của REQ-01 (T1+) nên bắt đầu trước khi cả 5 subtask dưới đây xong.

| #    | Task                        | DoD (Definition of Done)                                                                                                                                              | Phụ thuộc  | Trạng thái |
| ---- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ---------- |
| T0.1 | Chuyển sang cấu trúc `src/` | `src/app`, `src/features`, `src/components`, `src/lib`, `src/types` tồn tại; path alias `@/*` → `src/*` trong `tsconfig.json`; `pnpm dev` chạy route `/` cũ không lỗi | —          | ☐          |
| T0.2 | Cài thư viện core           | `package.json` có `@supabase/supabase-js`, `@supabase/ssr`, `zod`, `date-fns`, `@dnd-kit/core`, `@dnd-kit/sortable`; `pnpm install` sạch, không lỗi peer dependency   | T0.1       | ☐          |
| T0.3 | Khởi tạo shadcn/ui          | `components.json` tồn tại ở root; `src/components/ui/` có ít nhất 1 component mẫu (vd `button`) render được                                                           | T0.1, T0.2 | ☐          |
| T0.4 | Khởi tạo Vitest             | `vitest.config.ts` tồn tại; script `"test": "vitest run"` trong `package.json`; `pnpm test` chạy được (kể cả khi chưa có test file nào)                               | T0.1       | ☐          |
| T0.5 | Cài đặt khung Resend        | `resend` có trong `dependencies`; `.env.example` có dòng `RESEND_API_KEY=` (giá trị thật đợi Kyle cung cấp trước Phase 4 — không block)                               | T0.1       | ☐          |

**DoD của cả T0:** 5/5 subtask ☑, `pnpm build` chạy thành công, `pnpm lint` sạch. Chỉ khi
đó mới mở khóa T1.

## REQ-01 — Đăng nhập hệ thống (P1 · 31/08–04/09)

Chi tiết quyết định kỹ thuật xem [TD-01](../tech-design/TD-01-dang-nhap-he-thong.md).
Đường dẫn `lib/...` trong TD-01 hiểu ngầm là `src/lib/...` sau khi T0 xong.

| #   | Task                                                                 | AC liên quan | Phụ thuộc | Trạng thái |
| --- | -------------------------------------------------------------------- | ------------ | --------- | ---------- |
| T1  | Khởi tạo Supabase project (env, keys)                                | nền tảng     | T0        | ☐          |
| T2  | Cấu hình Supabase client (`src/lib/supabase/client.ts`, `server.ts`) | nền tảng     | T1        | ☐          |
| T3  | Migration bảng `profiles` + role                                     | AC5          | T1        | ☐          |
| T4  | Seed tài khoản admin                                                 | AC5          | T3        | ☐          |
| T5  | UI trang đăng nhập                                                   | AC1, AC2     | T2        | ☐          |
| T6  | Server Action `login`                                                | AC1          | T2, T5    | ☐          |
| T7  | Hiển thị lỗi đăng nhập                                               | AC2          | T6        | ☐          |
| T8  | `proxy.ts` — optimistic route protection                             | AC3          | T2        | ☐          |
| T9  | Data Access Layer (`src/features/auth/dal.ts`)                       | AC3          | T2        | ☐          |
| T10 | Server Action `logout`                                               | AC4          | T6        | ☐          |
| T11 | Trang task list (placeholder)                                        | AC1, AC4     | T9, T10   | ☐          |
| T12 | Kiểm thử theo checklist AC (thủ công)                                | AC1–AC5      | T1–T11    | ☐          |

**DoD của REQ-01:** 12/12 task ☑, cả 5 AC trong
[REQ-01](../requirements/REQ-01-dang-nhap-he-thong.md) pass ở bước T12, sẵn sàng cho Mốc
M1 (04/09) review với khách hàng.

## Chưa lên task (chờ TD riêng)

REQ-02 (P2), REQ-03 (P3), REQ-04/REQ-05 (P4) chưa được chia nhỏ task — sẽ có TD-02, TD-03,
TD-04 riêng (theo mẫu TD-01) khi bắt đầu từng tuần tương ứng, không lên trước để tránh
task bị lỗi thời nếu quyết định kỹ thuật thay đổi giữa chừng.

---

**Cách dùng:** khi bắt đầu một task, đổi `☐` → `▶`; khi xong và đạt DoD, đổi → `☑`. Nếu
bị chặn, đổi → `⏸` kèm ghi chú lý do ngay dưới dòng đó.
