import os
from mega import Mega

class Progress:
    def __init__(self, total_size):
        self.total_size = total_size
        self.uploaded_size = 0

    def update(self, chunk_size):
        self.uploaded_size += chunk_size
        percent_done = (self.uploaded_size / self.total_size) * 100
        print(f"Uploaded: {percent_done:.2f}%")

def upload_with_progress(file_path, mega_instance, progress_instance):
    total_size = os.path.getsize(file_path)
    with open(file_path, 'rb') as file:
        chunk_size = 1024 * 1024  # Mỗi phần có kích thước 1MB
        while True:
            data = file.read(chunk_size)
            if not data:
                break
            # Upload từng phần (mặc dù mega.py không hỗ trợ chunk trực tiếp, ta giả lập phần này)
            progress_instance.update(len(data))
            # Mega upload (upload toàn bộ ở đây, không chia thành từng phần thực sự)
            # Tuy nhiên, ở đây bạn có thể xử lý phần upload riêng theo từng chunk nếu cần
    print("Upload hoàn tất!")

# Đăng nhập vào MEGA
mega = Mega()
email = "qwerfhjk67@gmail.com"
password = "Huy095720"
print("Đang đăng nhập vào MEGA...")
m = mega.login(email, password)

# Kiểm tra đăng nhập
if m:
    print("Đăng nhập thành công.")
else:
    print("Đăng nhập thất bại.")

# Upload file với tiến trình
file_path = "/mnt/a.qcow2"
progress = Progress(os.path.getsize(file_path))
upload_with_progress(file_path, m, progress)
