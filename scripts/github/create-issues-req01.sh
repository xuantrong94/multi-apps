#!/usr/bin/env bash
# Tạo issue GitHub cho T0 (scaffolding) + REQ-01 từ docs/tasks/BACKLOG.md.
# Mẫu tham khảo khi tạo issue cho REQ-02+ — xem quy trình ở docs/tasks/GITHUB-SETUP.md
# mục "Quy trình tạo issue cho một REQ mới". Copy file này, đổi tên create-issues-reqXX.sh,
# sửa REPO không đổi, MS (milestone), LABEL_REQ, và mảng task bên dưới.
set -e

REPO="xuantrong94/multi-apps"
MS="P1 · System Access"

OUT="$(mktemp -d)"
NUMS="$OUT/numbers.tsv"
: > "$NUMS"

create_issue () {
  local id="$1" title="$2" body_file="$3" label="$4"
  local url num
  url=$(gh issue create --repo "$REPO" \
    --title "[$id] $title" \
    --body-file "$body_file" \
    --label "$label" \
    --milestone "$MS" \
    --assignee "@me")
  num=$(basename "$url")
  echo -e "${id}\t${num}\t${title}" | tee -a "$NUMS"
}

# ---------- T0.1 ----------
cat > "$OUT/T0.1.md" <<'EOF'
Chuyển sang cấu trúc `src/`, tạo `features/`, `components/`, `lib/`, `types/`.

## Definition of Done
- [ ] `src/app`, `src/features`, `src/components`, `src/lib`, `src/types` tồn tại
- [ ] Path alias `@/*` → `src/*` trong `tsconfig.json`
- [ ] `pnpm dev` chạy route `/` cũ không lỗi

**Tài liệu:** TD-00 (Kiến trúc & thư viện) · ADR-0005 (Cấu trúc `src/` + feature)
EOF
create_issue "T0.1" "Switch to src/ structure" "$OUT/T0.1.md" "scaffolding"

# ---------- T0.2 ----------
cat > "$OUT/T0.2.md" <<'EOF'
Cài các thư viện core dùng chung cho toàn bộ Phase 1.

## Definition of Done
- [ ] `package.json` có `@supabase/supabase-js`, `@supabase/ssr`, `zod`, `date-fns`, `@dnd-kit/core`, `@dnd-kit/sortable`
- [ ] `pnpm install` sạch, không lỗi peer dependency

**Tài liệu:** TD-00 · ADR-0001, ADR-0004, ADR-0007, ADR-0008
EOF
create_issue "T0.2" "Install core dependencies" "$OUT/T0.2.md" "scaffolding"

# ---------- T0.3 ----------
cat > "$OUT/T0.3.md" <<'EOF'
Khởi tạo shadcn/ui cho bộ component dùng chung.

## Definition of Done
- [ ] `components.json` tồn tại ở root
- [ ] `src/components/ui/` có ít nhất 1 component mẫu (vd `button`) render được

**Tài liệu:** TD-00 · ADR-0006
EOF
create_issue "T0.3" "Set up shadcn/ui" "$OUT/T0.3.md" "scaffolding"

# ---------- T0.4 ----------
cat > "$OUT/T0.4.md" <<'EOF'
Khởi tạo Vitest cho unit test logic rủi ro cao.

## Definition of Done
- [ ] `vitest.config.ts` tồn tại
- [ ] Script `"test": "vitest run"` trong `package.json`
- [ ] `pnpm test` chạy được (kể cả khi chưa có test file nào)

**Tài liệu:** TD-00 · ADR-0012
EOF
create_issue "T0.4" "Set up Vitest" "$OUT/T0.4.md" "scaffolding"

# ---------- T0.5 ----------
cat > "$OUT/T0.5.md" <<'EOF'
Cài đặt khung Resend cho REQ-04 (chưa cần API key thật).

