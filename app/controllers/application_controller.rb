class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
      skip_before_filter :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter  :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    form_authenticity_token == request.headers['X-XSRF-TOKEN']

    puts form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :phone, :date_of_birth, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :date_of_birth, :phone, :password, :password_confirmation, :current_password) }
  end


end