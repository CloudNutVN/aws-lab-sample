# **Các bước thực hiện Labs**
### **Bước 1: Đăng nhập vào AWS Management Console**
1. Click vào button ![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/openconsolebutton.png "image_tooltip")
2. Cửa sổ mới mở lên và điều hướng tới trang đăng nhập vào AWS Management Console
* Trường **Account ID** để mặt đinh, không thay đổi trường này.
* Copy trường **Thông tin User** và **Mật khẩu** và điền tương ứng vào ô **IAM Username** và **Password** trên giao diện của Console
3. Khi bạn Login được vào Console, hãy chắc chắn bạn đang ở AWS Region là **US East (N. Virginia) us-east-1**.

### **Bước 2: Tạo mới Key pair cho các EC2 instances trong ECS cluster**

1. Xác nhận Region hiện tại là N. Virginia. Tìm kiếm dịch vụ EC2 trên thanh tìm kiếm sau đó lựa chọn dịch vụ EC2.
![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/searchec2.png "image_tooltip")
2. Trên giao diện dịch vụ EC2, lựa chọn mục **Key pairs** và click vào button **Create key pair**
![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_1.png "image_tooltip")
3. Điền các thông tin như sau:
    * Name: _cloudnut-kp_
    * Key pair type : RSA
    * Private key file format: pem (Linux & Mac Users) or ppk (Windows users)
    * Các tuỳ chọn khác để mặt định.
    * Click **Create key pair** button để tạo key pair.

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_2.png "image_tooltip")
> Note: **key pair** được sử dụng để truy cập vào EC2 Instance sử dụng giao thức SSH

### **Bước 3: Tạo ECS cluster**

1. Xác nhận bạn đang ở N. Virginia Region. Trong ô tìm kiếm, tìm dịch vụ **ECS**

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/searchecs.png "image_tooltip")
3. Trong màn hình dịch vụ ECS lựa chọn mục **Clusters** và click button **Create cluster**.

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_3.png "image_tooltip")
4. Thông số cluster:
   * Cluster name : _**cloudnut**_
   * VPC: Sử dụng _**Default VPC**_
   * Subnets: Lựa chọn tất cả các Subnets

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_4.png "image_tooltip")

* Trong phần Infrastructure:
    * Tick **Amazon EC2 Instances** checkbox:
        * Auto Scaling group (ASG): Chọn **_Create new ASG_**
        * Operating System/Architecture: Chọn **_Amazon Linux 2_**
        * EC2 instance type: Chọn **_t2.micro_**
        * Desired capacity : 
            * Minimum : **_1_**
            * Maximum : _**2**_
        * SSH Key pair: Chọn **_cloudnut-kp_**

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_5.png "image_tooltip")

5. Giữ các thông số còn lại mặc định và click **Create** button.
6. **cloudnut ECS cluster** sẽ mất khoảng 3-5 phút để tạo. 

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_6.png "image_tooltip")

### **Bước 4: Tạo Task definitions**

* Trong bước này bạn sẽ tạo một **Task definitions**
> Khái niệm **Task definitions**
> * **Task definitions** sử dụng để thiết kế và tạo ra các **Tasks**.
> * **Task** là đơn vị trong Cluster dùng để thực hiện xử lý tính toán Logic của ứng dụng, dịch vụ triển khai trên ECS cluster.
> * Mỗi **Task definitions** sẽ định nghĩa thông tin của một hay nhiều **Containers**.


1. Trong màn hình dịch vụ ECS, chọn mục **Task defitions**
2. Click chọn **Create new task definitions**.

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_8.png "image_tooltip")

3. Cấu hình Task definition:
   * Task definition family: _**ecs-lab**_ 
   * Trong phần **Container - 1**
     * Name: **_nginx_**
     * Image URL: **_nginx:1.25_**
     * Container port: **_80_**
     * Protocol: **_TCP_**
     * Port name: **_nginx-80-tcp_**
     * App protocol: **_HTTP_**

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_9.png "image_tooltip")
4. Click on Next Button
5. Cấu hình Environment : 
    * App Environment : Xoá _**AWS Fargate**_ và chọn **_Amazon EC2 Instances_**
    * Task size :
        * CPU: **_.25 vCPU_**
        * Memory: **_.5 GB_**
        > Ý nghĩa: **.25 vCPU** ~ 250 Milicore vCPU,  **.5 GB** ~ 500 MB Memory

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_10.png "image_tooltip")

