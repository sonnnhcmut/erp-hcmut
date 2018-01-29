module Erp
  module Articles
    module Backend
      class ArticlesController < Erp::Backend::BackendController
        before_action :set_article, only: [:archive, :unarchive, :show, :edit, :update, :destroy, :move_up, :move_down]
        before_action :set_articles, only: [:delete_all, :archive_all, :unarchive_all]
        
        def index
          authorize! :view, Erp::Articles::Article
        end

        # GET /articles
        def list
          authorize! :view, Erp::Articles::Article
          @articles = Article.search(params).paginate(:page => params[:page], :per_page => 10)

          render layout: nil
        end

        # GET /articles/1
        def show
        end

        # GET /articles/new
        def new
          @article = Article.new
          authorize! :create, @article

          if request.xhr?
            render '_form', layout: nil, locals: {article: @article}
          end
        end

        # GET /articles/1/edit
        def edit
          authorize! :edit, @article
        end

        # POST /articles
        def create
          @article = Article.new(article_params)
          authorize! :create, @article
          
          @article.creator = current_user

          if @article.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @article.id,
                value: @article.name
              }
            else
              redirect_to erp_articles.edit_backend_article_path(@article), notice: t('.success')
            end
          else
            if request.xhr?
              render '_form', layout: nil, locals: {article: @article}
            else
              render :new
            end
          end
        end

        # PATCH/PUT /articles/1
        def update
          authorize! :edit, @article
          
          if @article.update(article_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @article.id,
                value: @article.name
              }
            else
              redirect_to erp_articles.edit_backend_article_path(@article), notice: t('.success')
            end
          else
            render :edit
          end
        end

        # DELETE /articles/1
        def destroy
          authorize! :delete, @article
          
          @article.destroy

          respond_to do |format|
            format.html { redirect_to erp_articles.backend_articles_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # DELETE /articles/delete_all?ids=1,2,3
        def delete_all
          authorize! :delete, @article
          
          @articles.destroy_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # Archive /articles/archive?id=1
        def archive
          @article.archive

          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end

        # Unarchive /articles/unarchive?id=1
        def unarchive
          @article.unarchive

          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end

        # Archive /articles/archive_all?ids=1,2,3
        def archive_all
          @articles.archive_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # Unarchive /articles/unarchive_all?ids=1,2,3
        def unarchive_all
          @articles.unarchive_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # dataselect /articles
        def dataselect
          respond_to do |format|
            format.json {
              render json: Article.dataselect(params[:keyword])
            }
          end
        end

        # Move up /categories/up?id=1
        def move_up
          @article.move_up

          respond_to do |format|
          format.json {
            render json: {
            #'message': t('.success'),
            #'type': 'success'
            }
          }
          end
        end

        # Move down /categories/up?id=1
        def move_down
          @article.move_down

          respond_to do |format|
          format.json {
            render json: {
            #'message': t('.success'),
            #'type': 'success'
            }
          }
          end
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_article
            @article = Article.find(params[:id])
          end

          def set_articles
            @articles = Article.where(id: params[:ids])
          end

          # Only allow a trusted parameter "white list" through.
          def article_params
            params.fetch(:article, {}).permit(:image, :name, :content, :meta_keywords, :meta_description, :tags, :category_id)
          end
      end
    end
  end
end
