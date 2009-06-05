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

  tag 'questionnaire:form' do |tag|
    results = []
    action =  "/questionnaire_results"
    results << %(<form action="#{action}" method="post">)
    results << tag.expand
    results << %(<input type="submit">)
    results << "</form>"
  end

  tag 'questionnaire:results' do |tag|
    tag.expand
  end

  tag 'questionnaire:results:firstname' do |tag|
    content_tag(:input, nil, :name => 'questionnaire_results[firstname]', :type => 'text', :size => 255)
  end

  tag 'questionnaire:results:lastname' do |tag|
    content_tag(:input, nil, :name => 'questionnaire_results[lastname]', :type => 'text', :size => 255)
  end

  tag 'questionnaire:results:email' do |tag|
    content_tag(:input, nil, :name => 'questionnaire_results[email]', :type => 'text', :size => 255)
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

    element_name = "questionnaire_results[questionnaire_result_entries_attributes]"
    question_id = content_tag(:input, nil, :value => question.id.to_s, :name => element_name + '[][questionnaire_question_id]', :type => 'hidden')
    case question.questionnaire_question_type.name
      when 'Multiple-answer'
        answers.each do |answer|
          html += question_id
          html += content_tag(:input, answer.answer, :value => answer.id.to_s, :name => element_name + '[][questionnaire_answer_id]', :type => 'checkbox')
        end
      when 'Single-answer'
        answers.each do |answer|
          html += question_id
          html += content_tag(:input, answer.answer, :value => answer.id.to_s, :name => element_name + '[][questionnaire_answer_id]', :type => 'radio')
        end
      when 'Freetext'
        html += question_id
        html += content_tag(:input, nil, :name => element_name + '[][freetext_answer]')
      when 'Rating'
        html += question_id
        (1..5).each do |counter|
          html += content_tag(:input, counter, :value => counter, :name => element_name + '[][rating_answer]', :type => 'radio')
        end 
    end
    html
  end
end