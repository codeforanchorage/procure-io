class MyProjectSerializer < ActiveModel::Serializer
  # cached true

  attributes :id, :title, :bids_due_at, :posted_at, :status_badge_class, :status_text, :total_submitted_bids

  def cache_key
    [object.cache_key, 'v1']
  end
end
