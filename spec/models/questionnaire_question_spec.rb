require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionnaireQuestion do
  before(:each) do
    @questionnaire_question = QuestionnaireQuestion.new
  end

  it "should be valid" do
    @questionnaire_question.should be_valid
  end
end
