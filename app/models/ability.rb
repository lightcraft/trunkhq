class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    Rails.logger.debug("USER CANCAN #{user.inspect}")
    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :user
      can :switch, User

      can :read, User, :id => user.id
      can [:read, :update, :destroy], Location, :user_id => user.id

      can :update, :all, :user_id => user.id
      can :read, Sip, :user_id => user.id
      can :read, PrefixGroup
      #can :create, Channel
      #
      #can [:update, :destroy, :power, :sys_info], Channel do |channel|
      #  Rails.logger.debug("CHECKROLE CHANNEL")
      #  Rails.logger.debug(channel.inspect)
      #  channel.location.user_id == user.id
      #end

    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
