# User Decorator
class UserDecorator < ApplicationDecorator
  def usage
    user.usage / (1024.0 * 1024.0 * 1024.0)
  end

  def percentage
    user.usage.to_f / user.quota.to_f * 100
  end

  def plan_size
    h.number_to_human_size(user.quota)
  end

  def usage_percentage
    h.number_with_precision(percentage, precision: 1)
  end

  def status
    return 'green'  if percentage < 60
    return 'orange' if percentage.between?(60, 80)
    'red'
  end
end
