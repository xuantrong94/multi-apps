# ADR-0007: dnd-kit cho kéo-thả Kanban

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-03, TD-00

## Bối cảnh

REQ-03 (P3, 14/09–18/09) cần kéo-thả thẻ task giữa các cột trạng thái trên kanban board.

## Quyết định

Dùng `@dnd-kit/core` + `@dnd-kit/sortable`.

## Lựa chọn khác đã cân nhắc

- **react-beautiful-dnd** — **không dùng**: đã bị Atlassian archive (repo read-only)
  ngày 18/08/2025, không còn maintain, không hỗ trợ React 19.
- **Pragmatic drag-and-drop** (thư viện kế nhiệm của Atlassian) — mạnh cho file-drag,
  external drag source, hoặc kéo-thả hàng nghìn item — dư thừa cho kanban board đơn giản
  của Phase 1 (một danh sách task solo-user).

## Bằng chứng

Tra cứu web ngày 2026-08-29:

- GitHub `atlassian/react-beautiful-dnd`: repository bị archive (read-only) ngày
  18/08/2025; Atlassian pivoted sang xây Pragmatic drag-and-drop.
- PkgPulse — "dnd-kit vs react-beautiful-dnd vs Pragmatic DnD 2026": "dnd-kit is the
  default choice for most React drag-and-drop needs and is recommended as the top choice
  for new React projects"; Pragmatic DnD "recommended only when you need specific
  strengths like file drag targets, external drag sources, or performance at
  thousands-of-items scale" — không phải trường hợp của Phase 1.

## Hệ quả

Không có rủi ro đáng kể — dnd-kit là lựa chọn được maintain tích cực và phù hợp quy mô
kanban đơn giản của Phase 1.
