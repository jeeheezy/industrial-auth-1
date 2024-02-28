class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user,photo)
    @user = user
    @photo = photo
  end 

  def show?
    owner? ||
    !photo.owner.private? ||
    photo.owner.followers.include?(user)
  end 

  def create?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    user == photo.owner
  end

end 
