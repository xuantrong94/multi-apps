# REQ-01 — Đăng nhập hệ thống

> Tài liệu bàn giao từ BA sang Tech Lead. Mô tả **yêu cầu và tiêu chí nghiệm thu**;
> cách triển khai kỹ thuật (nhà cung cấp auth, thư viện, luồng xử lý...) do Tech Lead quyết định.

|                |                                                                                                        |
| -------------- | ------------------------------------------------------------------------------------------------------ |
| **Mã yêu cầu** | REQ-01                                                                                                 |
| **Ưu tiên**    | Must have                                                                                              |
| **Phase**      | P1 (31/08 – 04/09/2026)                                                                                |
| **Trạng thái** | Scope đã chốt với khách hàng — sẵn sàng thiết kế kỹ thuật                                              |
| **Phụ thuộc**  | Không có — đây là yêu cầu nền tảng, mọi yêu cầu khác (REQ-02 → REQ-05) đều cần REQ-01 hoàn thành trước |

## Mô tả

Người dùng cần đăng nhập vào hệ thống bằng tài khoản cá nhân trước khi được xem hoặc
thao tác với dữ liệu task. Đây là yêu cầu nền tảng, mở đường cho toàn bộ các yêu cầu
còn lại của Phase 1.

## Bối cảnh nghiệp vụ

Phase 1 ("Notes Task") hiện chỉ phục vụ một người dùng (Kyle), nhưng đây là app đầu
tiên trong bộ multi-app Medpro — các phase sau sẽ có nhiều người dùng khác nhau. Vì
vậy mỗi tài khoản cần có sẵn khái niệm **vai trò (role)** ngay từ Phase 1, dù hiện tại
chỉ tồn tại một tài khoản duy nhất với vai trò admin, để không phải làm lại cơ chế xác
thực khi mở rộng sang multi-user.

## Tiêu chí nghiệm thu (Acceptance Criteria)

- [ ] Đăng nhập thành công bằng tài khoản hợp lệ → chuyển vào trang danh sách task.
- [ ] Đăng nhập sai thông tin → nhận thông báo lỗi rõ ràng, không vào được hệ thống.
- [ ] Truy cập trực tiếp bất kỳ URL nào trong app khi chưa đăng nhập → bị chuyển hướng
      về trang đăng nhập, không xem được dữ liệu.
- [ ] Đăng xuất thành công → sau đó không còn truy cập được dữ liệu cho đến khi đăng
      nhập lại.
- [ ] Mỗi tài khoản có một trường vai trò (role) gắn kèm, dù Phase 1 chỉ dùng một vai
      trò duy nhất (admin).

## Ràng buộc & quyết định đã chốt liên quan

- Nơi lưu trữ dữ liệu: PostgreSQL (Supabase) — đã chốt với khách hàng.
- Nơi triển khai: Vercel — đã chốt với khách hàng.
- Nền tảng code: repo `notes-app` hiện có (Next.js) — đã chốt với khách hàng.
- Cơ chế xác thực cụ thể (nhà cung cấp, thư viện, luồng đăng nhập...) **do Tech Lead
  quyết định** khi thiết kế kỹ thuật.

## Ngoài phạm vi (Out of scope)

- Đăng ký tài khoản mới qua giao diện — tài khoản Phase 1 được tạo thủ công.
- Nhiều vai trò với logic phân quyền chi tiết khác nhau — Phase 1 chỉ cần trường role
  tồn tại sẵn, chưa cần áp dụng luật phân quyền phức tạp.
- Đăng nhập qua bên thứ ba (Google/SSO...).
- Xác thực hai lớp (2FA), captcha, hay các lớp bảo mật nâng cao khác.

## Câu hỏi mở cho Tech Lead

Nếu trong lúc thiết kế phát sinh nhu cầu vượt ngoài mục "Ngoài phạm vi" ở trên (ví dụ
cần thêm bảo mật nâng cao), đề xuất riêng để BA xác nhận lại với khách hàng trước khi
triển khai — không tự mở rộng phạm vi.

---

_Nguồn: tài liệu yêu cầu & timeline đầy đủ của Phase 1 "Notes Task" (App Quản Lý Task Medpro)._
