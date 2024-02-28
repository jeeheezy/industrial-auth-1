class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user == record.owner || 
    !record.owner.private? ||
    user.leaders.include?(record.owner)
  end

  def update?
    author?
  end

  def destroy?
    author?
  end

  private

  def author?
    user == record.author
  end
end
