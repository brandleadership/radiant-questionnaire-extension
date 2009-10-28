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
      question.copy_with_children(clone_content, true)
    end

    #redirect to questionnaire overview
    redirect_to admin_questionnaires_url
  end

  def copy
    questionnaire = Questionnaire.find_by_id(params[:id])
    questionnaire_new = questionnaire.copy_with_children

    #copy master_question_id to questions of cloned questionnaires
    master_content = nil
    questionnaire_new.questionnaire_contents.each do |content|
      if content == questionnaire_new.questionnaire_contents.first
        master_content = content
      else
        element_counter = 0
        master_content.questionnaire_questions.each do |master_question|
          question = content.questionnaire_questions[element_counter]
          question.questionnaire_master_question_id = master_question.id
          question.save
          element_counter += 1
        end
      end
    end

    #redirect to questionnaire overview
    redirect_to admin_questionnaires_url
  end
 
end