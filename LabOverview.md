# **Chi tiết bài Lab**
1. Bài Lab hướng dẫn chạy một **Container Nginx** trong cụm **ECS Cluster**.
2. Bạn sẽ được thực hành tương tác với **ECS Cluster** và nắm các khái niệm về **Task Definition** và **Task**
3. Thời gian: **60 phút**
4. AWS Region: **US East (N. Virginia) us-east-1**

# **Sơ đồ kiến trúc**
![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/overview.png "image_tooltip")

# **Chi tiết các bước**
1. Đăng nhập vào AWS Management Console (Giao diện tương tác dạng Web UI của AWS)
2. Tạo mới Key pair cho các EC2 instances trong ECS cluster
3. Tạo ECS cluster
4. Tạo Task definitions
5. Tạo Service và Nginx container trong cluster
6. Truy cập vào Service Nginx trong cluster
7. Truy cập vào EC2 Instance và kiểm chứng Docker commands


# **Khởi tạo môi trường Lab**
1. Để khởi tạo môi trường Lab, Click button ![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/truycaplab.png "image_tooltip")
2. Đợi hệ thống khởi tạo môi trường Lab. Thời gian khởi tạo kéo dài 1-2 phút
3. Khi bài Lab được khởi tạo thành công, người dùng sẽ được cung cấp thông tin truy cập vào AWS bao gồm **IAM Username**, **Password**, **Access Key**, **Secret Access Key** và các tài nguyên (source code nếu có).

> Lưu ý : Tại một thời điểm chỉ có thể chạy 1 bài Lab. Muốn chạy bài Lab khác thì phải kết thúc bài Lab đang ở trạng thái chạy (Running)