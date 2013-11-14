module AppsHelper

  def get_tag_list(app)
    tag_list = app.tag_list.map { |t| link_to t, tag_path(t) }.join(', ')
    tag_list.html_safe
  end

  
end
