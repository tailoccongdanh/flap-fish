# 🐟 Flap Fish - Cá Vượt Thác

**Game di động Android** - Một con cá hồi vượt qua thác nước, vật cản nguy hiểm, cá ăn thịt để về nơi sinh sản.

## 🎮 Cách Chơi

- **Nhấn** (tap) màn hình để cá **bơi lên**
- **Tránh** bom 💣, chông gai 🔴, dòng nước ❄️
- **Ăn cá xanh** 💚 để tăng máu (HP)
- **Tránh cá đỏ** (cá ăn thịt) ❌
- **Không va chạm** quá 3 lần = Game Over
- **Mục tiêu**: Bơi cao nhất có thể

## 🌍 Hỗ Trợ Đa Ngôn Ngữ

Game hỗ trợ **3 ngôn ngữ**:
- 🇻🇳 **Tiếng Việt** (mặc định)
- 🇬🇧 **Tiếng Anh** (cho nước ngoài)
- 🇨🇳 **Tiếng Trung** (Trung Quốc, Đài Loan)

**Cách chọn:**
1. Mở game lần đầu
2. Hiển thị màn hình chọn ngôn ngữ
3. Tap vào nút ngôn ngữ muốn dùng
4. Game bắt đầu với ngôn ngữ đã chọn
5. Lần tiếp theo, tự động nhớ lựa chọn

**Thêm ngôn ngữ mới:** Xem file `MULTI_LANGUAGE_GUIDE.md`

## 📋 Yêu cầu

Để build APK từ GitHub, bạn cần:
- Tài khoản **GitHub** (miễn phí)
- **Git** cài trên máy (tải từ git-scm.com)

## 🚀 Hướng Dẫn Build

### Bước 1: Tạo Repository GitHub

1. Vào **github.com** → đăng nhập
2. Click **+** → **New repository**
3. Tên: `flap-fish` (hay tên khác tùy bạn)
4. Chọn **Public** (để dễ dàng)
5. Click **Create repository**

### Bước 2: Clone/Setup Trên Máy

Mở **Terminal/Command Prompt** (Windows: Win+R → cmd):

```bash
# Tạo folder
mkdir flap-fish
cd flap-fish

# Copy file project này vào folder
# (hoặc mình sẽ hướng dẫn chi tiết sau)

# Setup Git
git init
git add .
git commit -m "Initial commit - Flap Fish game"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/flap-fish.git
git push -u origin main
```

**Thay `YOUR_USERNAME` bằng username GitHub của bạn**

### Bước 3: Chạy GitHub Actions Build

1. Vào repo GitHub của bạn
2. Click tab **Actions**
3. Chọn workflow **Build APK**
4. Click **Run workflow** (nếu cần)
5. Đợi build xong (2-3 phút)

### Bước 4: Tải APK Về

1. Vào tab **Actions** → build gần nhất
2. Kéo xuống phần **Artifacts**
3. Click **flap-fish-apk** → tải file `.apk`

### Bước 5: Cài Trên Điện Thoại Android

#### Cách 1: Qua cáp USB
1. Kết nối điện thoại Android với máy tính qua USB
2. Chọn **Transfer files** trên điện thoại
3. Copy file `.apk` vào thư mục `Download`
4. Ngắt kết nối, mở file Manager trên điện thoại
5. Tìm file `.apk` → tap để cài đặt
6. Cho phép cài app từ file không xác định (nếu được hỏi)

#### Cách 2: Qua chia sẻ file (nhanh nhất)
1. Email file `.apk` cho chính mình
2. Mở email trên điện thoại
3. Tap file → chọn **Install**

## 🛠️ Chỉnh Sửa Game

Muốn thay đổi gì? Chỉnh file `scenes/main.gd`:

- **Độ khó**: Thay `spawn_interval`, `enemy_spawn_interval`, `gravity`
- **Màu sắc**: Thay `Color.BLUE`, `Color.RED`, `Color.GREEN`
- **HP tối đa**: Thay `max_hp = 3`
- **Lực nhảy**: Thay `jump_force = -300`

Rồi push lên GitHub:
```bash
git add .
git commit -m "Update game mechanics"
git push
```

→ GitHub Actions tự động build APK mới!

## 📦 Cấu Trúc Folder

```
flap-fish/
├── project.godot          # Config Godot
├── scenes/
│   ├── main.tscn          # Main scene
│   └── main.gd            # Game logic
├── .github/workflows/
│   └── build.yml          # GitHub Actions
├── README.md              # File này
└── .gitignore             # Bỏ qua khi push
```

## ⚠️ Ghi Chú

- **Build APK lần đầu** có thể mất **3-5 phút** trên GitHub
- Nếu build **fail**, kiểm tra **Workflow logs** (tab Actions → build → Logs)
- APK chỉ giữ được **30 ngày**, sau đó xóa tự động
- Để build nhiều lần, bạn có thể tạo **release** trên GitHub

## 🎨 Tuỳ Chỉnh Thêm

### Đổi Tên Game
Sửa file `project.godot`:
```
config/name="Flap Fish"  # Đổi tên ở đây
```

### Đổi Icon
Thay `icon.svg` bằng hình của bạn (512x512px)

### Đổi Tên Package (Android)
Sửa `build.yml`:
```
package/unique_name="com.example.flapfish"  # Đổi đây
```

## 📞 Hỗ Trợ

Nếu gặp lỗi:
1. Kiểm tra **Git config** chính xác
2. Xem **GitHub Actions logs** chi tiết
3. Đảm bảo file `.gd` không có lỗi cú pháp

---

**Chúc bạn vui với Flap Fish!** 🐟✨

Bình luận hoặc issue nếu cần giúp đỡ thêm.
