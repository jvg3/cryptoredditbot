class Mention < ActiveRecord::Base
  belongs_to :coin
  validates_uniqueness_of :comment, scope: :coin_id
end
