# Copyright (c) 2006 Sébastien Gruhier (http://xilinus.com, http://itseb.com)
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 
# VERSION 1.0
module TransparentMessageHelper  
  def transparent_flash_message(options = {})
    html = ""
    ## Check some of common flash keys
    [:error, :notice, :info, :warning].each do |key|
      if flash[key]
        html = content_tag("div", content_tag("p", flash[key]), :id => "transparent_message", :class => "transparent_message transparent_#{key.to_s}", :style => "display:none")
        break
      end
    end    
    unless html.empty?
      js = javascript_tag "new TransparentMenu('transparent_message',#{options_for_javascript_extended(options)})"
      html + js
    end
  end  
      
  def transparent_message_for_form(form_id, message_id, options = {})
    options[:showMode] ||= "null" 
    options[:hideMode] ||= "'none'" 
    js = "Event.observe($('#{form_id}'), 'submit', function() {new TransparentMenu('#{message_id}', #{options_for_javascript_extended(options)})})"

    javascript_tag js
  end
  
  def transparent_message_show( message_id, options = {}) 
    "TransparentMenu.show('#{message_id}', #{options_for_javascript_extended(options)})"
  end
  
  def transparent_message_hide(message_id) 
    "TransparentMenu.hide('#{message_id}')"
  end
  
  def transparent_message_create(id, content, progress_image = nil) 
    content += image_tag(progress_image) + "<br clear='all' />" unless progress_image.nil?
    div_content = content_tag("p", content)
    content_tag("div", div_content , :id => id, :style => "display:none")
  end

  def rjs_transparent_flash_message(page, prefix = 'transparent_', options = {}) 
    js = ""
    options[:showMode] ||= "null" 
    ## Check some of common flash keys
    [:error, :notice, :info, :warning].each do |key|
      logger.warn(key)
      if flash[key]
        js << "var element = $('#{prefix}#{key}');\n"
        js << "if (! element ) {\n"
        js << "  element = document.createElement('div');\n"
        js << "  element.style.display='none';\n"
        js << "  document.body.appendChild(element);\n"
        js << "}\n"
        js << "element.style.display='none';\n"
        js << "element.id = '#{prefix}#{key}';\n"
        js << "element.innerHTML = '<p>#{flash[key]}</p>';\n"
        js << "element.className = '#{prefix}message #{prefix}#{key.to_s}';\n"
        js << transparent_message_show(prefix + key.to_s, options)
        break
      end
    end  
    page << js
  end  

  private
  ## Extend options_for_javascript to handle hashmap of hashmap
  def options_for_javascript_extended(options)
    '{' + options.map {|k, v|  v.kind_of?(Hash) ? "#{k}:#{options_for_javascript_extended(v)}" : "#{k}:#{v}"}.sort.join(', ') + '}'
  end  
end
