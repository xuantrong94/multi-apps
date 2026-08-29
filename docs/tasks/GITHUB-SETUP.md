# Hướng dẫn cấu hình GitHub Issues + Projects (Kanban)

> Quy ước cụ thể cho quyết định ở [ADR-0013](../adr/0013-github-issues-projects.md).
> Repo: `xuantrong94/multi-apps` (public). Nguồn task: [BACKLOG.md](BACKLOG.md).

## 1. Label

Không dùng label để lặp lại thông tin Phase (đã có Milestone lo việc đó). Chỉ thêm label
để lọc theo REQ và đánh dấu nhóm task hạ tầng:

| Label         | Màu              | Dùng cho                              |
| ------------- | ---------------- | ------------------------------------- |
| `scaffolding` | `#8892A0` (xám)  | T0.1 – T0.5                           |
| `req:REQ-01`  | `#3452D1` (xanh) | T1 – T12                              |
| `req:REQ-02`  | `#3452D1`        | Task của REQ-02 (lên sau, theo TD-02) |
| `req:REQ-03`  | `#3452D1`        | Task của REQ-03 (theo TD-03)          |
| `req:REQ-04`  | `#3452D1`        | Task của REQ-04 (theo TD-04)          |
| `req:REQ-05`  | `#3452D1`        | Task của REQ-05 (theo TD-04)          |

Giữ nguyên các label mặc định của GitHub (`bug`, `enhancement`, `documentation`...) —
dùng bình thường cho việc phát sinh ngoài kế hoạch.

## 2. Milestone (= Phase, theo đúng Gantt trong BA doc)

| Milestone                  | Due date   | Yêu cầu đáp ứng |
| -------------------------- | ---------- | --------------- |
| `P1 · Truy cập hệ thống`   | 2026-09-04 | T0, REQ-01      |
| `P2 · Quản lý Task`        | 2026-09-11 | REQ-02          |
| `P3 · Theo dõi trạng thái` | 2026-09-18 | REQ-03          |
| `P4 · Cảnh báo & báo cáo`  | 2026-09-25 | REQ-04, REQ-05  |

## 3. Quy ước Issue

- **Tiêu đề:** `[T0.1] Chuyển sang cấu trúc src/` — giữ nguyên mã task từ BACKLOG.md để
  dễ đối chiếu ngược.
- **Nội dung (body):** mô tả ngắn + checklist DoD (copy từ cột DoD trong BACKLOG.md) +
  link tới TD/ADR liên quan. Ví dụ:

  ```markdown
  Chuyển sang cấu trúc `src/`, tạo `features/`, `components/`, `lib/`, `types/`.

  ## Definition of Done

  - [ ] `src/app`, `src/features`, `src/components`, `src/lib`, `src/types` tồn tại
  - [ ] Path alias `@/*` → `src/*` trong `tsconfig.json`
  - [ ] `pnpm dev` chạy route `/` cũ không lỗi

  Xem: [TD-00](../tech-design/TD-00-kien-truc-va-thu-vien.md), [ADR-0005](../adr/0005-src-feature-structure.md)
  ```

- **Label:** `scaffolding` (T0) hoặc `req:REQ-01` (T1–T12).
- **Milestone:** `P1 · Truy cập hệ thống` cho toàn bộ T0 + T1–T12.
- **Assignee:** Kyle.

### Epic issue (tùy chọn nhưng khuyến nghị)

Tạo thêm 1 issue "tổng" mỗi REQ, nội dung là checklist tham chiếu tới các issue con bằng
`#<số issue>` — GitHub tự hiển thị progress bar (x/12 done) trên issue tổng:

```markdown
## REQ-01 — Đăng nhập hệ thống

- [ ] #2 [T1] Khởi tạo Supabase project
- [ ] #3 [T2] Cấu hình Supabase client
      ...
```

## 4. GitHub Project (v2) — board Kanban

### Field

| Field             | Loại          | Giá trị                                                |
| ----------------- | ------------- | ------------------------------------------------------ |
| `Status` (có sẵn) | Single select | `Backlog`, `Ready`, `In Progress`, `In Review`, `Done` |
| `Estimate`        | Number        | Ngày công — lấy từ ước tính trong TD-00/TD-01          |

Không cần thêm field `Phase` riêng — Project (v2) nhóm/lọc trực tiếp theo Milestone của
issue.

### View

1. **Kanban** — Board view, group theo `Status`. Đây là view làm việc hàng ngày.
2. **Theo Phase** — Board hoặc Table view, group theo `Milestone`. Dùng khi review cuối
   tuần (đối chiếu với mốc M1–M4 trong BA doc).

### Workflow tự động (Project Settings → Workflows)

- `Item added to project` → set `Status` = `Backlog`.
- `Item closed` → set `Status` = `Done`.
- `Item reopened` → set `Status` = `Backlog`.
- (Tùy chọn) `Auto-add to project`: mọi issue có label `scaffolding` hoặc `req:*` trong
  repo `multi-apps` tự động được thêm vào Project.

### Cách dựng

**Qua web UI** (không cần cấp thêm quyền, làm được ngay):
`github.com/xuantrong94/multi-apps` → tab **Projects** → **New project** → chọn
**Board** → cấu hình field/view như trên.

**Qua `gh` CLI** (nhanh hơn nếu tạo nhiều item, nhưng cần thêm quyền): token hiện tại
thiếu scope `read:project`/`project`. Kyle cần tự chạy (thao tác cấp quyền OAuth,
Claude không chạy thay được):

```bash
gh auth refresh -s project
```

Sau khi refresh xong, báo lại để Claude tiếp tục tạo Project + field + view qua
`gh project create` / `gh project field-create` / `gh project item-add`.

## 5. Nhánh (branch)

Chi tiết quyết định & bằng chứng: [ADR-0014](../adr/0014-branching-strategy.md).

- `main` — production. Đã bật protection: bắt buộc qua Pull Request (0 approval bắt
  buộc, phù hợp solo dev), không cho force-push, không cho xoá nhánh.
- `develop` — nhánh tích hợp, không protection, tất cả nhánh task rẽ ra từ đây và PR
  ngược lại đây.
- Cuối mỗi phase (mốc M1–M4): PR `develop → main` = hành động go-live của phase đó.
- Quy ước đặt tên nhánh task (`feature/T0.1-...` hay theo issue number...) sẽ chốt khi
  bắt đầu task đầu tiên — chưa nằm trong phạm vi thiết lập này.
- **Việc còn thiếu:** khi tạo Vercel project, phải set Production Branch = `main` trong
  Project Settings — chưa có task nào trong BACKLOG.md phụ trách việc tạo Vercel project.

## 6. Đồng bộ với BACKLOG.md

Sau khi issue được tạo cho một task, **không cập nhật trạng thái trong `BACKLOG.md`
nữa** — GitHub Issue/Project là nguồn sự thật duy nhất về trạng thái từ thời điểm đó
(tránh 2 nơi track song song, dễ lệch). `BACKLOG.md` giữ nguyên làm bản ghi kế hoạch gốc.
