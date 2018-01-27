module Erp
  module Hcmut
    module Frontend
      class AboutUsController < Erp::Frontend::FrontendController
        def index
          @about_us = Erp::Articles::Article.joins(:category)
            .where('erp_articles_categories.alias = ?', Erp::Articles::Category::ALIAS_ABOUT_US)
            .order('erp_articles_articles.created_at DESC').last
        end
      end
    end
  end
end