class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action. Please contact us at htthsupport@htgroup.com.my if you need any assistance."
    redirect_to(request.referrer || root_path)
  end
end
