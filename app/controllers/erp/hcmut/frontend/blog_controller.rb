module Erp
  module Hcmut
    module Frontend
      class BlogController < Erp::Frontend::FrontendController
        def listing
          @blogs = Erp::Articles::Article.get_all_blogs(params).paginate(:page => params[:page], :per_page => 8)
        end
        
        def detail
          @blog = Erp::Articles::Article.find(params[:blog_id])
          @meta_keywords = @blog.meta_keywords
          @meta_description = @blog.meta_description
        end
      end
    end
  end
end