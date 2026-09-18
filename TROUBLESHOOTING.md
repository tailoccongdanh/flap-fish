# 🔧 Khắc Phục Lỗi - Flap Fish Build

**GitHub Actions workflow bị Failure?** Đây là cách fix.

---

## ❌ Lỗi: Workflow Failure Đỏ

**Nguyên nhân phổ biến:**
1. File config Godot không hợp lệ
2. GDScript syntax error
3. Godot version mismatch
4. Workflow YAML config sai

---

## 🔴 Nếu 3 Workflow Cùng Fail

Có thể đã fix ở file cập nhật. **Làm theo các bước:**

### Bước 1: Xóa Workflow Cũ

1. GitHub repo → Tab **Actions**
2. Xóa tất cả workflow runs cũ (click **...** → Delete)
3. Có thể giữ lại để xem log, nhưng không ảnh hưởng

### Bước 2: Pull Code Mới Nhất

Nếu đã push code cũ lên GitHub, pull code mới từ mình:

```bash
git fetch origin
git reset --hard origin/main
```

Hoặc **download ZIP mới** từ mình (có fix sẵn)

### Bước 3: Push Lên GitHub

```bash
git add .
git commit -m "Fix Godot workflow build"
git push
```

→ GitHub Actions tự động chạy workflow mới

### Bước 4: Chờ Build

1. Vào tab **Actions**
2. Chờ workflow chạy (1-2 phút)
3. Nếu **✅ Xanh** = OK, download APK
4. Nếu **🔴 Đỏ** = xem Logs chi tiết (scroll down)

---

## 📋 Xem Log Chi Tiết

1. GitHub repo → **Actions** tab
2. Click vào workflow run
3. Tìm dòng **"Build"** hoặc **"Export"**
4. Scroll để xem error message cụ thể

**Lỗi hay gặp:**

```
Error: Invalid project.godot
→ Fix: Kiểm tra file project.godot không có syntax error

Error: Cannot find main scene
→ Fix: Đảm bảo scenes/main.tscn tồn tại

Error: GDScript parse error
→ Fix: Kiểm tra file main.gd không có typo
```

---

## 🔍 Cách Fix Local (Trên Máy)

Nếu muốn test trước khi push:

### 1️⃣ Cài Godot (nếu chưa)

Download từ **godotengine.org** → Godot 4.1.3

### 2️⃣ Mở Project

```bash
godot --path .  # Chạy từ folder project
```

Godot editor → Nếu project load được = OK ✅

### 3️⃣ Kiểm Tra GDScript

**Editor** → **Debug** → **GDScript** → Xem error

Nếu thấy dòng đỏ = có syntax error → Fix nó

### 4️⃣ Export Test

**File** → **Export** → **Android** (nếu cài)

Hoặc bỏ qua bước này, GitHub làm hộ

---

## 🛠️ Fix File Thủ Công

Nếu không chắc lỗi ở đâu, fix file này:

### `project.godot` - Phải tối giản

```
[gd_project]
config_version=5
name="Flap Fish"

[application]
config/name="Flap Fish"
config/version="1.0.0"
run/main_scene="res://scenes/main.tscn"
```

✅ Không cần icon, không cần rendering settings phức tạp

### `export_presets.cfg` - Cơ bản

```
[preset.0]
name="Android"
platform="Android"
runnable=true
export_filter="all_resources"
export_path="build/app-release.apk"
```

✅ Đơn giản, không cần gradle settings phức tạp

### `scenes/main.gd` - Kiểm Tra Syntax

```gdscript
# Không dùng:
var test: int = "string"  # ❌ Type mismatch

# Dùng:
var test: String = "hello"  # ✅ Đúng type
```

---

## 🆘 Nếu Vẫn Fail

**Gửi cho mình:**
1. Screenshot workflow logs (phần error)
2. Repo link
3. Khi nào fail (lần đầu? sau update?)

→ Mình fix trực tiếp code cho bạn

---

## ✅ Dấu Hiệu Build Thành Công

Workflow chạy xong sẽ thấy:
- ✅ Tất cả steps xanh (chứ không đỏ)
- 📥 Tab **Artifacts** xuất hiện **flap-fish-apk**
- 📦 Bên trong có file `.apk`

→ Download APK → Cài điện thoại → Chơi! 🎮

---

## 🔄 Workflow Chạy Khi Nào?

Workflow tự động chạy:
- ✅ Khi `git push` lên main/master
- ✅ Khi tạo Pull Request
- ❌ Không chạy nếu chỉ sửa file `.md`

**Trigger Push:**
```bash
git add .
git commit -m "Update game"
git push
```

→ Workflow tự chạy trong 1-2 phút

---

## 📊 Workflow Status

| Icon | Ý Nghĩa |
|------|---------|
| ⏳ | Đang chạy |
| ✅ | Thành công |
| 🔴 | Thất bại |
| ⊘ | Bị hủy |

---

## 🚀 Bước Tiếp

1. **Push code lên GitHub**
2. **Chờ workflow chạy** (1-2 phút)
3. **Kiểm tra status** (xanh hay đỏ?)
4. **Nếu xanh** → Download APK → Chơi!
5. **Nếu đỏ** → Xem Logs → Gửi cho mình

---

**Cần giúp? Gửi link repo + screenshot error → mình fix ngay!** 🚀

