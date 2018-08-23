class EnquiryMailer < ApplicationMailer
	def reply_enquiry(enq_id)
		@enq_obj = Enquiry.find_by_id(enq_id) 
		return unless @enq_obj
		mail(to: @enq_obj.enquirer_email, subject: 'Your query has been resolved')
	end
end
