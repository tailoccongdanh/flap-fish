# ⚡ Quick Start - 5 Phút

**Nhanh nhất để có APK và chơi ngay**

---

## 1️⃣ Tạo GitHub Repo (3 phút)

```
1. github.com → Sign up (nếu chưa có)
2. Click + → New repository
3. Tên: "flap-fish"
4. Public
5. Create repository
```

---

## 2️⃣ Push Code (1 phút)

Mở Terminal/Command Prompt tại folder này:

```bash
git init
git add .
git commit -m "Flap Fish game"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/flap-fish.git
git push -u origin main
```

**Thay `YOUR_USERNAME` bằng username GitHub bạn**

---

## 3️⃣ Build (GitHub Actions làm 3-5 phút)

1. github.com → Repo của bạn
2. Tab **Actions**
3. Chờ workflow **Build APK** xanh ✅

---

## 4️⃣ Tải APK (30 giây)

1. **Actions** → Workflow gần nhất
2. **Artifacts** → Download `flap-fish-apk`
3. Giải nén → `app-release.apk` là file cần dùng

---

## 5️⃣ Cài Lên Điện Thoại (1 phút)

**Email cho chính mình** (dễ nhất):
- Gửi file `.apk` via email
- Mở trên điện thoại → Install

**Hoặc USB:**
- Copy `.apk` vào Download
- Mở File Manager → Install

---

## 🎮 Chơi!

Tìm **Flap Fish** → Tap để bơi lên → Tránh bom ❌ → High score!

---

## 📝 Chỉnh Sửa Game

Sửa `scenes/main.gd` → Push lên → GitHub tự build APK mới

Ví dụ:
```gdscript
var gravity: float = 500  # Tăng = rơi nhanh hơn
var jump_force: float = -400  # Tăng = nhảy cao hơn
```

---

## 🆘 Gặp Vấn Đề?

- Lỗi Git? → Xem `INSTALL.md`
- Muốn build local? → Xem `BUILD_LOCALLY.md`
- Chi tiết game? → Xem `README.md`

---

**Done! 🐟✨**

