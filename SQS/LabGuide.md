## **Các bước thực hiện Labs**
### **Bước 1: Đăng nhập vào AWS Management Console**
1. Click vào button ![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/openconsolebutton.png "image_tooltip")
2. Cửa sổ mới mở lên và điều hướng tới trang đăng nhập vào AWS Management Console
* Trường **Account ID** để mặc định, không thay đổi trường này.
* Copy trường **Thông tin User** và **Mật khẩu** và điền tương ứng vào ô **IAM Username** và **Password** trên giao diện của Console
3. Khi bạn Login được vào Console, hãy chắc chắn bạn đang ở AWS Region là **US East (N. Virginia) us-east-1**.

### Bước 2: Tạo một S3 bucket
1. Xác nhận là bạn đang ở N.Virginia Region (Region khác sẽ không có quyền tạo tài nguyên).
2. Tìm dịch vụ S3 trên thanh tìm kiếm
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_1.png "image_tooltip")
3. Trên trang dịch vụ S3, click vào **Create bucket** button.
* Cấu hình S3 bucket như sau:
  * **Bucket name** : _**mysqslambda-bucket-2023xxxxxx**_
  * > Ở đây, để không bị lỗi khi tạo Bucket phần xxxx các bạn có thể tuỳ ý điền để tránh trùng với tên Bucket khác
  * **Region**: Chọn **US East (N. Virginia)**
  * **Object ownership**: Chọn **ACLs disabled (recommended)**
  * **Bucket settings for Block Public Access**: Bỏ check tại ô **_Block all public access_** checkbox.
  * Check ô xác nhận **_I acknowledge that the current setting..._**
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_3.png "image_tooltip")  
  * Bỏ các option còn lại mặc định và click nút **Create Bucket**.
  * Xác nhận Bucket được tạo ra thành công.
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_5.png "image_tooltip") 

### Bước 3: Tạo một SQS queue
1. Tìm kiếm dịch vụ SQS trên thanh tìm kiếm. Chọn **Simple Queue Service**
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_6.png "image_tooltip")
2. Tại màn hình dịch vụ SQS, click nút **Create queue**.
3. Chi tiết cấu hình SQS:
    * **select type**: Chọn **_Standard queue_**
    * **Name** : Điền **_cloudnut-sqs-lambda**
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_7_2.png "image_tooltip")
    * Để các thông số còn lại mặc định sau đó click **Create queue** button
    * Xác nhận SQS queue được tạo ra thành công
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_7_3.png "image_tooltip")

### Bước 4: Tạo một Lambda function
1. Tìm kiếm dịch vụ Lambda trên thanh tìm kiếm. Chọn **Lambda Function**
2. Tại màn hình dịch vụ Lambda, click **Create a function button**
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_8.png "image_tooltip")
3. Cấu hình Lambda function
    * Lựa chọn **_Author from scratch_**
    * **Function name**: Điền _my_sqs_lambda_
    * **Runtime**: Chọn _Python 3.9_
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_9.png "image_tooltip")
    * **Permissions**: Click vào **Change default execution role**
    * **Existing role**: Chọn **_Lambda_SQS_Role_** từ list danh sách.
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_10_1.png "image_tooltip")
    * Click vào **Create funtion** button để hoàn thành việc cấu hình Lambda funtion.
    * Xác nhận là Lambda funtion được tạo ra thành công
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_12.png "image_tooltip")




5. Trong màn hình của **Lambda Function (my_sqs_lambda)**, chọn tab **Code** sau đó click double vào file **lambda_function.py** để mở editor.
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_13_0.png "image_tooltip")
6. Trong phần code của file **lambda_function.py** thay thế bởi đọan code sau
```python
import json
import boto3
def lambda_handler(event, context):
    sqs_msg = json.loads(event['Records'][0]['body'])
    print("SQS Message : ", sqs_msg)
    bucket_name = "YOUR_BUCKET_NAME"
    try:
        s3Client = boto3.client("s3", region_name= "us-east-1")
        Response = s3Client.put_object(Bucket= bucket_name, Key= "Message.json", Body= json.dumps(sqs_msg))
        print("S3 upload success!")
        return {
            "status" : 200,
            "body" : "S3 upload success"
        }
    except Exception as e:
        print("Client connection to S3 failed caused by", e)
        return{
            "status" : 500,
            "body" : "S3 upload failed"
        }
```
> Lưu ý: Thay giá trị của biến **bucket_name** thành tên của Bucket được tạo trong bước 2.
* Ví dụ: ![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_13.png "image_tooltip")
7. Lưu lại code và click **Deploy** button.
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_13_1.png "image_tooltip")

### Bước 5: Thêm trigger cho Lambda Function
1. Trên giao diện của Lambda Dashboard, chọn Tab **Configuration**, chọn **Triggers** và click **Add Trigger** button.
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_14.png "image_tooltip")
2. Chọn SQS Queue tạo ở bước 3. Sau đó tick vào checkbox **Active Trigger** và click Save button.
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_18.png "image_tooltip")

### Bước 6: Kiểm tra hoạt động.



1. Chuyển hướng sang dịch vụ SQS. Chọn **cloudnut-sqslambda** queue, sau đó chọn **Send and receive messages** Tab
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_22_0.png "image_tooltip")

2. Trong ô **Massage body** paste vào nội dung sau:
    * Message body : Enter _{"Name" : "Paul", "Course" : "Amazon Web Services", "Cost" : "$20"}_
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_22.png "image_tooltip")
3. Sau đó click **Send massage** button để đẩy bản tin vào trong Queue.
4. Chuyển hướng sang S3 Bucket tạo ở bước số 2.
5. Xác nhận trong bucket có File Object có tên là **Message.json** được đẩy từ **Lambda function** sang.
6. Mở file bằng cách click vào file hoặc tải về kiểm tra lại nội dung.
![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/image_24.png "image_tooltip")

# **Hoàn thành bài Lab**
1. Bạn đã hoàn thành đăng nhập vào AWS Management Console. 
2. Bạn đã hoàn thành tạo một S3 bucket.
3. Bạn đã hoàn thành tạo một SQS queue.
4. Bạn đã hoàn thành tạo một Lambda function.
5. Bạn đã hoàn thành thêm trigger cho Lambda Function.
6. Bạn đã hoàn thành kiểm tra luồng hoạt động hệ thống.

# **Kết thúc Lab**
1. Đăng xuất khỏi AWS Account.
2. Đánh giá và Review bài Lab
3. Khi đã hoàn thành, click vào button ![alt_text](https://cdn.cloudnut.vn/aws/sqs-intro/endlab.png "image_tooltip")  trên giao diện Lab của CloudNut.