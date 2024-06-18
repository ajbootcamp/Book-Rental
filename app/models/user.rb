class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	has_many :rentals

  def admin?
    self.admin
  end
  def rented?(book)
    rentals.exists?(book_id: book.id, returned: false)
  end
end
