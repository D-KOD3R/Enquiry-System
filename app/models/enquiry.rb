class Enquiry < ApplicationRecord
	enum status: [:unassigned, :assigned, :replied]
#Validations
	validates :enquirer_email, :enquiry_content, presence: true

#associations	
	belongs_to :assigned_employee, class_name: "User", foreign_key: "assigned_to_id", optional: true

#callbacks	
	before_create :set_default_status


	private 

	def set_default_status
		self.status = "unassigned"
	end

	
end
