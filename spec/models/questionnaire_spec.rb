require File.dirname(__FILE__) + '/../spec_helper'

describe Questionnaire do
  before(:each) do
    @questionnaire = Questionnaire.new
  end

  it "should be valid" do
    @questionnaire.should be_valid
  end
end
