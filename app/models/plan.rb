class Plan < ActiveRecord::Base
  has_many :subscriptions

  def locale_name
    I18n.translate "plans.#{name}.name"
  end
end