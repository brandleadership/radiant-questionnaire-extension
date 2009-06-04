require File.dirname(__FILE__) + '/../spec_helper'

describe QuestionnaireResultEntries do
  before(:each) do
    @questionnaire_result_entries = QuestionnaireResultEntries.new
  end

  it "should be valid" do
    @questionnaire_result_entries.should be_valid
  end
end
