# ADR-0011: Không dùng state management library — `useOptimistic`

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-03, TD-00

## Bối cảnh

REQ-03 cần UI phản hồi ngay khi kéo thẻ kanban (optimistic update) trước khi Server
Action xác nhận xong ở server.

## Quyết định

Dùng hook `useOptimistic` có sẵn của React 19 kết hợp Server Actions, không thêm thư viện
state client (Redux/Zustand/Jotai).

## Lựa chọn khác đã cân nhắc

- **Zustand/Jotai** — thư viện state client phổ biến, nhẹ, nhưng dư thừa khi phần lớn
  state của app là server state đã được Server Components + Server Actions quản lý; toàn
  Phase 1 chỉ có một điểm cần optimistic update (kéo-thả kanban ở REQ-03).

## Bằng chứng

- `package.json`: `react@19.2.8` đã cài sẵn — `useOptimistic` là API chính thức của React
  19 (react.dev), sẵn dùng không cần thêm dependency.

## Hệ quả

Nếu sau này phát sinh nhiều điểm cần state client phức tạp hơn (ngoài phạm vi Phase 1
hiện tại — REQ-01→05 đều là CRUD/kanban/report đơn giản), sẽ cần xem lại quyết định này.