## Definition of Done
- [ ] `resend` có trong `dependencies`
- [ ] `.env.example` có dòng `RESEND_API_KEY=`

**Tài liệu:** TD-00 · ADR-0009
EOF
create_issue "T0.5" "Add Resend scaffold" "$OUT/T0.5.md" "scaffolding"

# ---------- T1 ----------
cat > "$OUT/T1.md" <<'EOF'
Khởi tạo Supabase project và cấu hình biến môi trường.

## Definition of Done
- [ ] Project Supabase được tạo
- [ ] URL / anon key / service key thêm vào `.env.local` và Vercel env
- [ ] `.env.example` cập nhật (không chứa giá trị thật)

**Phụ thuộc:** T0
**Tài liệu:** TD-01 · ADR-0001
EOF
create_issue "T1" "Set up Supabase project" "$OUT/T1.md" "req:REQ-01"

# ---------- T2 ----------
cat > "$OUT/T2.md" <<'EOF'
Cấu hình Supabase client cho Next.js App Router.

## Definition of Done
- [ ] `src/lib/supabase/client.ts` (browser) tạo xong
- [ ] `src/lib/supabase/server.ts` (server, dùng `cookies()`) tạo xong

**Phụ thuộc:** T1
**Tài liệu:** TD-01 · ADR-0001
EOF
create_issue "T2" "Configure Supabase client" "$OUT/T2.md" "req:REQ-01"

# ---------- T3 ----------
cat > "$OUT/T3.md" <<'EOF'
Migration bảng `profiles` + trường role.

## Definition of Done
- [ ] Enum `role` tạo trong migration
- [ ] Bảng `profiles` (FK → `auth.users.id`) tạo trong migration
- [ ] Trigger tự tạo `profiles` row khi có user mới

**Phụ thuộc:** T1 — Đáp ứng: AC5
**Tài liệu:** TD-01 · ADR-0003
EOF
create_issue "T3" "Add profiles table + role migration" "$OUT/T3.md" "req:REQ-01"

# ---------- T4 ----------
cat > "$OUT/T4.md" <<'EOF'
Seed tài khoản admin Phase 1.

## Definition of Done
- [ ] Tài khoản Phase 1 tạo thủ công (không qua UI đăng ký)
- [ ] `role = admin` được gán
- [ ] Email xác nhận sẵn (không bị chặn ở bước confirm email khi test)

**Phụ thuộc:** T3 — Đáp ứng: AC5
**Tài liệu:** TD-01
EOF
create_issue "T4" "Seed admin account" "$OUT/T4.md" "req:REQ-01"

# ---------- T5 ----------
cat > "$OUT/T5.md" <<'EOF'
UI trang đăng nhập.

## Definition of Done
- [ ] `app/login/page.tsx` có form email/password

**Phụ thuộc:** T2 — Đáp ứng: AC1, AC2
**Tài liệu:** TD-01
EOF
create_issue "T5" "Build login page UI" "$OUT/T5.md" "req:REQ-01"

# ---------- T6 ----------
cat > "$OUT/T6.md" <<'EOF'
Server Action `login`.

## Definition of Done
- [ ] Gọi `supabase.auth.signInWithPassword`
- [ ] Redirect vào trang task list khi thành công

**Phụ thuộc:** T2, T5 — Đáp ứng: AC1
**Tài liệu:** TD-01
EOF
create_issue "T6" "Add login Server Action" "$OUT/T6.md" "req:REQ-01"

# ---------- T7 ----------
cat > "$OUT/T7.md" <<'EOF'
Hiển thị lỗi đăng nhập rõ ràng trên form.

## Definition of Done
- [ ] `useActionState` trả thông báo lỗi rõ ràng khi sai tài khoản/mật khẩu

**Phụ thuộc:** T6 — Đáp ứng: AC2
**Tài liệu:** TD-01
EOF
create_issue "T7" "Show login error messages" "$OUT/T7.md" "req:REQ-01"

