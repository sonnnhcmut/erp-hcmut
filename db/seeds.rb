# Create default admin user for developing
puts "Create default admin user"
Erp::User.create(
  email: "1633645@hcmut.edu.vn",
  password: "aA456321@",
  name: "Sơn Nguyễn",
  backend_access: true,
  confirmed_at: Time.now-1.day,
  active: true
) if Erp::User.where(email: "1633645@hcmut.edu.vn").empty?

user = Erp::User.first
Erp::Finances::Service.destroy_all
Erp::Finances::Service.create(
  name: "Kế Toán Trọn Gói",
  creator_id: user.id
)
Erp::Finances::Service.create(
  name: "Quyết Toán Thuế",
  creator_id: user.id
)
Erp::Finances::Service.create(
  name: "Báo Cáo Tài Chính",
  creator_id: user.id
)
Erp::Finances::Service.create(
  name: "Bảo Hiểm Xã Hội",
  creator_id: user.id
)
Erp::Finances::Service.create(
  name: "Kế Toán Trưởng",
  creator_id: user.id
)
Erp::Finances::Service.create(
  name: "Thủ Tục Thuế Ban Đầu",
  creator_id: user.id
)
Erp::Finances::Service.create(
  name: "Thành Lập Công Ty",
  creator_id: user.id
)