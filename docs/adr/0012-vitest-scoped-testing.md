# ADR-0012: Vitest — chỉ test logic rủi ro cao

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** REQ-03, TD-00

## Bối cảnh

Dự án solo, deadline 4 tuần (31/08–25/09/2026). REQ-03 có rule rẽ nhánh phức tạp: tự
động gán ngày theo trạng thái, nhánh Fix/Pending/On Hold, và quy tắc xóa/ghi đè ngày cũ
khi kéo thẻ lùi trạng thái.

## Quyết định

Dùng **Vitest**, nhưng chỉ viết unit test cho **rule tự động cập nhật ngày tháng**
(REQ-03). Phần còn lại (UI, luồng CRUD, kanban rendering...) kiểm thử thủ công theo
checklist acceptance criteria mỗi phase (đã có sẵn dạng task T12 trong
[TD-01](../tech-design/TD-01-dang-nhap-he-thong.md)).

## Lựa chọn khác đã cân nhắc

- **Không viết test tự động** — rủi ro: rule rẽ nhánh ngày tháng dễ sai khi sửa lại sau
  này, đặc biệt quy tắc "kéo lùi thì xóa/ghi đè ngày cũ" không có gì bắt lỗi ngoài test.
- **Full test suite (unit + e2e Playwright)** — vượt quá ngân sách thời gian hợp lý cho
  dự án solo 4 tuần, không tương xứng với rủi ro thực tế của một app nội bộ 1 người dùng.

## Bằng chứng

- Quyết định trực tiếp từ Kyle trong phiên trao đổi kỹ thuật ngày 2026-08-29 — câu hỏi
  "Testing", chọn **"Unit test cho phần logic rủi ro cao"**.
- Artifact "Notes Task Phase 1" (mục Rủi ro): "Quy tắc tự động cập nhật ngày tháng phát
  sinh case chưa lường trước khi thao tác thực tế" được BA đánh giá tác động **"Trung
  bình"** — xác nhận đây đúng là phần rủi ro cao nhất cần test tự động, phần còn lại chấp
  nhận QA thủ công.

## Hệ quả

Không có coverage tự động cho UI hay luồng CRUD/kanban khác — chấp nhận rủi ro thấp hơn ở
các phần đó để đổi lấy tốc độ, đã được product owner xác nhận trực tiếp.
