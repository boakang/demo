# MobileApp

## 1. Mục tiêu
Ứng dụng Flutter demo luồng đăng nhập theo mã dự án:
- Xác thực mã dự án.
- Đăng nhập tài khoản.
- Vào màn hình trạng thái sau đăng nhập.

## 2. Công nghệ chính
- Flutter + Dart.
- State management: BLoC.
- Gọi API: HTTP.
- Nền tảng: Android/iOS.

### BLoC trong project này
BLoC là lớp trung gian giữa UI và API. UI chỉ gửi sự kiện, BLoC xử lý logic và dữ liệu, rồi trả state để màn hình tự cập nhật loading, success hoặc error.

## 3. Cấu trúc mã nguồn (rút gọn)
```text
lib/
|- main.dart                # Điểm khởi chạy
|- core_app/                # Cấu hình và thành phần dùng chung
|- data_app/                # API, repository, model, endpoint
|- view_app/, screens/      # UI và luồng nghiệp vụ
```

## 4. Tích hợp backend
- Backend tham chiếu: HQSOFT.UserApi.
- Base URL cho Android Emulator: http://10.0.2.2:5064.
- Endpoint đang dùng:
  - POST /api/user/validate-project
  - POST /api/user/login

### 1) POST /api/user/validate-project
Kiểm tra mã dự án trước khi cho phép sang bước đăng nhập.

Request body:

```json
{
  "projectCode": "TCJFOOD"
}
```

Kết quả thành công:

```json
{
  "success": true,
  "message": "Project code is valid.",
  "data": {}
}
```

Lỗi thường gặp:
- 400: payload không hợp lệ hoặc mã dự án không đúng.

### 2) POST /api/user/login
Xác thực tài khoản sau khi mã dự án hợp lệ.

Request body:

```json
{
  "username": "S03",
  "password": "Admin@123",
  "projectCode": "TCJFOOD"
}
```

Kết quả thành công:

```json
{
  "success": true,
  "message": "Login successfully.",
  "data": {
    "userId": "U001",
    "userName": "S03",
    "token": "..."
  }
}
```

Lỗi thường gặp:
- 400: thiếu trường bắt buộc.
- 401: sai username, password hoặc projectCode.

Ghi chú:
- Backend demo hiện dùng logic hard-code cho 2 route trên.
- Chưa đưa logic validate-project/login xuống stored procedure.

## 5. Trạng thái hiện tại
- Đã chuyển cấu hình về local API cho emulator.
- Luồng mobile đã map đúng 2 endpoint validate-project và login.
- Payload đăng nhập đã đồng bộ với backend.

## 5.1 Các nội dung đã đạt (tóm tắt)
- Đã triển khai đầy đủ BLoC cho luồng đăng nhập.
- Đã hoàn thiện flow 2 bước: xác thực mã dự án, sau đó đăng nhập.
- Màn hình demo đã chạy được luồng nhập mã dự án -> đăng nhập -> phản hồi kết quả.

## 6. Cách chạy nhanh
1. Chạy backend HQSOFT.UserApi ở profile HTTP (http://localhost:5064).
2. Mở Swagger để kiểm tra API sẵn sàng.
3. Chạy Flutter app trên Android Emulator.

## 7. Hướng mở rộng để sẵn sàng production
- Đưa logic validate-project/login vào database hoặc service.
- Tách cấu hình theo môi trường dev/staging/prod.
- Bổ sung integration test cho luồng đăng nhập.

## 8. Màn hình
- Màn hình nhập mã dự án

![Hình Nhập mã dự án](https://github.com/boakang/demo/blob/main/Screenshot%202026-04-13%20111036.png)

- Màn hình đăng nhập
  
![Hình Đăng nhập](https://github.com/boakang/demo/blob/main/Screenshot%202026-04-13%20140338.png)
