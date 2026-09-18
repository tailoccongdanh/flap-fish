# 📖 Hướng Dẫn Chi Tiết - Build APK từ GitHub

**Đây là hướng dẫn từng bước cho người mới bắt đầu**

---

## 🔧 Bước 1: Cài Đặt Git (1 lần duy nhất)

### Windows:
1. Vào **git-scm.com**
2. Click **Download for Windows**
3. Chạy file `.exe` → Next hết
4. Mở **Command Prompt** (Win+R → cmd → Enter)
5. Gõ: `git --version` → Enter
6. Nếu hiện phiên bản = cài thành công ✅

### Mac:
1. Mở **Terminal** (Cmd+Space → Terminal)
2. Gõ: `git --version` → Enter
3. Nếu Mac hỏi cài xcode → Chọn **Install** → Chờ xong

### Linux:
```bash
sudo apt update
sudo apt install git
```

---

## 👤 Bước 2: Tạo Tài Khoản GitHub

1. Vào **github.com**
2. Click **Sign up** → Nhập:
   - Email (gmail/outlook/bất kỳ)
   - Mật khẩu
   - Username (tên đăng nhập, vd: `binmosa`)
3. Xác minh email → Xong

---

## 📁 Bước 3: Tạo Repository Trống

1. Đăng nhập GitHub
2. Click **+** góc phải → **New repository**
3. Nhập:
   - **Repository name**: `flap-fish`
   - **Description** (tùy chọn): `Salmon game`
   - **Visibility**: Chọn **Public**
   - **Initialize**: KHÔNG check gì
4. Click **Create repository** → Xong

Bây giờ bạn sẽ thấy trang có dòng text dạng:
```
…or push an existing repository from the command line
```

**Giữ trang này, chúng ta sẽ dùng**

---

## 💻 Bước 4: Setup Trên Máy Tính

### Phần 1: Download Project File

Bạn nhận được file `flap-fish-project.zip` từ mình:

1. **Windows**: Giải nén (`Right click → Extract All`)
2. **Mac/Linux**: Double-click → tự giải nén

### Phần 2: Mở Terminal Trong Folder

**Windows:**
1. Mở file Manager → Vào folder `flap-fish`
2. **Shift + Right click** → **Open PowerShell here**
   (Nếu không thấy, tìm "Open Command Prompt here")

**Mac:**
1. Mở Finder → Vào folder `flap-fish`
2. Right click → **New Terminal at Folder**

**Linux:**
```bash
cd /path/to/flap-fish
```

### Phần 3: Setup Git trong Folder

Trong Terminal, gõ từng dòng (Enter sau mỗi dòng):

```bash
git config user.name "Tên của bạn"
git config user.email "email@gmail.com"
```

Ví dụ:
```bash
git config user.name "Bin Mosa"
git config user.email "binmosa@gmail.com"
```

---

## 🚀 Bước 5: Push Code Lên GitHub

### Lần đầu tiên:

Trong Terminal, gõ lần lượt:

```bash
git init
git add .
git commit -m "Initial commit - Flap Fish game"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/flap-fish.git
git push -u origin main
```

**QUAN TRỌNG**: Thay `YOUR_USERNAME` bằng username GitHub của bạn!

Ví dụ nếu username là `binmosa`:
```bash
git remote add origin https://github.com/binmosa/flap-fish.git
```

**Lần đầu push**: GitHub hỏi username/password → Nhập (hoặc tạo token nếu được hỏi)

Khi xong sẽ hiện dòng:
```
 * [new branch]      main -> main
```
✅ Push thành công!

### Lần tiếp theo (nếu chỉnh sửa):

```bash
git add .
git commit -m "Thay đổi gì đó"
git push
```

---

## ⚙️ Bước 6: GitHub Actions Build Tự Động

Sau khi push xong:

1. Vào **github.com** → Repo của bạn
2. Click tab **Actions**
3. Chờ workflow **Build APK** chạy xong (2-3 phút)
4. Nếu thấy ✅ xanh = build thành công!

---

## 📥 Bước 7: Tải APK Về

1. Trong tab **Actions** → click workflow gần nhất
2. Kéo xuống phần **Artifacts** (dưới cùng)
3. Click **flap-fish-apk** → file tự tải về
4. Giải nén (nếu là `.zip`) → tìm file `.apk`

---

## 📱 Bước 8: Cài APK Trên Điện Thoại

### Cách 1: USB (Android)

1. Kết nối điện thoại với máy tính qua USB
2. Chọn **Transfer files** trên điện thoại
3. Copy file `.apk` vào thư mục `Download`
4. Trên điện thoại: Mở **File Manager** → **Download** → tap file `.apk`
5. Chọn **Install** → Xong

### Cách 2: Email (nhanh)

1. Email file `.apk` cho chính mình
2. Mở email trên điện thoại
3. Tap file → **Install** → Xong

### Cách 3: Bluetooth (nếu có)

1. Gửi file `.apk` qua Bluetooth
2. Mở file trên điện thoại → **Install**

---

## 🎮 Bắt Đầu Chơi!

Tìm app **Flap Fish** trên điện thoại → Tap → Chơi!

**Nhấn** (tap) để cá bơi lên, tránh bom 💣 và cá đỏ ❌

---

## 🔧 Thay Đổi Game (Nâng Cao)

Muốn chỉnh sửa game logic? Sửa file `scenes/main.gd`:

**Ví dụ:**

```gdscript
var gravity: float = 400  # Tăng = rơi nhanh hơn
var jump_force: float = -300  # Tăng = nhảy cao hơn
var max_hp: int = 3  # Tăng = khó hơn
```

Rồi push lên lại:
```bash
git add .
git commit -m "Update gravity"
git push
```

→ GitHub tự động build APK mới!

---

## ❌ Khắc Phục Lỗi

### Lỗi: "Authentication failed"
→ Bạn nhập sai username/password GitHub
→ Xóa saved password (Windows: Credential Manager) → Thử lại

### Lỗi: "fatal: not a git repository"
→ Bạn chưa gõ `git init`
→ Chạy lại từ đầu

### Lỗi: "The remote origin already exists"
→ Bạn đã chạy `git remote add origin` rồi
→ Gõ: `git remote remove origin` → Rồi chạy lại

### Build fail trên GitHub Actions
→ Vào **Actions** → Workflow → **Logs** → Tìm lỗi
→ Thường là lỗi cú pháp GDScript

---

## 📞 Cần Giúp?

Nếu stuck ở đâu:
1. **Kiểm tra lại từng bước** (dễ bỏ qua)
2. **Copy-paste lệnh đúng** (không gõ tay, dễ sai)
3. **Google lỗi** (copy dòng lỗi vào Google)

---

**Chúc bạn thành công!** 🚀🐟

