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

end