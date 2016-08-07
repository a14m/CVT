# User Decorator
class UserDecorator < ApplicationDecorator
  def plan_size
    20
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
    return 'green'  if percentage < 60
    return 'orange' if percentage.between?(60, 80)
    'red'
  end
end
