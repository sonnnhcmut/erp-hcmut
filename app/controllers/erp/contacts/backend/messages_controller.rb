module Erp
  module Contacts
    module Backend
      class MessagesController < Erp::Backend::BackendController
        before_action :set_message, only: [:destroy]
        before_action :set_messages, only: [:delete_all]
        
        def index
          authorize! :view, Erp::Contacts::Message
        end
        
        # GET /messages
        def list
          authorize! :view, Erp::Contacts::Message
          @messages = Message.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # DELETE /messages/1
        def destroy
          authorize! :delete, @message
          @message.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_contacts.backend_messages_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /messages/delete_all?ids=1,2,3
        def delete_all         
          @messages.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
    
        private
          def set_message
            @message = Message.find(params[:id])
          end
          
          def set_messages
            @messages = Message.where(id: params[:ids])
          end
      end
    end
  end
end
