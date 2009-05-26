class Admin::QuestionnairesController < Admin::ResourceController

  def new
    @questionnaire = Questionnaire.new
    @questionnaire.questionnaire_contents.build
  end

end