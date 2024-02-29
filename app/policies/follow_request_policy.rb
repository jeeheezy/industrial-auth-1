class FollowRequestPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
  # anyone should be able to create a follow request unless they've already created it
  # here it seems the value in the parameter being passed for record is the FollowRequest class, so there's not a good way of validating whether there is an existing FollowRequest or not
  # since there's guardrails by only showing follow form under a conditional in the user partial as well as a error catch in the follow request form partial which seems to block duplicative follow requests from being sent, don't think there's a necessity to really specify a validation of whether FollowRequest existent here
  # if I had to, only way I can currently think of is not using authorize helper and explicitly calling new policy class (as was done in comments) while passing in the user who's page we're on as the record, and then using a where query to verify no FollowRequest records exist where the sender is the current user and the recipient is the passed in record
    true
  end

  def update?
  # should only be able to update if you're the recipient
    user == record.recipient
  end

  def destroy?
  # should only be able to destroy if you're the sender
    (user == record.sender) || (user == record.recipient)
  end
end
