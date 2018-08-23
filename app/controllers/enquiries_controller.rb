class EnquiriesController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :validate_parameters, only: [:create]

  def index
  	if current_user.role == 'admin'
      # fething all enquiries
  		@enquiries = Enquiry.all
  	else
      # fetching user assigned queries only
  		@enquiries = current_user.assigned_enquiries
  	end
  end

  def show
  end

  def create
  	@enquiry = Enquiry.new(enquiry_params)
    # Saving queries
  	if @enquiry.save
  		redirect_and_flash 'Thanks for sharing your issues, we will get back to you soon!', :notice, root_path	
  	else
  		redirect_and_flash @enquiry.errors.full_messages.first, :error, root_path	
  	end
  end

  def view_enquiry
    @enquiry = Enquiry.find(params[:id])
  end

  def reply_enquiry
  	@enquiry = Enquiry.find(params[:id])
    # mwthod only to reply quiries
  	if @enquiry.update(reply_enquiry_params) && @enquiry.assigned_employee == current_user
      EnquiryMailer.reply_enquiry(@enquiry.id).deliver_later!
  		redirect_and_flash 'Enquiry has been resolved', :notice, enquiries_path	
  	else
  		redirect_and_flash "You are not authenticated person to resolve this enquiry!", :error, enquiries_path	
  	end
  end

  def edit
  	@enquiry = Enquiry.find(params[:id])
  end

  def update
  	@enquiry = Enquiry.find(params[:id])
  	if @enquiry.update(assign_enquiry_params)
  		redirect_and_flash 'Enquiry has been assigned to a person', :notice, enquiries_path	
  	else
  		redirect_and_flash "Something went wrong!", :error, enquiries_path	
  	end
  end

private
# whitelisting parameters 
  def assign_enquiry_params
  	params[:enquiry][:status] = 1 
  	params.require(:enquiry).permit(:assigned_to_id, :status )
  end 

  def reply_enquiry_params
  	params[:enquiry][:status] = 2
  	params.require(:enquiry).permit(:response_content, :status )
  end

  def enquiry_params
  	params.require(:enquiry).permit(:enquirer_email, :enquiry_content )
  end

  def validate_parameters
    unless (params[:enquiry][:enquirer_email].present? && params[:enquiry][:enquiry_content].present?)
      redirect_and_flash 'Email/Enquiry Content is missing!', :error, root_path
    end
  end
end
