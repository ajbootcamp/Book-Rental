class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :due_date, presence: true


  scope :not_returned, -> { where(returned: false) }

end
