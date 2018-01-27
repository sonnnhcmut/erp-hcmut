module Erp
  module Hcmut
    module ApplicationHelper
      # article link
      def article_link(article)
        erp_hcmut.blog_detail_path(article.id, title:  url_friendly(article.name))
      end
    end
  end
end
