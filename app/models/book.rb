class Book < ApplicationRecord
	has_many :rentals, dependent: :destroy
end
