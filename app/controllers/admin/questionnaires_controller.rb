class Admin::QuestionnairesController < Admin::ResourceController

  def new
    @questionnaire = Questionnaire.new
    @questionnaire.questionnaire_contents.build
  end

  def edit
    respond_to do |format|
      format.html {
        super
      }
      format.xls  {
        @questionnaire = Questionnaire.find_by_id(params[:id])
        headers["Content-Disposition"] ||= "attachment; filename=export.xls"
        headers['Content-Type'] = "application/vnd.ms-excel"
      }
    end
  end

  def cloning
    #clone questionnaire content
    @questionnaire = Questionnaire.find_by_id(params[:id])
    content = @questionnaire.questionnaire_contents.first
    clone_content= QuestionnaireContent.new
    content.attributes.each {|attr, value| eval("clone_content.#{attr}= content.#{attr}")}
    clone_content.id = nil
    clone_content.questionnaire_id = @questionnaire.id
    clone_content.language = params[:language].blank? ? 'CL' : params[:language]
    clone_content.save

    #clone questionnaire question
    content.questionnaire_questions.each do |question|
      clone_question = QuestionnaireQuestion.new
      question.attributes.each {|attr, value| eval("clone_question.#{attr}= question.#{attr}")}
      clone_question.id = nil
      clone_question.questionnaire_content_id = clone_content.id
      clone_question.save

      #clone questionnaire answer
      question.questionnaire_answers.each do |answer|
        clone_answer = QuestionnaireAnswer.new
        answer.attributes.each {|attr, value| eval("clone_answer.#{attr}= answer.#{attr}")}
        clone_answer.id = nil
        clone_answer.questionnaire_question_id = clone_question.id
        clone_answer.save
      end
    end

    #redirect to questionnaire overview
    redirect_to admin_questionnaires_url
  end
end