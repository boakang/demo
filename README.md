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
|- main.dart
|- core_app/
|- data_app/
|- view_app/
|- screens/
|- model_app/
|- widgets/
|- styles/
```

Mô tả thư mục và file chính:

- lib/main.dart: Điểm khởi chạy app, cấu hình MaterialApp, route và BlocProvider.

- lib/core_app/config/app_config.dart: Cấu hình chung của ứng dụng.
- lib/core_app/style/app_colors.dart: Khai báo màu dùng toàn app.
- lib/core_app/style/app_text_styles.dart: Khai báo text style dùng chung.
- lib/core_app/style/app_theme.dart: Theme tổng thể cho MaterialApp.
- lib/core_app/widgets/general_button.dart: Nút dùng lại cho nhiều màn hình.
- lib/core_app/widgets/general_text_field.dart: TextField dùng lại, thống nhất UI nhập liệu.
- lib/core_app/widgets/loading_view.dart: Widget hiển thị loading.
- lib/core_app/dialog/app_dialog.dart: Hộp thoại thông báo/lỗi dùng chung.
- lib/core_app/utilities/api_exception.dart: Định nghĩa lỗi API.
- lib/core_app/utilities/api_status_code_helper.dart: Xử lý và map mã trạng thái HTTP.
- lib/core_app/local_storage/local_storage_service.dart: Lưu trữ cục bộ.
- lib/core_app/service/auth_header_service.dart: Tạo header xác thực cho request.
- lib/core_app/language/app_locales.dart: Khai báo ngôn ngữ/locale.
- lib/core_app/formatter/no_leading_space_formatter.dart: Formatter chặn khoảng trắng đầu chuỗi.

- lib/data_app/url/app_urls.dart: Quản lý endpoint backend.
- lib/data_app/remote/api_client.dart: HTTP client nền tảng (GET/POST, parse response).
- lib/data_app/remote/demo_api_client.dart: API client cho luồng validate project và login.
- lib/data_app/repository/demo_repository.dart: Interface repository cho màn hình demo.
- lib/data_app/repository/auth_repository.dart: Repository triển khai gọi API auth.
- lib/data_app/model/demo_model.dart: Model kết quả chung cho validate/login.
- lib/data_app/model/login_request.dart: Model request đăng nhập.
- lib/data_app/model/login_response.dart: Model response đăng nhập.
- lib/data_app/model/validate_project_request.dart: Model request validate mã dự án.
- lib/data_app/model_map_json/demo_model_map_json.dart: Mapper JSON -> model kết quả.
- lib/data_app/model_body_request/demo_body_request_model.dart: Model body request dùng trong luồng demo.
- lib/data_app/model_body_request_map_json/demo_body_request_model_map_json.dart: Mapper model body request <-> JSON.
- lib/data_app/constant/app_constants.dart: Hằng số dùng trong lớp data.

- lib/view_app/demo/demo_form.dart: Màn hình/form demo chính của flow xác thực + đăng nhập.
- lib/view_app/demo/demo_screen.dart: Khung màn hình demo.
- lib/view_app/demo/bloc_demo/demo_event.dart: Định nghĩa event cho BLoC.
- lib/view_app/demo/bloc_demo/demo_state.dart: Định nghĩa state cho BLoC.
- lib/view_app/demo/bloc_demo/demo_bloc.dart: Xử lý event, gọi repository và emit state.

- lib/screens/validate_project_screen.dart: Màn hình nhập và kiểm tra mã dự án.
- lib/screens/login_screen.dart: Màn hình đăng nhập sau khi mã dự án hợp lệ.
- lib/screens/home_screen.dart: Màn hình kết quả/trạng thái sau đăng nhập.

- lib/model_app/widgets/status_panel.dart: Widget hiển thị trạng thái kết quả.
- lib/widgets/background_layout.dart: Layout nền dùng chung cho UI.
- lib/styles/: Nơi tổ chức style riêng của module (nếu có mở rộng).

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
