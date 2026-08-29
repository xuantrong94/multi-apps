# ADR-0006: shadcn/ui cho UI components

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-02, REQ-05, TD-00

## Bối cảnh

Cần bộ component (form, dialog, dropdown, toast...) cho REQ-02 (form task), REQ-03
(kanban card), REQ-05 (báo cáo) trong 4 tuần — dự án solo, không có thời gian dựng lại
từng component từ đầu.

## Quyết định

Dùng **shadcn/ui** — component copy trực tiếp vào repo (`components/ui/`), dựa trên
Radix UI + Tailwind CSS.

## Lựa chọn khác đã cân nhắc

- **Tự dựng component từ Tailwind thuần** — toàn quyền kiểm soát UI, không phụ thuộc thư
  viện ngoài, nhưng tốn thời gian dựng lại dialog/dropdown/toast từ đầu — rủi ro với
  deadline 4 tuần.
- **Thư viện component đóng gói (Mantine, Chakra UI)** — không Tailwind-native, xung đột
  hướng tiếp cận với Tailwind v4 đã cài sẵn trong repo.

## Bằng chứng

- Quyết định trực tiếp từ Kyle (product owner) trong phiên trao đổi kỹ thuật ngày
  2026-08-29 — câu hỏi "UI component: shadcn/ui hay Tailwind thuần?", chọn
  **"shadcn/ui (khuyến nghị)"**.
- `package.json`: Tailwind v4 (`tailwindcss@^4`, `@tailwindcss/postcss`) đã cài sẵn — điều
  kiện tiên quyết để dùng shadcn/ui.

## Hệ quả

Thêm các dependency đi kèm mỗi component được thêm vào (Radix primitives,
`class-variance-authority`, `clsx`, `tailwind-merge`, `lucide-react`) — chấp nhận được để
đổi lấy tốc độ triển khai form/dialog cho REQ-02 và REQ-05.
