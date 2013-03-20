# == Schema Information
#
# Table name: global_configs
#
#  id                     :integer          not null, primary key
#  singleton_guard        :integer
#  bid_review_enabled     :boolean          default(TRUE)
#  bid_submission_enabled :boolean          default(TRUE)
#  comments_enabled       :boolean          default(TRUE)
#  questions_enabled      :boolean          default(TRUE)
#  event_hooks            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require_dependency 'enum'

class GlobalConfig < ActiveRecord::Base
  serialize :event_hooks, Hash

  validates_inclusion_of :singleton_guard, in: [0]

  def self.instance
    begin
      find(1)
    rescue ActiveRecord::RecordNotFound
      # slight race condition here, but it will only happen once
      row = GlobalConfig.create(singleton_guard: 0)
    end
  end

  def self.event_hooks
    @event_hooks ||= Enum.new(
      :twitter, :custom_http
    )
  end

  def self.event_hook_name_for(event_hook)
    {
      :twitter => "Twitter",
      :custom_http => "Custom HTTP"
    }[event_hook.to_sym]
  end
end
