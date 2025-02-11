class UserDecorator < Draper::Decorator
  delegate_all
  def full_name
    object.user_name
  end
end
