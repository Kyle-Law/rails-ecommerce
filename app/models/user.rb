class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role, required: false
  has_many :orders
  before_save :set_attributes

  def set_attributes
    self[:role_id] = 1
  end

end
