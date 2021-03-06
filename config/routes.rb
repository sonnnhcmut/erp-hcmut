Erp::Hcmut::Engine.routes.draw do
  root to: "frontend/home#index"
  get "dang-nhap.html" => "frontend/account#login", as: :login
  get "dang-ky.html" => "frontend/account#register", as: :register
  get "gioi-thieu.html" => "frontend/about_us#index", as: :about_us
  get "dich-vu.html" => "frontend/service#listing", as: :service_listing
  get "dich-vu//:service_id(/:title).html" => "frontend/service#detail", as: :service_detail
  get "tin-tuc.html" => "frontend/blog#listing", as: :blog_listing
  get "tin-tuc/:blog_id(/:title).html" => "frontend/blog#detail", as: :blog_detail
  get "tuyen-dung.html" => "frontend/job#listing", as: :job_listing
  get "tuyen-dung/:recruit_id(/:title).html" => "frontend/job#detail", as: :job_detail
  get "nop-ho-so/:recruit_id(/:title).html" => "frontend/job#apply_form", as: :job_apply
	post "nop-ho-so/:recruit_id(/:title).html" => "frontend/job#apply_form"
  get "lien-he.html" => "frontend/contact#index", as: :contact
  post "lien-he.html" => "frontend/contact#index"
  get "nhan-tin-thanh-cong.html" => "frontend/contact#send_message_success", as: :contact_success
end