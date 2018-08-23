class VisitorsController < ApplicationController

	def index
		# Building form for other visitors
		@enquiry = Enquiry.new
		redirect_to enquiries_path if current_user.present?
	end
end
