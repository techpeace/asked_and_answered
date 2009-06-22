# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper_method :logged_in?
  helper :transparent_message
  
  # Allows for 'remember me' functionality
  before_filter :login_from_cookie
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_mars_session_id'
  
  # Render the transparent flash message in response to an AJAX call.
  helper_method :render_flash
  def render_flash(&block)
    render :update do |page|
      rjs_transparent_flash_message(page)
      yield(page) if block_given?
    end
  end
  
  # Output a unique id based on an object's class and id.
  helper_method :dom_id
  def dom_id(object)
    object.class.to_s.tableize + '_' + object.id.to_s
  end
end
