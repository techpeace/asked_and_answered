# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
   # Wrap content in an expert_content block to make sure it is only visible to logged-in
    # experts or administrators.
    def expert_content(&block)
      #yield if logged_in?
    end

    # Wrap content in an admin_content block to make sure that it is only visible to logged-in
    # administrators.
    def admin_content(&block)
      #yield if logged_in? && User.find(session[:user]).is_admin?
    end

    # Wrap content that is not meant for non-logged-in users.
    def public_content(&block)
      #yield if !logged_in?
      yield
    end

    # Outputs a byline for a question.
    # ex. - Jim from Austin, Texas
    def byline(questioner)
      byline = '<br />'
      byline += ' asked by ' + questioner.full_name if questioner.full_name
      byline += " <br /> " + questioner.school if questioner.school
      byline += ", " + questioner.city if questioner.city
      byline += ", " + questioner.state if questioner.state
      byline
    end

    # Creates an image tag for the specified icon.
    def icon(name, options = {})
      image_tag("/images/icons/#{name.to_s}.png", options)
    end

    # Outputs an image of a check mark.
    def check_mark
      image_tag('bullet.jpg', :style => "border: 0px")
    end

    # Utility method to set up haml for erb.
    def haml
      # needed to use haml with erb
      unless is_haml?
        init_haml_helpers
      end

      capture_haml do
        yield
      end
    end

    # Output a unique id based on an object's class and id.
    # Copied into the application controller to have access in render :update calls.  Why?  Because I'm lazy.
    def dom_id(object)
      object.class.to_s.tableize + '_' + object.id.to_s
    end

    # from http://www.eribium.org/blog/?p=165
    def button_to_remote(name, options = {}, html_options = {})
      html_options = html_options.stringify_keys
      convert_boolean_attributes!(html_options, %w( disabled ))
      method_tag = ''
      if (method = html_options.delete('method')) && %w{put delete}.include?(method.to_s)
        method_tag = tag('input', :type => 'hidden', :name => '_method', :value => method.to_s) + "</input>"
        options.merge!(:method => method.to_s)
      end
      if confirm = html_options.delete("confirm")
        html_options["onclick"] = "return #{confirm_javascript_function(confirm)};"
      end

      html_options["type"] = "submit"

      before_html = html_options.delete('before') || ''
      after_html = html_options.delete('after') || ''
      url = options.is_a?(String) ? options : self.url_for(options)
      name ||= url
      #options.merge!(:html => {:class => 'button-to'})

      form_remote_tag(options) + method_tag + before_html + tag("input", html_options, true) + name + '</input>' + after_html + '</form>'
    end

    # Outputs a td containing links to edit and destroy the given object.
    def action_links(object, options = {})
      class_name = object.class.to_s.tableize.downcase

      haml do
        open :td, :class => "list-table-links" do
          puts link_to(icon(options[:edit_icon]), 
                {:action => "edit", 
                 :controller => class_name, 
                 :id => object.id}, 
                :class => "edit-link")
          puts button_to_remote('', 
                { :url => {:action => "destroy", :id => object}}, 
                { :loading  => transparent_message_show('ajax_info_message'), 
                  :complete => transparent_message_hide('ajax_info_message'),   
                  :method => :delete, 
                  :confirm => "Are you sure you want to delete this #{class_name.humanize.downcase.singularize}?", 
                  :class => options[:delete_class], 
                  :onmouseover => "this.style.cursor = 'pointer';", 
                  :onmouseout => "this.style.cursor = 'auto';",
                  :value => " "})
        end # open
      end # haml
    end # def action_links
  
  # Uses the Google Javascript API to load prototype and scriptaculous.
  def load_prototype_scriptaculous
    # If we are in production mode, load prototype and scriptaculous with the Google AJAX libraries API.
    if $RAILS_ENV == "production"
      javascript_include_tag("http://www.google.com/jsapi?key=#{APP_CONFIG[:google_api_key]}")
      javascript_tag('google.load("prototype", "1.6"); google.load("scriptaculous", "1.8.1");')
    else
      javascript_include_tag(:defaults)
    end
  end 
end
