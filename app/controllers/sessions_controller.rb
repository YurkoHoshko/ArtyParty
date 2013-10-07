class SessionsController < Devise::SessionsController
    skip_before_filter :verify_authenticity_token

  def create
    resource = warden.authenticate!(:scope => resource_name)
    set_flash_message :notice, :signed_in
    sign_in(resource_name, resource)
    respond_to do |format|
      format.json { render :json => 'Success' }
    end
  end

  def destroy # Assumes only JSON requests
    sign_out
    reset_session
    cookies['XSRF-TOKEN'] = form_authenticity_token

    render :json => {
        'csrfToken' => form_authenticity_token
    }
  end
end