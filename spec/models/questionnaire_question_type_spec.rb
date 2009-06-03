require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionnaireQuestionType do
  before(:each) do
    @questionnaire_question_type = QuestionnaireQuestionType.new
  end

  it "should be valid" do
    @questionnaire_question_type.should be_valid
  end
end
