# ADR-0005: Cấu trúc `src/` + tổ chức theo feature

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** Toàn Phase 1, TD-00

## Bối cảnh

Repo là scaffold Next.js trống (chỉ có `app/page.tsx`, `app/layout.tsx` mặc định). Phase
1 có 5 domain (auth, tasks, kanban, notifications, reports) sẽ phát triển qua 4 tuần —
cần chốt cấu trúc một lần trước khi REQ nào bắt đầu code.

## Quyết định

Chuyển sang thư mục `src/`, tổ chức logic theo `src/features/<domain>/`
(`auth`, `tasks`, `kanban`, `notifications`, `reports`), giữ `src/app/` chỉ chứa route
(`page.tsx`, `layout.tsx`).

## Lựa chọn khác đã cân nhắc

- **Giữ `app/` ở root** (mặc định hiện tại) — đơn giản hơn nhưng trộn code nguồn với các
  file cấu hình ở root (`next.config.ts`, `eslint.config.mjs`...).
- **Tổ chức phẳng theo loại file** (`components/`, `hooks/`, `actions/` dùng chung cho mọi
  domain) — dễ rối khi 5 domain cùng phát triển song song, khó biết file nào thuộc REQ
  nào khi review.

## Bằng chứng

- `node_modules/next/dist/docs/01-app/01-getting-started/02-project-structure.md:28` —
  `src` được liệt kê chính thức là "Optional application source folder", Next.js hỗ trợ
  đầy đủ.
- `node_modules/next/dist/docs/01-app/01-getting-started/02-project-structure.md:40` —
  `proxy.ts` vẫn là file cấu hình top-level; theo
  `node_modules/next/dist/docs/01-app/01-getting-started/16-proxy.md:35`, khi dùng `src/`
  thì đặt `proxy.ts` bên trong `src/` (cùng cấp với `app/`).

## Hệ quả

Phải di chuyển toàn bộ `app/` hiện có và cập nhật path alias trong `tsconfig.json` trước
khi viết code đầu tiên (task T0.1) — chi phí một lần, không phát sinh lại sau.
