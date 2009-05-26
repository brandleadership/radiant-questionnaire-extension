require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionnaireContent do
  before(:each) do
    @questionnaire_content = QuestionnaireContent.new
  end

  it "should be valid" do
    @questionnaire_content.should be_valid
  end
end
