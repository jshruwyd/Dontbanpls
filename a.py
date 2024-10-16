import gdown

# URL tệp từ Google Drive
url = 'https://drive.google.com/uc?id=1FBscwiHISpSRws9tEtwI4VkYuLG2K66a'

# Đặt tên cho tệp muốn tải (ví dụ: file.iso)
output = '11.iso'

# Tải tệp
gdown.download(url, output, quiet=False)
