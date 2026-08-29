# ADR-0015: Title issue/milestone/branch dùng tiếng Anh, docs giữ tiếng Việt

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** Toàn Phase 1, sửa lại [ADR-0013](0013-github-issues-projects.md)

## Bối cảnh

Toàn bộ 19 issue và 4 milestone ban đầu được tạo với title tiếng Việt (theo
[ADR-0013](0013-github-issues-projects.md)). Kyle dùng tính năng "Create a branch" của
GitHub trên issue #1 (`[T0.1] Chuyển sang cấu trúc src/`) — GitHub tự sinh tên nhánh từ
title, ra `1-t01-chuyển-sang-cấu-trúc-src`, và hiển thị cảnh báo: **"The head ref may
contain hidden characters"** kèm chuỗi title bị escape thành `ển`, `ấu`,
`úc` (dấu tiếng Việt bị mã hoá dưới dạng Unicode escape trong ref name).

## Quyết định

- **Title issue, title/description milestone, tên branch:** tiếng Anh.
- **Body issue, mọi file trong `docs/`, commit message:** giữ tiếng Việt (docs) / tiếng
  Anh (commit message — theo yêu cầu riêng của Kyle) — không đổi.
- Đã thực hiện ngay: đổi tên nhánh `1-t01-chuyển-sang-cấu-trúc-src` →
  `1-t0.1-switch-to-src-structure` (xoá nhánh cũ trên origin), đổi title toàn bộ 19 issue
  và 4 milestone (title + description) sang tiếng Anh.

## Lựa chọn khác đã cân nhắc

- **Giữ title tiếng Việt, chỉ tránh dùng tính năng "Create a branch" từ issue** — bị
  loại: phụ thuộc vào việc Kyle luôn nhớ không bấm nút đó, không loại bỏ được rủi ro gốc
  (title tiếng Việt vẫn có thể bị copy vào branch name/PR title theo cách khác).
- **Dịch cả body issue sang tiếng Anh** — bị loại: body không trở thành git ref, không có
  vấn đề kỹ thuật; giữ tiếng Việt để nhất quán với toàn bộ tài liệu quyết định trong
  `docs/` mà Kyle đọc.

## Bằng chứng

- Screenshot cảnh báo GitHub do Kyle cung cấp (2026-08-29): "⚠️ The head ref may contain
  hidden characters: `"1-t01-chuyển-sang-cấu-trúc-src"`" — xác nhận trực
  tiếp vấn đề, không cần tra cứu thêm.
- `git branch -a` (2026-08-29): xác nhận nhánh `1-t01-chuyển-sang-cấu-trúc-src` thực sự
  tồn tại trên `origin` và đang được checkout, kèm các commit T0.1 đã thực hiện trên đó.
- Quy ước phổ biến của git/GitHub: tên branch/ref chỉ nên dùng ASCII để tránh vấn đề
  hiển thị/encode khác nhau giữa OS, terminal, và các tool CI/CD — tình huống thực tế vừa
  gặp là một ví dụ cụ thể của vấn đề này, không phải rủi ro lý thuyết.

## Hệ quả

- Đã đổi toàn bộ 19 issue title + 4 milestone title/description + 1 branch — không có
  issue/milestone/branch nào còn tiếng Việt trong title.
- Từ nay, mọi issue/milestone mới (REQ-02→05) phải tạo title tiếng Anh ngay từ đầu — cập
  nhật trong [GITHUB-SETUP.md](../tasks/GITHUB-SETUP.md) mục 2 và 3.
- `docs/tasks/BACKLOG.md` không đổi (vẫn tiếng Việt, đúng vai trò "docs") — chỉ có tài
  liệu hướng dẫn (`GITHUB-SETUP.md`) cập nhật ví dụ cho khớp thực tế.
