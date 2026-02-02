# Genshin Impact Auto Redeem Codes

Script tự động nhập codes Genshin Impact từ database của HashBlen.

## Tính năng

- ✨ Tự động lấy danh sách codes mới nhất
- 🎮 Tự động nhập codes cho tài khoản Genshin Impact
- 📊 Báo cáo chi tiết kết quả nhập code
- ⏰ Hỗ trợ chạy tự động theo lịch với Cron (macOS/Linux)

## Yêu cầu

- macOS hoặc Linux
- Bash shell
- curl (đã có sẵn trên macOS/Linux)
- Tài khoản Genshin Impact

## Cài đặt

1. Clone repository này:
```bash
git clone https://github.com/yourusername/genshin_auto_redem.git
cd genshin_auto_redem
```

2. Chỉnh sửa file `genshin_redeem.sh` và cập nhật thông tin của bạn:
```bash
GENSHIN_UID="YOUR_UID"           # UID của bạn trong game
REGION="os_asia"                  # Region của bạn (os_asia, os_usa, os_euro, os_cht)
COOKIE="YOUR_COOKIE"              # Cookie từ Hoyoverse
```

### Cách lấy Cookie

1. Truy cập https://genshin.hoyoverse.com/
2. Đăng nhập vào tài khoản của bạn
3. Mở Developer Tools (F12)
4. Vào tab **Application** > **Cookies**
5. Copy các giá trị:
   - `cookie_token_v2`
   - `account_mid_v2`
   - `account_id_v2`
6. Ghép lại theo format: `cookie_token_v2=...; account_mid_v2=...; account_id_v2=...`

3. Cấp quyền thực thi cho script:
```bash
chmod +x genshin_redeem.sh
```

## Sử dụng

### Chạy thủ công

```bash
./genshin_redeem.sh
```

### Thiết lập tự động chạy hàng ngày (Cron)

Script sẽ tự động chạy mỗi ngày vào **11:00 sáng** để nhập codes mới.

**Bước 1:** Mở crontab editor:
```bash
crontab -e
```

**Bước 2:** Thêm dòng sau (thay đổi đường dẫn nếu cần):
```
0 11 * * * /bin/bash /Users/nguyenhuy/Documents/GitHub/genshin_auto_redem/genshin_redeem.sh >> /Users/nguyenhuy/Documents/GitHub/genshin_auto_redem/genshin_redeem.log 2>&1
```

Hoặc dùng lệnh nhanh:
```bash
(crontab -l 2>/dev/null; echo "0 11 * * * /bin/bash $(pwd)/genshin_redeem.sh >> $(pwd)/genshin_redeem.log 2>&1") | crontab -
```

**Lưu ý macOS:** Cần cấp quyền Full Disk Access cho `/usr/sbin/cron`:
1. Mở **System Settings** → **Privacy & Security** → **Full Disk Access**
2. Thêm `/usr/sbin/cron` vào danh sách

## Quản lý Cron

### Xem crontab hiện tại
```bash
crontab -l
```

### Chỉnh sửa crontab
```bash
crontab -e
```

### Xóa toàn bộ crontab
```bash
crontab -r
```

### Xem log
```bash
tail -f genshin_redeem.log
```

### Thay đổi giờ chạy

Format cron: `phút giờ ngày tháng thứ`

Ví dụ:
- `0 8 * * *` - Chạy lúc 8:00 sáng hàng ngày
- `30 14 * * *` - Chạy lúc 2:30 chiều hàng ngày
- `0 */6 * * *` - Chạy mỗi 6 giờ
- `0 11 * * 1` - Chạy lúc 11:00 vào mỗi thứ 2

## Kết quả

Script sẽ hiển thị:
- ✅ **Nhập thành công**: Codes được nhập thành công
- ⚠️ **Đã nhập trước đó**: Codes đã được sử dụng
- ❌ **Thất bại/Hết hạn**: Codes không hợp lệ hoặc đã hết hạn

Ví dụ output:
```
Dang lay danh sach codes...
Tim thay 4 codes cho Genshin Impact

Dang nhap code: P3GXX56W3VG9
   Da nhap roi: This Redemption Code is already in use

Dang nhap code: TSUKINOARIKAE
   Thanh cong! Redemption Successful!

Tong ket:
   Nhap thanh cong: 1
   Da nhap truoc do: 3
   That bai/het han: 0
```

## Nguồn Codes

Codes được lấy từ: https://db.hashblen.com/codes

## Lưu ý

- ⚠️ **Không chia sẻ Cookie** của bạn cho bất kỳ ai
- 🔄 Cookie có thể hết hạn, cần cập nhật định kỳ
- 📝 Kiểm tra log thường xuyên để đảm bảo script chạy đúng
- ⏱️ Script có delay 5.5 giây giữa các lần nhập để tránh spam API
- 🔒 Trên macOS, cần cấp quyền Full Disk Access cho `/usr/sbin/cron`

## License

MIT License

## Đóng góp

Mọi đóng góp đều được chào đón! Hãy tạo Pull Request hoặc Issue nếu bạn có đề xuất.
