module Erp
  module Hcmut
    module Frontend
      class ServiceController < Erp::Frontend::FrontendController
        def listing        
        end
        
        def detail
          @service = Erp::Finances::Service.find(params[:service_id])
          @meta_keywords = @service.meta_keywords
          @meta_description = @service.meta_description
        end
      end
    end
  end
end