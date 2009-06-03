require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionnaireAnswer do
  before(:each) do
    @questionnaire_answer = QuestionnaireAnswer.new
  end

  it "should be valid" do
    @questionnaire_answer.should be_valid
  end
end
