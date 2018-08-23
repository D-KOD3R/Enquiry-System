class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	ROLES = %w(admin employee)      

	#validations
	validates :role, inclusion: { in: ROLES, message: "%{value} is not a valid role" }
	validates :name, presence: true

	#associations
	has_many :assigned_enquiries, class_name: "Enquiry", foreign_key: "assigned_to_id"

end
