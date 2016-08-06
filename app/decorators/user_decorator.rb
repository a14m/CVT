# User Decorator
class UserDecorator < ApplicationDecorator
  def plan_size
    30
  end

  def usage
    16
  end

  def percentage
    usage / plan_size.to_f * 100
  end

  def usage_percentage
    h.number_to_percentage(percentage, precision: 1)
  end

  def status
    'status red'
  end
end
