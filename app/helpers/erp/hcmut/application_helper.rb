module Erp
  module Hcmut
    module ApplicationHelper
      # article link
      def article_link(article)
        erp_hcmut.blog_detail_path(article.id, title:  url_friendly(article.name))
      end
      
      # product link helper
      def service_link(service)
        erp_hcmut.service_detail_path(service_id: service.id, title: service.alias)
      end
      
      # recruitment link
      def recruitment_link(recruit)
        erp_hcmut.job_detail_path(recruit.id, title:  url_friendly(recruit.name))
      end
      
      # recruitment link
      def apply_link(recruit)
        erp_hcmut.job_apply_path(recruit.id, title:  url_friendly(recruit.name))
      end
    end
  end
end
