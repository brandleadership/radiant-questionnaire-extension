module QuestionnaireTags
  include Radiant::Taggable

  radio_group = 0

  tag 'questionnaire' do |tag|
    unless tag.attr['title'].blank?
      tag.locals.questionnaire_content = QuestionnaireContent.find_by_title(tag.attr['title'])
      tag.locals.questionnaire = tag.locals.questionnaire_content.questionnaire
    end
    tag.expand if tag.locals.questionnaire_content != nil
  end

  tag 'questionnaire:questions' do |tag|
    tag.expand
  end

  tag 'questionnaire:questions:each' do |tag|
    result = []
    questionnaire_content = tag.locals.questionnaire_content
    questionnaire_content.questionnaire_questions.each do |question|
      tag.locals.question = question
      result << tag.expand
    end
    result
  end

  tag 'questionnaire:questions:question' do |tag|
    question = tag.locals.question
    content_tag(:p, question.question, :class => 'question')
  end

  tag 'questionnaire:questions:answers' do |tag|
    question = tag.locals.question
    answers = question.questionnaire_answers
    html = ''

    element_name = "question_" + question.id.to_s;
    case question.questionnaire_question_type.name
      when 'Multiple-answer'
        answers.each do |answer|
          html += content_tag(:input, answer.answer, :name => element_name + "_" + answer.id.to_s, :type => 'checkbox')
        end
      when 'Single-answer'
        answers.each do |answer|
          html += content_tag(:input, answer.answer, :name => element_name + "_" + answer.id.to_s, :type => 'radio')
        end
      when 'Freetext'
        html += content_tag(:input, nil, :name => element_name)
      when 'Rating'
        (1..5).each do |counter|
          html += content_tag(:input, counter, :name => element_name, :type => 'radio')
        end 
    end
    html
  end
end