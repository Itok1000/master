class Feedback < ApplicationRecord
  belongs_to :post
  belongs_to :user
end
