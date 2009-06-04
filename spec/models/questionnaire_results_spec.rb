require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionnaireResults do
  before(:each) do
    @questionnaire_results = QuestionnaireResults.new
  end

  it "should be valid" do
    @questionnaire_results.should be_valid
  end
end
