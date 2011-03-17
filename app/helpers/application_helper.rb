module ApplicationHelper
  
  def include_jquery(version)
    javascript_include_tag(Rails.env.production? ?
      "https://ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js" :
      "lib/development/jquery-#{version}")
  end
  
  def flash_class
    show = flash.reject { |a, b| b.nil? }.to_a
    show.empty? ? {} : { class: show.first.first }
  end
  
  def class_if(cls, check)
    check ? { class: cls } : { }
  end
  
end
