module Erp
  module Hcmut
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          if Erp::Core.available?("banners")
            @sliders = Erp::Banners::Banner.get_home_sliders
          end
        end
      end
    end
  end
end