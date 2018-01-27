module Erp
  module Hcmut
    module Frontend
      class ContactController < Erp::Frontend::FrontendController
        def index
          @company_info = Erp::Contacts::Contact.get_main_contact
          
          if params[:contact].present?
            @contact = Erp::Contacts::Contact.new(contact_params)
            @contact.contact_type = Erp::Contacts::Contact::TYPE_PERSON
            @contact.is_customer = true
            if @contact.save and params[:msg].present?
              @msg = Erp::Contacts::Message.new(message_params)
              @msg.contact_id = @contact.id
              # @todo get email receive contact
              @msg.to_contact_id = Erp::Contacts::Contact.first.id
              respond_to do |format|
                if @msg.save
                  # Send to email (main contact email)
                  # Erp::Contacts::ContactMailer.sending_email_contact(@msg).deliver_now
                  format.html {
                    #redirect_back(fallback_location: @contact, notice: 'Yêu cầu đã được gửi đến chúng tôi.\n Chúng tôi sẽ sớm liên hệ với bạn.')
                    redirect_to erp_hcmut.contact_success_path, flash: { notice: 'Yêu cầu đã được gửi đến chúng tôi.\n Chúng tôi sẽ sớm liên hệ với bạn.'}
                  }
                end
                logger.info '====================='
                logger.info @msg.errors.to_json
              end
            else
              logger.info '====================='
              logger.info @contact.errors.to_json
              redirect_back(fallback_location: @contact, flash: { error: 'Chặn! Vui lòng kiểm tra lại thông tin đã nhập.' })
            end
          end
        end
        
        private
          def contact_params
            params.fetch(:contact, {}).permit(:name, :email, :phone)
          end
          
          def message_params
            params.fetch(:msg, {}).permit(:message)
          end
      end
    end
  end
end