# Architecture Decision Records — Notes Task (Phase 1)

Mỗi quyết định kỹ thuật của dự án được ghi lại ở đây theo mẫu: Bối cảnh → Quyết định
→ Lựa chọn khác đã cân nhắc → **Bằng chứng** → Hệ quả. Không ghi quyết định nào mà
không có bằng chứng/tài liệu kèm theo (trích dẫn tài liệu Next.js đã cài trong repo,
kết quả tra cứu, hoặc xác nhận trực tiếp từ product owner trong phiên trao đổi).

| ID                                               | Quyết định                                                  | Trạng thái | Liên quan              |
| ------------------------------------------------ | ----------------------------------------------------------- | ---------- | ---------------------- |
| [ADR-0001](0001-supabase-auth.md)                | Supabase Auth + `@supabase/ssr` làm nền auth                | Accepted   | REQ-01                 |
| [ADR-0002](0002-proxy-dal-route-protection.md)   | `proxy.ts` + Data Access Layer — 2 lớp bảo vệ route         | Accepted   | REQ-01                 |
| [ADR-0003](0003-role-via-profiles-table.md)      | Trường `role` qua bảng `profiles` riêng                     | Accepted   | REQ-01                 |
| [ADR-0004](0004-no-orm-supabase-client.md)       | Không dùng ORM — Supabase client trực tiếp                  | Accepted   | Toàn Phase 1           |
| [ADR-0005](0005-src-feature-structure.md)        | Cấu trúc `src/` + tổ chức theo feature                      | Accepted   | Toàn Phase 1           |
| [ADR-0006](0006-shadcn-ui.md)                    | shadcn/ui cho UI components                                 | Accepted   | REQ-02, REQ-05         |
| [ADR-0007](0007-dnd-kit.md)                      | dnd-kit cho kéo-thả Kanban                                  | Accepted   | REQ-03                 |
| [ADR-0008](0008-date-fns.md)                     | date-fns cho xử lý ngày tháng                               | Accepted   | REQ-02, REQ-03, REQ-04 |
| [ADR-0009](0009-resend-email.md)                 | Resend cho gửi email                                        | Accepted   | REQ-04                 |
| [ADR-0010](0010-vercel-cron.md)                  | Vercel Cron cho job cảnh báo định kỳ                        | Accepted   | REQ-04                 |
| [ADR-0011](0011-no-state-lib-use-optimistic.md)  | Không dùng state management library — `useOptimistic`       | Accepted   | REQ-03                 |
| [ADR-0012](0012-vitest-scoped-testing.md)        | Vitest — chỉ test logic rủi ro cao                          | Accepted   | REQ-03                 |
| [ADR-0013](0013-github-issues-projects.md)       | GitHub Issues + Projects (v2) làm công cụ quản lý task      | Accepted   | Toàn Phase 1           |
| [ADR-0014](0014-branching-strategy.md)           | Chiến lược nhánh — `main` + `develop`                       | Accepted   | Toàn Phase 1           |
| [ADR-0015](0015-github-facing-titles-english.md) | Title issue/milestone/branch tiếng Anh, docs giữ tiếng Việt | Accepted   | Toàn Phase 1           |

Tài liệu liên quan: [TD-00 Kiến trúc & thư viện](../tech-design/TD-00-kien-truc-va-thu-vien.md) ·
[TD-01 Đăng nhập hệ thống](../tech-design/TD-01-dang-nhap-he-thong.md) ·
[REQ-01](../requirements/REQ-01-dang-nhap-he-thong.md)
