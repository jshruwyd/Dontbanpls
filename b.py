from mega import Mega

# Đăng nhập vào tài khoản MEGA
mega = Mega()
email = "qwerfhjk67@gmail.com"
password = "Huy095720"
m = mega.login(email, password)

# Upload file
file_path = "/mnt/a.qcow2"
file = m.upload(file_path)

# Lấy link tải xuống của file đã upload
link = m.get_upload_link(file)
print(f"Link tải xuống: {link}")
