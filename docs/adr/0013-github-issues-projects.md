# ADR-0013: GitHub Issues + Projects (v2) làm công cụ quản lý task

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** Toàn Phase 1, thay thế [BACKLOG.md](../tasks/BACKLOG.md) làm nguồn theo dõi trạng thái

## Bối cảnh

Từ T0 trở đi, task được theo dõi thủ công trong `docs/tasks/BACKLOG.md` (bảng markdown,
đổi ký hiệu ☐/▶/☑/⏸ bằng tay). Cách này đủ dùng khi mới lên danh sách, nhưng không có
board trực quan, không lọc/nhóm được theo REQ hay Phase, và phải tự đồng bộ tay giữa
issue code (nếu commit có nhắc task) với trạng thái trong file.

Repo `xuantrong94/multi-apps` đã có sẵn trên GitHub (public), `gh` CLI đã đăng nhập với
scope `repo` — đủ quyền tạo label/milestone/issue.

## Quyết định

Chuyển việc theo dõi trạng thái task sang **GitHub Issues** (mỗi task T0.x/T1–T12 là một
issue) + **GitHub Projects (v2)** làm board Kanban. `docs/tasks/BACKLOG.md` và các tài
liệu TD/ADR trong `docs/` vẫn là nguồn quyết định/thiết kế gốc (không đổi), nhưng
**không còn dùng để track trạng thái** — trạng thái sống trên GitHub từ nay.

Quy ước cụ thể nằm ở [docs/tasks/GITHUB-SETUP.md](../tasks/GITHUB-SETUP.md).

## Lựa chọn khác đã cân nhắc

- **Tiếp tục dùng `BACKLOG.md`** — bị loại: không có board trực quan, không tự động liên
  kết với commit/PR, phải tự đồng bộ tay — rủi ro lệch trạng thái khi làm việc thực tế.
- **Công cụ ngoài (Trello, Linear, Notion)** — bị loại: thêm một tài khoản/nền tảng ngoài
  phải quản lý, trong khi GitHub đã là nơi chứa code và đã có sẵn tài khoản/repo.

## Bằng chứng

- `gh repo view` (2026-08-29): repo `xuantrong94/multi-apps` tồn tại, `isPrivate: false`,
  `gh auth status` xác nhận đã đăng nhập với scope `repo` — đủ điều kiện tạo issue/label/
  milestone ngay mà không cần cấp quyền thêm.
- `gh project list --owner xuantrong94` (2026-08-29) báo lỗi thiếu scope
  `read:project` — xác nhận cần chạy `gh auth refresh -s project` (thao tác cấp quyền
  OAuth, cần chính Kyle xác nhận tương tác trên trình duyệt) trước khi có thể tạo/quản lý
  Project (v2) qua CLI; nếu không, dựng qua giao diện web không cần thêm quyền.
- Tra cứu web ngày 2026-08-29 (GitHub Docs — "About Projects"): Projects (v2) hỗ trợ
  nhóm/lọc theo bất kỳ field nào (Status, Milestone, custom field), tối đa 50 field mỗi
  project, và có workflow tự động (auto-add item, auto-set field khi issue đóng) — đủ để
  dựng Kanban nhóm theo Status và một view phụ nhóm theo Milestone (Phase) mà không cần
  trùng lặp thông tin Phase ở cả label lẫn milestone.

## Hệ quả

- Cần tạo thêm label (`req:REQ-01`…`req:REQ-05`, `scaffolding`) và 4 milestone (P1–P4)
  trước khi tạo issue — việc này **publish nội dung công khai** lên một repo public, nên
  cần Kyle xác nhận trước khi Tech Lead (Claude) chạy các lệnh `gh` tạo hàng loạt.
- Dựng Project (v2) board cần Kyle tự chạy `gh auth refresh -s project` (nếu muốn làm qua
  CLI) hoặc tự thao tác qua web UI theo hướng dẫn — Claude không tự cấp quyền OAuth thay
  được.
- `docs/tasks/BACKLOG.md` giữ nguyên làm bản snapshot ban đầu, không cập nhật trạng thái
  nữa sau khi issue tương ứng được tạo — tránh có 2 nguồn sự thật (source of truth) khác
  nhau.
