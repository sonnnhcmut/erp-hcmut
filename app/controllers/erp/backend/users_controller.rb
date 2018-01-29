module Erp
  module Backend
    class UsersController < Erp::Backend::BackendController
      before_action :set_user, only: [:deactivate, :activate, :edit, :update, :destroy]
      before_action :set_users, only: [:deactivate_all, :activate_all, :delete_all]

      # GET /users
      def index
        authorize! :view, Erp::User
      end

      # POST /users/list
      def list
        authorize! :view, Erp::User
        
        @users = User.search(params).paginate(:page => params[:page], :per_page => 20)
        render layout: nil
      end

      # GET /users/new
      def new
        @user = User.new
        authorize! :create, @user
      end

      # GET /users/1/edit
      def edit
        authorize! :edit, @user
      end

      # POST /users
      def create
        @user = User.new(user_params)
        authorize! :create, @user
        
        @user.creator = current_user
        @user.permissions = params.to_unsafe_hash[:permissions].to_json

        if @user.save
          if request.xhr?
            render json: {
              status: 'success',
              text: @user.name,
              value: @user.id
            }
          else
            redirect_to erp.edit_backend_user_path(@user), notice: t('.success')
          end
        else
          render :new
        end
      end

      # PATCH/PUT /users/1
      def update
        authorize! :edit, @user
        
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end

        if @user.update(user_params)
          @user.permissions = params.to_unsafe_hash[:permissions].to_json
          @user.save

          if request.xhr?
            render json: {
              status: 'success',
              text: @user.name,
              value: @user.id
            }
          else
            redirect_to erp.edit_backend_user_path(@user), notice: t('.success')
          end
        else
          render :edit
        end
      end

      # DELETE /users/1
      def destroy
        authorize! :delete, @user
        
        @user.destroy

        respond_to do |format|
          format.html { redirect_to erp.backend_users_path, notice: t('.success') }
          format.json {
            render json: {
              'message': t('.success'),
              'type': 'success'
            }
          }
        end
      end

      # DELETE /users/delete_all?ids=1,2,3
      def delete_all
        authorize! :delete, @user        
        @users.destroy_all

        respond_to do |format|
          format.json {
            render json: {
              'message': t('.success'),
              'type': 'success'
            }
          }
        end
      end

      def dataselect
        respond_to do |format|
          format.json {
            render json: User.dataselect(params[:keyword])
          }
        end
      end

      def deactivate
        @user.deactivate
        respond_to do |format|
          format.html { redirect_to erp.backend_users_path, notice: t('.success') }
          format.json {
            render json: {
              'message': t('.success'),
              'type': 'success'
            }
          }
        end
      end

      def activate
        @user.activate
        respond_to do |format|
          format.html { redirect_to erp.backend_users_path, notice: t('.success') }
          format.json {
            render json: {
              'message': t('.success'),
              'type': 'success'
            }
          }
        end
      end

      # Deactivate /users/deactivate_all?ids=1,2,3
        def deactivate_all
          @users.deactivate_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # Activate /users/activate_all?ids=1,2,3
        def activate_all
          @users.activate_all

          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end

        # remember user filters
        def save_filter
          filter = JSON.parse(params[:filters])
          current_user.update_filter(filter.first[0], filter.first[1]) # update_column(:data, data.to_json)

          render plain: 'saved'
        end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        def set_users
          @users = User.where(id: params[:ids])
        end

        # Only allow a trusted parameter "white list" through.
        def user_params
          params.fetch(:user, {}).permit(:address, :avatar, :name, :email, :password, :timezone, :user_group_id)
        end
    end
  end
end
