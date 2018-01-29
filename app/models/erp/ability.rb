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
      
      can :view, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :index) == 'yes'
      can :create, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :create) == 'yes'
      can :edit, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :edit) == 'yes'
      can :delete, Erp::Finances::Service if user.get_permission(:user_management, :finance, :services, :delete) == 'yes'
      
      can :view_self, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :index) == 'self'
      can :create, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :create) == 'yes'
      can :edit, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :edit) == 'yes'
      can :delete, Erp::Finances::ServiceRegister if user.get_permission(:user_management, :service, :service_registers, :delete) == 'yes'
      
    end
  end
end
