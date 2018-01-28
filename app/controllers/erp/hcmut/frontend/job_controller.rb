module Erp
  module Hcmut
    module Frontend
      class JobController < Erp::Frontend::FrontendController
        def listing
          @recruitments = Erp::Recruitments::Recruitment.get_recruitments_with_active.paginate(:page => params[:page], :per_page => 8)
        end
        
        def detail
          @recruitment = Erp::Recruitments::Recruitment.find(params[:recruit_id])
          @meta_keywords = @recruitment.meta_keywords
          @meta_description = @recruitment.meta_description
        end
        
        def apply_form
          @recruitment = Erp::Recruitments::Recruitment.find(params[:recruit_id])
          
          if params[:apply].present?
            @apply = Erp::Recruitments::RecruitApplication.new(apply_params)
            respond_to do |format|
              if @apply.save
                #render plain: 'Hồ sơ của bạn đã được gửi đi.'
                format.html {
                  redirect_to erp_hcmut.root_path, flash: { notice: 'Hồ sơ của bạn đã được gửi đi.'}
                }
              end
            end
          end
          
          #render 'erp/hcmut/frontend/modules/job/_apply_modal', locals: {apply: @apply}, layout: nil
        end
        
        private
          def apply_params
            params.fetch(:apply, {}).permit(:name, :email, :gender, :note, :cv_file, :recruitment_id)
          end
      end
    end
  end
end