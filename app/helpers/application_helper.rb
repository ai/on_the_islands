module ApplicationHelper
  
  def include_jquery(version)
    javascript_include_tag(Rails.env.production? ?
      "https://ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js" :
      "lib/development/jquery-#{version}")
  end
  
end
