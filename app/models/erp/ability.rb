module Erp
  class Ability
    include CanCan::Ability
  
    def initialize(user)
      # Define abilities for the passed in user here. For example:
      #
      #   user ||= User.new # guest user (not logged in)
      #   if user.admin?
      #     can :manage, :all
      #   else
      #     can :read, :all
      #   end
      #
      # The first argument to `can` is the action you are giving the user 
      # permission to do.
      # If you pass :manage it will apply to every action. Other common actions
      # here are :read, :create, :update and :destroy.
      #
      # The second argument is the resource the user can perform the action on. 
      # If you pass :all it will apply to every resource. Otherwise pass a Ruby
      # class of the resource.
      #
      # The third argument is an optional hash of conditions to further filter the
      # objects.
      # For example, here the user can only update published articles.
      #
      #   can :update, Article, :published => true
      #
      # See the wiki for details:
      # https://github.com/ryanb/cancan/wiki/Defining-Abilities
      
      Dir.glob(Rails.root.join('engines').to_s + "/*") do |d|
        eg = d.split(/[\/\\]/).last
        method = eg + '_ability'
        send(method, user) if self.respond_to?(method.to_sym)
      end
      
      can :view, Erp::User if user.get_permission(:user_management, :user, :users, :index) == 'yes'
      can :create, Erp::User if user.get_permission(:user_management, :user, :users, :create) == 'yes'
      can :edit, Erp::User if user.get_permission(:user_management, :user, :users, :edit) == 'yes'
      can :delete, Erp::User if user.get_permission(:user_management, :user, :users, :delete) == 'yes'
      
      can :view, Erp::UserGroup if user.get_permission(:user_management, :user_group, :user_groups, :index) == 'yes'
      can :create, Erp::UserGroup if user.get_permission(:user_management, :user_group, :user_groups, :create) == 'yes'
      can :edit, Erp::UserGroup if user.get_permission(:user_management, :user_group, :user_groups, :edit) == 'yes'
      can :delete, Erp::UserGroup if user.get_permission(:user_management, :user_group, :user_groups, :delete) == 'yes'
      
      can :view, Erp::Recruitments::Recruitment if user.get_permission(:user_management, :recruitment, :recruitments, :index) == 'yes'
      can :create, Erp::Recruitments::Recruitment if user.get_permission(:user_management, :recruitment, :recruitments, :create) == 'yes'
      can :edit, Erp::Recruitments::Recruitment if user.get_permission(:user_management, :recruitment, :recruitments, :edit) == 'yes'
      can :delete, Erp::Recruitments::Recruitment if user.get_permission(:user_management, :recruitment, :recruitments, :delete) == 'yes'
      
      can :view, Erp::Articles::Category if user.get_permission(:user_management, :article, :categories, :index) == 'yes'
      can :create, Erp::Articles::Category if user.get_permission(:user_management, :article, :categories, :create) == 'yes'
      can :edit, Erp::Articles::Category if user.get_permission(:user_management, :article, :categories, :edit) == 'yes'
      can :delete, Erp::Articles::Category if user.get_permission(:user_management, :article, :categories, :delete) == 'yes'
      
      can :view, Erp::Articles::Article if user.get_permission(:user_management, :article, :articles, :index) == 'yes'
      can :create, Erp::Articles::Article if user.get_permission(:user_management, :article, :articles, :create) == 'yes'
      can :edit, Erp::Articles::Article if user.get_permission(:user_management, :article, :articles, :edit) == 'yes'
      can :delete, Erp::Articles::Article if user.get_permission(:user_management, :article, :articles, :delete) == 'yes'    
      
      can :view, Erp::Contacts::Message if user.get_permission(:user_management, :contact, :messages, :index) == 'yes'
      can :create, Erp::Contacts::Message if user.get_permission(:user_management, :contact, :messages, :create) == 'yes'
      can :edit, Erp::Contacts::Message if user.get_permission(:user_management, :contact, :messages, :edit) == 'yes'
      can :delete, Erp::Contacts::Message if user.get_permission(:user_management, :contact, :messages, :delete) == 'yes'
      
      can :view, Erp::Contacts::Contact if user.get_permission(:user_management, :contact, :contacts, :index) == 'yes'
      can :create, Erp::Contacts::Contact if user.get_permission(:user_management, :contact, :contacts, :create) == 'yes'
      can :edit, Erp::Contacts::Contact if user.get_permission(:user_management, :contact, :contacts, :edit) == 'yes'
      can :delete, Erp::Contacts::Contact if user.get_permission(:user_management, :contact, :contacts, :delete) == 'yes'
      
      can :view, Erp::Testimonials::Testimonial if user.get_permission(:user_management, :testimonial, :testimonials, :index) == 'yes'
      can :create, Erp::Testimonials::Testimonial if user.get_permission(:user_management, :testimonial, :testimonials, :create) == 'yes'
      can :edit, Erp::Testimonials::Testimonial if user.get_permission(:user_management, :testimonial, :testimonials, :edit) == 'yes'
      can :delete, Erp::Testimonials::Testimonial if user.get_permission(:user_management, :testimonial, :testimonials, :delete) == 'yes'
      
      can :view, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :index) == 'yes'
      can :create, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :create) == 'yes'
      can :edit, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :edit) == 'yes'
      can :delete, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :delete) == 'yes'
      
      can :view, Erp::Banners::Banner if user.get_permission(:user_management, :banner, :slideshows, :index) == 'yes'
      can :create, Erp::Banners::Banner if user.get_permission(:user_management, :banner, :slideshows, :create) == 'yes'
      can :edit, Erp::Banners::Banner if user.get_permission(:user_management, :banner, :slideshows, :edit) == 'yes'
      can :delete, Erp::Banners::Banner if user.get_permission(:user_management, :banner, :slideshows, :delete) == 'yes'
      
      can :view_self, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :index) == 'self'
      can :create, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :create) == 'yes'
      can :edit, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :edit) == 'yes'
      can :delete, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :delete) == 'yes'
      
    end
  end
end
