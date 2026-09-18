# 🏗️ Build APK Trên Máy Tính Local (Không Cần GitHub)

**Cách này cho bạn muốn build ngay mà không chờ GitHub Actions**

---

## ⚠️ Lưu Ý Trước

Cách này phức tạp hơn vì cần cài:
- **Godot Engine 4.1.3** (100MB)
- **Android SDK** (5-10GB) 
- **Java Development Kit (JDK)**

**Nên dùng GitHub Actions (dễ hơn)** - chỉ cần push code, GitHub tự build!

---

## 📦 Bước 1: Cài Godot Engine

### Windows/Mac/Linux:

1. Vào **godotengine.org**
2. Tải **Godot 4.1.3** (Standard - LTS)
3. Giải nén → Chạy `Godot.exe` (hoặc tương đương)
4. Chọn **Project** → **New Project** → Bỏ qua (đã có project)

---

## ☕ Bước 2: Cài Java Development Kit (JDK)

Cần JDK 11+ để build Android:

### Windows:
1. Vào **adoptium.net** (recommended) hoặc **oracle.com**
2. Tải **Eclipse Temurin JDK 11** (Windows x64)
3. Chạy `.msi` → Next hết
4. Verify: Mở Command Prompt → `java -version` → Enter
   Nếu thấy phiên bản = ok ✅

### Mac:
```bash
brew install openjdk@11
```

### Linux:
```bash
sudo apt install openjdk-11-jdk
```

---

## 🤖 Bước 3: Cài Android SDK

**Cách dễ nhất - dùng Android Studio:**

1. Vào **developer.android.com/studio**
2. Tải **Android Studio** (cả bộ)
3. Cài đặt, chạy Android Studio
4. **SDK Manager** → Install:
   - **SDK Platforms**: Android 13, 14
   - **SDK Tools**: 
     - Android SDK Build-Tools 34.0.0
     - Android Emulator
     - Platform-Tools

**Nơi cài (ghi nhớ đường dẫn):**
- **Windows**: `C:\Users\YOUR_NAME\AppData\Local\Android\Sdk`
- **Mac**: `~/Library/Android/sdk`
- **Linux**: `~/Android/Sdk`

---

## 🔧 Bước 4: Config Godot cho Android

1. Mở **Godot** → Project này (`flap-fish-project`)
2. **Project** → **Project Settings** → **Export**
3. Click **Add Preset** → **Android**
4. Trong **Android Preset**:
   - **Paths**:
     - Java SDK Path: `/path/to/jdk` (vd: `C:\Program Files\Eclipse Adoptium\jdk-11.0.15.1-hotspot`)
     - Android SDK Path: `/path/to/android/sdk`
     - Android NDK Path: (để trống, không cần)
   - **Options**:
     - Min SDK: 21
     - Target SDK: 33
     - Package: `com.flapfish.game`
     - App Name: `Flap Fish`

5. Click **Export** → Chọn nơi lưu (vd: `bin/flapfish-release.apk`)
6. Chờ build (5-10 phút)

---

## 🎯 Bước 5: Build APK

### Cách 1: Export từ Godot UI (đơn giản)

1. **Project** → **Export**
2. **Android Preset** → Click **Export**
3. Chọn nơi lưu file `.apk`
4. Chờ xong → APK sẵn sàng ✅

### Cách 2: Export từ Command Line (nhanh)

```bash
godot --headless --export-release "Android" bin/flapfish-release.apk
```

---

## 📱 Bước 6: Cài APK Trên Điện Thoại

Sau khi có file `.apk`:

**Cách 1: USB**
```bash
adb install bin/flapfish-release.apk
```

(Cần cài ADB - có kèm Android SDK)

**Cách 2: Copy tay**
1. Kết nối USB
2. Copy file `.apk` vào `Download`
3. Mở trên điện thoại → **Install**

---

## ❌ Troubleshooting

### Lỗi: "Java SDK not found"
→ Kiểm tra đường dẫn JDK chính xác
→ Gõ `java -version` xác nhận

### Lỗi: "Android SDK not found"
→ Kiểm tra đường dẫn Android SDK
→ Đảm bảo cài đủ Platform & Build-Tools

### Lỗi: "Build failed"
→ Kiểm tra **Godot Output** → Scroll tìm lỗi
→ Thường do lỗi GDScript script

---

## 💡 Tại Sao Dùng GitHub Actions Thay Vì Build Local?

| Tiêu Chí | GitHub Actions | Build Local |
|----------|---|---|
| Cài đặt | Không | 15GB+ (JDK + SDK) |
| Thời gian | 3-5 phút | 10-20 phút |
| Dễ dàng | ✅ Rất | ❌ Phức tạp |
| Không cần máy mạnh | ✅ | ❌ Cần máy khỏe |

**Khuyến nghị**: Dùng **GitHub Actions** (dễ + nhanh)

---

**Cần giúp?** Hỏi trực tiếp! 🚀

