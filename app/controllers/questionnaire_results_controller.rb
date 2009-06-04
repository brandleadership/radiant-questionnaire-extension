class QuestionnaireResultsController < ApplicationController
  no_login_required

  skip_before_filter :verify_authenticity_token 

  def create
    result = QuestionnaireResults.new(params[:questionnaire_results])
    result.submission_date = Time.now
    result.save()
    redirect_to ('/')
  end

end