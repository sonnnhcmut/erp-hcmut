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
    end
  end
end
