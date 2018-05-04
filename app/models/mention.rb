class Mention < ActiveRecord::Base
  belongs_to :coin
  validates_uniqueness_of :comment_id, scope: :coin_id
end
