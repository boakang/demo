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

Tác dụng chính trong project:
- Tách logic nghiệp vụ khỏi UI, màn hình gọn và dễ bảo trì.
- Quản lý trạng thái thống nhất cho các trạng thái loading, success, error.
- Dễ mở rộng flow xác thực mã dự án -> đăng nhập mà không phải sửa nhiều màn hình.
- Dễ test phần nghiệp vụ theo event/state.

Nếu không dùng BLoC:
- Logic validate/login dễ bị nhúng trực tiếp vào UI, code khó đọc hơn.
- Dễ lặp code gọi API và xử lý lỗi giữa các màn hình.
- Khó kiểm soát state khi có nhiều thao tác async.
- Việc test và mở rộng tính năng sẽ tốn công hơn.

## 3. Cấu trúc mã nguồn (rút gọn)
```text
lib/
|-- main.dart                                      // Điểm khởi chạy app, route, BlocProvider
|
|-- core_app
|   |-- config/app_config.dart                     // Cấu hình chung
|   |-- style
|   |   |-- app_colors.dart                        // Màu dùng toàn app
|   |   |-- app_text_styles.dart                   // Text style dùng chung
|   |   `-- app_theme.dart                         // Theme tổng thể
|   |-- widgets
|   |   |-- general_button.dart                    // Nút dùng lại
|   |   |-- general_text_field.dart                // Ô nhập liệu dùng lại
|   |   `-- loading_view.dart                      // Hiển thị loading
|   |-- utilities/api_exception.dart               // Chuẩn hóa lỗi API
|   |-- local_storage/local_storage_service.dart   // Lưu trữ cục bộ
|   |-- service/auth_header_service.dart           // Hỗ trợ tạo auth header từ token local
|   `-- formatter/no_leading_space_formatter.dart  // Chặn khoảng trắng đầu chuỗi
|
|-- data_app
|   |-- url/app_urls.dart                          // Quản lý endpoint
|   |-- remote
|   |   |-- api_client.dart                        // HTTP client nền tảng
|   |   `-- demo_api_client.dart                   // API validate project/login
|   |-- repository
|   |   `-- auth_repository.dart                   // Repository auth dùng cho BLoC
|   |-- model/demo_model.dart                      // Model kết quả login/validate
|   |-- model_map_json/demo_model_map_json.dart    // Mapper JSON response -> model
|   |-- model_body_request/demo_body_request_model.dart
|   |                                              // Model request body cho login
|   |-- model_body_request_map_json/demo_body_request_model_map_json.dart
|   |                                              // Mapper model request <-> JSON
|   `-- constant/                                  // (đang để trống)
|
|-- view_app/demo
|   |-- demo_form.dart                             // Form chính của flow validate/login
|   `-- bloc_demo
|       |-- demo_event.dart                        // Event BLoC
|       |-- demo_state.dart                        // State BLoC
|       `-- demo_bloc.dart                         // Xử lý event, gọi repository, emit state
|
|-- screens
|   |-- validate_project_screen.dart               // Màn hình nhập mã dự án
|   |-- login_screen.dart                          // Màn hình đăng nhập
|   `-- home_screen.dart                           // Màn hình sau đăng nhập
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
- Backend tham chiếu được triển khai trong HQSOFT.UserApi.
- Mobile app đang gọi đúng 2 endpoint trên theo flow validate-project -> login.

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
