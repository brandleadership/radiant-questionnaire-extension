# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class QuestionnaireExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/questionnaire"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :questionnaire
  #   end
  # end
  
  def activate
    # admin.tabs.add "Questionnaire", "/admin/questionnaire", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Questionnaire"
  end
  
end
