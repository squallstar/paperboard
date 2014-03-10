# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  paymill_id :string(255)
#  name       :string(255)
#  price      :float
#  created_at :datetime
#  updated_at :datetime
#

class Plan < ActiveRecord::Base
  has_many :subscriptions

  def locale_name
    I18n.translate "plans.#{name}.name"
  end
end
