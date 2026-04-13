# MobileApp

## 1. Mục tiêu
Ứng dụng Flutter phục vụ demo luồng đăng nhập theo mã dự án:
- Bước 1: Xác thực mã dự án.
- Bước 2: Đăng nhập tài khoản.
- Bước 3: Vào màn hình trạng thái sau đăng nhập.

## 2. Công nghệ chính
- Flutter + Dart.
- Quản lý state: BLoC.
- Gọi API: HTTP.
- Nền tảng: Android/iOS.

## 3. Cấu trúc mã nguồn (rút gọn)
```text
lib/
|- main.dart                # Điểm khởi chạy
|- core_app/                # Cấu hình, giao diện dùng chung
|- data_app/
|  |- remote/               # API client
|  |- repository/           # Trung gian giữa UI và API
|  |- model*/               # Request/response models
|  |- url/                  # Quản lý endpoint
|- view_app/, screens/      # UI và luồng nghiệp vụ
```

## 4. Tích hợp backend
- Backend tham chiếu: HQSOFT.UserApi.
- Base URL cho Android Emulator: http://10.0.2.2:5064.
- Endpoint mobile đang sử dụng:
  - POST /api/user/validate-project.
  - POST /api/user/login.

### Giải thích chi tiết 2 route chính

#### 1) POST /api/user/validate-project
- Mục đích: kiểm tra mã dự án người dùng nhập có hợp lệ trước khi cho phép sang bước đăng nhập.
- Request body:

```json
{
  "projectCode": "TCJFOOD"
}
```

- Kết quả thành công (HTTP 200):

```json
{
  "success": true,
  "message": "Project code is valid.",
  "data": {}
}
```

- Kết quả lỗi thường gặp:
  - HTTP 400: payload không hợp lệ hoặc mã dự án không đúng.

#### 2) POST /api/user/login
- Mục đích: xác thực tài khoản sau khi mã dự án đã hợp lệ.
- Request body:

```json
{
  "username": "S03",
  "password": "Admin@123",
  "projectCode": "TCJFOOD"
}
```

- Kết quả thành công (HTTP 200):

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

- Kết quả lỗi thường gặp:
  - HTTP 400: payload thiếu trường bắt buộc.
  - HTTP 401: sai username/password/projectCode.

Ghi chú nghiệp vụ hiện tại:
- Backend đang dùng logic hard-code cho 2 route trên trong môi trường demo.
- Chưa gọi stored procedure cho validate-project/login.

## 5. Trạng thái hiện tại
- Đã bỏ cấu hình cũ trỏ đến domain ngoài, chuyển về local API cho emulator.
- Luồng mobile đã map đúng endpoint validate-project/login.
- Lưu ý: backend hiện vẫn dùng logic hard-code cho 2 API trên, chưa gọi stored procedure.

## 5.1 Các nội dung đã đạt (tóm tắt)
- Đã triển khai đầy đủ mô hình BLoC cho luồng đăng nhập (bloc, event, state).
- Đã hoàn thiện luồng 2 bước: xác thực mã dự án trước, sau đó đăng nhập tài khoản.
- Đã kết nối đúng 2 API backend chính:
  - POST /api/user/validate-project.
  - POST /api/user/login.
- Payload đăng nhập đã đồng bộ với backend (username, password, projectCode).
- Màn hình demo đã chạy được luồng nhập mã dự án -> đăng nhập -> phản hồi kết quả.

## 6. Cách chạy nhanh
1. Chạy backend HQSOFT.UserApi ở profile HTTP (http://localhost:5064).
2. Mở Swagger để kiểm tra API sẵn sàng.
3. Chạy Flutter app trên Android Emulator.

## 7. Hướng mở rộng để sẵn sàng production
- Đưa logic validate-project/login vào database (stored procedure hoặc service).
- Tách cấu hình theo môi trường (dev/staging/prod).
- Bổ sung integration test cho luồng đăng nhập.

## 8. Màn hình
- Màn hình nhập mã dự án

![Hình Nhập mã dự án](https://github.com/boakang/demo/blob/main/Screenshot%202026-04-13%20111036.png)

- Màn hình đăng nhập
  
![Hình Đăng nhập](https://github.com/boakang/demo/blob/main/Screenshot%202026-04-13%20110652.png)
