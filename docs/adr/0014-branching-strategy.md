# ADR-0014: Chiến lược nhánh — `main` + `develop`

- **Trạng thái:** Accepted
- **Ngày:** 2026-08-29
- **Liên quan:** Toàn Phase 1

## Bối cảnh

Repo hiện chỉ có một nhánh `main`, chưa có branch protection (`gh api
repos/xuantrong94/multi-apps/branches/main/protection` → 404 "Branch not protected",
kiểm tra 2026-08-29). Chưa kết nối Vercel (không có `.vercel/`, không có `vercel.json`).

BA doc (Artifact "Notes Task Phase 1", mục Timeline) chốt nhịp làm việc: mỗi phase (P1–P4)
kết thúc bằng **một buổi review để xác nhận trước khi bước sang phase kế tiếp** — tức là
việc trong tuần chỉ nên "chốt" (go-live) sau khi review, không phải ngay khi một task
merge xong.

## Quyết định

Dùng 2 nhánh dài hạn:

- **`main`** — production. Chỉ nhận code đã qua review cuối tuần (mốc M1–M4). Bật
  branch protection: bắt buộc merge qua Pull Request, không cho push thẳng.
- **`develop`** — nhánh tích hợp. Toàn bộ nhánh task (T0.1, T1, T2...) rẽ ra từ đây và PR
  ngược lại đây. Không bật protection (solo dev, cần linh hoạt commit nhanh).

Tại mỗi mốc review (M1 04/09, M2 11/09, M3 18/09, M4 25/09): mở PR `develop` → `main`,
merge sau khi tự review xong — đây chính là hành động "go-live" của phase đó.

## Lựa chọn khác đã cân nhắc

- **GitHub Flow (chỉ `main`, không có `develop`)** — bị loại: theo cơ chế Vercel (xem
  Bằng chứng), mỗi lần merge PR task thẳng vào `main` sẽ **tự động deploy lên production
  ngay lập tức**. Điều này mâu thuẫn với yêu cầu "review cuối tuần trước khi chốt phase"
  của BA doc — sẽ đẩy code chưa được review lên production giữa tuần.
- **Git Flow đầy đủ** (thêm `release/*`, `hotfix/*`) — bị loại: dư thừa cho dự án solo
  4 tuần, không có nhu cầu hotfix song song nhiều phiên bản production.

## Bằng chứng

- Vercel Docs (tra cứu web 2026-08-29, vercel.com/docs/git, vercel.com/docs/deployments/environments):
  "By default, pushing or merging changes into your production branch (commonly `main`)
  triggers a production deployment... Vercel updates your production domains to point to
  the new deployment, ensuring your users see the latest changes immediately." Đồng thời
  mỗi nhánh/PR khác đều tự có Preview Deployment riêng với URL ổn định — nghĩa là `develop`
  vẫn có URL preview riêng để xem trước khi go-live, không mất khả năng demo giữa tuần.
- Artifact "Notes Task Phase 1" (mục Timeline): "Mỗi phase kéo dài đúng một tuần làm việc
  và kết thúc bằng một buổi review để xác nhận trước khi bước sang phase kế tiếp."
- `gh api repos/xuantrong94/multi-apps/branches/main/protection` (2026-08-29): xác nhận
  chưa có protection nào tồn tại, không có rule nào bị ghi đè bởi quyết định này.

## Hệ quả

- Thêm một bước PR `develop → main` mỗi tuần (4 lần cho cả Phase 1) — chi phí thấp, đổi
  lại `main` luôn phản ánh đúng trạng thái đã được review, khớp mốc M1–M4.
- **Việc còn thiếu, cần bổ sung riêng:** khi tạo Vercel project (chưa có task nào trong
  [BACKLOG.md](../tasks/BACKLOG.md) hiện phụ trách việc này), phải set **Production
  Branch = `main`** trong Vercel Project Settings để khớp với chiến lược nhánh ở đây —
  nếu không chỉnh, Vercel mặc định coi nhánh đầu tiên đẩy lên là production và có thể lấy
  nhầm `develop`.
- Nhánh task (per T0.x/T1...) rẽ ra từ `develop`, không thuộc phạm vi quyết định này —
  xem quy ước đặt tên khi bắt đầu từng task cụ thể.

## Cập nhật 2026-08-29 — đổi default branch trên GitHub sang `develop`

Phát hiện khi kiểm tra quy trình: tính năng "Create a branch" của GitHub trên issue mặc
định lấy **default branch của repo** làm base — lúc đó default branch vẫn là `main`
(`gh repo view --json defaultBranchRef` → `main`), nghĩa là mọi nhánh task tạo qua nút đó
sẽ vô tình rẽ từ `main` thay vì `develop`, trừ khi tự tay đổi dropdown mỗi lần — cùng dạng
rủi ro "bước thủ công dễ quên" như vụ title tiếng Việt ở
[ADR-0015](0015-github-facing-titles-english.md).

**Đã sửa:** `gh repo edit xuantrong94/multi-apps --default-branch develop`. Từ nay
"Create a branch" trên issue tự động base đúng `develop`, không cần nhớ chọn tay.
`main` vẫn giữ vai trò production (protection không đổi); default branch trên GitHub chỉ
ảnh hưởng nhánh gợi ý mặc định khi tạo branch/PR mới và nhánh hiển thị khi vào repo — không
ảnh hưởng cấu hình Production Branch riêng của Vercel (vẫn phải set tay = `main` khi tạo
Vercel project, xem mục trên).
