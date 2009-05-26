# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class QuestionnaireExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/questionnaire"
  
   define_routes do |map|
     map.namespace :admin, :member => { :remove => :get } do |admin|
       admin.resources :questionnaires
     end
   end
  
  def activate
    admin.tabs.add "Questionnaire", "/admin/questionnaires", :after => "Layouts", :visibility => [:all]

    Radiant::AdminUI.send :include, QuestionnaireAdminUI unless defined? admin.questionnaire # UI is a singleton and already loaded
    admin.questionnaires = Radiant::AdminUI.load_default_questionnaire_regions
  end
  
  def deactivate
     admin.tabs.remove "Questionnaire"
  end
  
end
