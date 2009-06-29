class Admin::QuestionnairesController < Admin::ResourceController

  def new
    @questionnaire = Questionnaire.new
    @questionnaire.questionnaire_contents.build
  end

  def edit
    respond_to do |format|
      format.html do
        super
      end
      format.xls  do
        @questionnaire = Questionnaire.find_by_id(params[:id])
        headers["Content-Disposition"] ||= "attachment; filename=export.xls"
        headers['Content-Type'] = "application/vnd.ms-excel"
      end
    end
  end

  def cloning
    #clone questionnaire content
    questionnaire = Questionnaire.find_by_id(params[:id])
    content = questionnaire.questionnaire_contents.first
    clone_content = content.copy(questionnaire)
    clone_content.language = params[:language].blank? ? 'CL' : params[:language]
    clone_content.save

    #clone questionnaire question
    content.questionnaire_questions.each do |question|
      question.copy_with_children(clone_content)
    end

    #redirect to questionnaire overview
    redirect_to admin_questionnaires_url
  end

  def copy
    questionnaire = Questionnaire.find_by_id(params[:id])
    questionnaire.copy_with_children

    #redirect to questionnaire overview
    redirect_to admin_questionnaires_url
  end
end