# ---------- T8 ----------
cat > "$OUT/T8.md" <<'EOF'
`proxy.ts` — optimistic route protection.

## Definition of Done
- [ ] Redirect chưa đăng nhập → `/login`
- [ ] Đã đăng nhập mà vào `/login` → redirect vào trang task list

**Phụ thuộc:** T2 — Đáp ứng: AC3
**Tài liệu:** TD-01 · ADR-0002
EOF
create_issue "T8" "Add proxy.ts route protection" "$OUT/T8.md" "req:REQ-01"

# ---------- T9 ----------
cat > "$OUT/T9.md" <<'EOF'
Data Access Layer (`src/features/auth/dal.ts`).

## Definition of Done
- [ ] `verifySession()` / `getUser()` dùng `cache()`
- [ ] Là điểm bắt buộc cho mọi truy vấn dữ liệu task (nền cho REQ-02 → REQ-05)

**Phụ thuộc:** T2 — Đáp ứng: AC3
**Tài liệu:** TD-01 · ADR-0002
EOF
create_issue "T9" "Add Data Access Layer (DAL)" "$OUT/T9.md" "req:REQ-01"

# ---------- T10 ----------
cat > "$OUT/T10.md" <<'EOF'
Server Action `logout`.

## Definition of Done
- [ ] `supabase.auth.signOut()`
- [ ] Xoá session, redirect `/login`

**Phụ thuộc:** T6 — Đáp ứng: AC4
**Tài liệu:** TD-01
EOF
create_issue "T10" "Add logout Server Action" "$OUT/T10.md" "req:REQ-01"

# ---------- T11 ----------
cat > "$OUT/T11.md" <<'EOF'
Trang task list (placeholder) — điểm đến sau đăng nhập.

## Definition of Done
- [ ] `app/(protected)/tasks/page.tsx` dùng DAL lấy user
- [ ] Có nút đăng xuất
- [ ] UI đầy đủ thuộc REQ-02+, ở đây chỉ đủ để test luồng đăng nhập/đăng xuất

**Phụ thuộc:** T9, T10 — Đáp ứng: AC1, AC4
**Tài liệu:** TD-01
EOF
create_issue "T11" "Build task list placeholder page" "$OUT/T11.md" "req:REQ-01"

# ---------- T12 ----------
cat > "$OUT/T12.md" <<'EOF'
Kiểm thử theo checklist Acceptance Criteria (thủ công).

## Definition of Done
- [ ] Đăng nhập thành công bằng tài khoản hợp lệ → vào trang task list
- [ ] Đăng nhập sai thông tin → thông báo lỗi rõ ràng, không vào được hệ thống
- [ ] Truy cập trực tiếp URL bất kỳ khi chưa đăng nhập → bị chuyển hướng về `/login`
- [ ] Đăng xuất thành công → sau đó không còn truy cập được dữ liệu
- [ ] Tài khoản hiển thị đúng trường role (`admin`)

**Phụ thuộc:** T1–T11 — Đáp ứng: AC1–AC5 (toàn bộ REQ-01)
**Tài liệu:** REQ-01 · TD-01
EOF
create_issue "T12" "Run manual QA against acceptance criteria" "$OUT/T12.md" "req:REQ-01"

echo "== DONE =="
cat "$NUMS"

# ---------- Epic issues (chạy tay sau khi có số issue thật, xem ví dụ) ----------
# gh issue create --repo "$REPO" --title "[Epic] T0 — Project scaffolding" \
#   --body "- [ ] #1\n- [ ] #2\n- [ ] #3\n- [ ] #4\n- [ ] #5" \
#   --label "scaffolding" --milestone "$MS" --assignee "@me"
#
# gh issue create --repo "$REPO" --title "[Epic] REQ-01 — User authentication" \
#   --body "- [ ] #6\n...\n- [ ] #17" \
#   --label "req:REQ-01" --milestone "$MS" --assignee "@me"
