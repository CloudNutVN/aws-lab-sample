## **Chi tiết bài Lab**
1. Bài Lab hướng dẫn triển khai hệ thông đơn gian bao gồm thành phần như SQS, Lambda và S3 bucket.
2. Hệ thống nhận bản tin (message) từ SQS sau đó trigger lambda function để xử lý bản tin này và lưu trữ tại S3 bucket. 
3. Thời gian: **60 phút**
4. AWS Region: **US East (N. Virginia) us-east-1**


## **Giới thiệu lý thuyết**
### Giới thiệu về dịch vụ Amazon Simple Queue Service (SQS)
* SQS là dịch vụ ra đời đầu tiên trong danh sách các dịch vụ của AWS.
* SQS là dịch vụ cung cấp Queue service, phục vụ cho các bài toán hệ thống phân toán, loose-coupling khi các thành phần trao đổi với nhau qua Queue.
* SQS là dịch vụ ổn định, dễ dàng quản quản lý (AWS Managed Service) và có khả năng co giãn (scaling) dễ dàng.
* SQS đảm bảo mỗi bản tin sẽ được chuyển đi xử lý ít nhất 1 lần. Đảm sqsbảo tính tin cậy cao cho hệ thống.

## **Sơ đồ kiến trúc**
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/overview.png "image_tooltip")

**Mô tả luồng hoạt động:**
1. Lab User sẽ đẩy một bản tin theo format (message) vào SQS.
2. Khi message được đẩy vào SQS sẽ trigger một Lambda Function.
3. Lambda Function thực hiện xử lý bản tin, sau đó lưu file kết quả vào Amazon S3
4. Lab User có thể kiểm tra file kết quả trên S3
## Chi tiết các bước
1. Đăng nhập vào  AWS Management Console. 
2. Tạo một S3 bucket.
3. Tạo một SQS queue.
4. Tạo một Lambda function.
5. Thêm trigger cho Lambda Function.
6. Kiểm tra hoạt động.


## **Khởi tạo môi trường Lab**
1. Để khởi tạo môi trường Lab, Click button ![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/truycaplab.png "image_tooltip")
2. Đợi hệ thống khởi tạo môi trường Lab. Thời gian khởi tạo kéo dài 1-2 phút
3. Khi bài Lab được khởi tạo thành công, người dùng sẽ được cung cấp thông tin truy cập vào AWS bao gồm **IAM Username**, **Password**, **Access Key**, **Secret Access Key** và các tài nguyên (source code nếu có).

> Lưu ý : Tại một thời điểm chỉ có thể chạy 1 bài Lab. Muốn chạy bài Lab khác thì phải kết thúc bài Lab đang ở trạng thái chạy (Running)