6. Các tuỳ chọn để mặc định và click **Next** button.
7. Review lại các thông số click **Create** button.
8. Task definition **ecs-lab** được tạo thành công.

### **Bước 5: Tạo Service và Nginx container trong ECS cluster**

> **Khái niệm Service**
> * Service là một đối tượng được quản lý bởi ECS giúp đảm bảo số lượng **instances (Task)** của một **Task definition**.
> * Service cho phép định nghĩa trạng thái của **Task**, tự động thay thế, scaling và khôi phục Task để duy trì trạng thái mong muốn (desired state)

1. Chọn **Task definition ecs-lab**, chọn **Deploy** sau đó chọn **Create service**.

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_11.png "image_tooltip")

2. Cấu hình Service:
   * Existing cluster: Chọn **_cloudnut_** cluster
   * Compute options : Chọn **_Launch Type_**
   * Launch type: Chọn _**EC2**_

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_13.png "image_tooltip")

   * Cấu hình Deployment:
     * Service name: **_nginx_**
     * Service type: Chọn **_REPLICA_**
     * Desired tasks : **_1_**
     > Ở đây, số lượng Task được quản lý bởi Service là 1 Task. 
     Trong thực tế triển khai môi trường Production, số Task tối thiểu là 2 để đảm bảo tính có sẵn cao (High Availibility).

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_14.png "image_tooltip")
4. Giữ các thông số khác mặc định và click on the **Create** button.




### **Bước 6: Truy cập vào Nginx Container trong cluster**
> **Ghi chú:** 
> * Trong phần này bạn sẽ truy cập vào EC2 Instance, sau đó dùng câu lệnh kiểm tra **Nginx container** đang chạy trên đó
> * Để làm task này, bạn phải sửa Security Group của EC2 Instances trong ECS cluster để có thể truy cập sử dụng SSH.

1. Chọn mục **Clusters**. Danh sách các clusters sẽ hiển thị ở đây, sao đó click vào cluster **cloudnut**.

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/listcluster.png "image_tooltip")
2. Để xem danh sách các EC2 Instances trong cluster chọn **Infrastructure** tab.

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/infralist.png "image_tooltip")

3.Kéo xuống tới mục **Container Instances**. Click vào phần **Instance ID** để tới màn hình dịch vụ EC2.

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_15.png "image_tooltip")

4. Click để xem chi tiết EC2 Instance

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_18.png "image_tooltip")
5. Chọn Tab **Security** sau đo click vào **Security groups ID**

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_19.png "image_tooltip")

6. Thay đổi Security Group Rule (Inbound Rule) của EC2 Instance trong ECS cluster

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_20.png "image_tooltip")

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_21.png "image_tooltip")

7. Note lại địa chỉ IP Public của EC2 Instance

![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/image_22.png "image_tooltip")

8. Truy cập vào EC2 Instance sử dụng Key pair tạo ở bước 2.
```bash
# Dòng comment, không copy
# Sử dụng Terminal của Linux, MacOS
# Đổi permission của key pair
chmod 400 cloudnut-kp.pem
# Truy cập EC2 Instance sử dụng IP Public. Thay bằng Public IP note ở bước 6.7
ssh -i cloudnut-kp.pem ec2-user@Public_IP
# Ví dụ: ssh -i cloudnut-kp.pem ec2-user@3.80.164.61
# Sau khi Login vào EC2 Instance, thực hiện câu lệnh sau
# Update package
sudo su -
yum -y update
# Chạy command để liệt kê Container đang chạy trong EC2
docker ps
```

# **Hoàn thành bài Lab**
1. Bạn đã tạo thành công và khởi chạy Amazon ECS Cluster.
2. Tạo thành công Nginx container
3. Login vào EC2 Instance của ECS cluster, sử dụng command kiểm tra danh sách các Container đang chạy.

# **Kết thúc Lab**
1. Đăng xuất khỏi AWS Account.
2. Đánh giá và Review bài Lab
3. Khi đã hoàn thành, click vào button ![alt_text](https://cdn.cloudnut.vn/aws/ecs-intro/endlab.png "image_tooltip")  trên giao diện Lab của CloudNut.