module QuestionnaireTags
  include Radiant::Taggable

  tag 'questionnaire' do |tag|
    tag.locals.questionnaire_content = nil
    if !tag.attr['title'].blank?
      tag.locals.questionnaire_content = QuestionnaireContent.find_by_title(tag.attr['title'])
    else
      if !questionnaire_id.blank?
        questionnaire = Questionnaire.find_by_id(questionnaire_id)
        tag.locals.questionnaire_content = nil
        tag.locals.questionnaire_content = questionnaire.questionnaire_contents.detect { |q| q.language == request.language.split('-').first }
        if tag.locals.questionnaire_content == nil
          content = questionnaire.questionnaire_contents.first
        end
      end
    end 

    if tag.locals.questionnaire_content == nil
      return 'No questionnaire found'
    end

    questionnaire = tag.locals.questionnaire_content.questionnaire
    tag.locals.questionnaire = questionnaire
    unless (questionnaire.startdate == nil and questionnaire.enddate == nil)
      current_date = Time.now()
      start_date = questionnaire.startdate
      end_date = questionnaire.enddate
      return 'Questionnaire is expired' unless current_date.between?(start_date, end_date) #unless ((start_date <=> current_date) <= 0 and (end_date <=> current_date) >= 0)
    end
    tag.expand
  end

  tag 'questionnaire:description' do |tag|
    tag.locals.questionnaire_content.description
  end

  tag 'questionnaire:form' do |tag|
    results = []
    action =  "/questionnaire_results"
    results << %(<form id="questionnaire-form" action="#{action}" method="post">)
    results << content_tag(:input, nil, :value => tag.locals.questionnaire.id.to_s, :name => 'questionnaire_results[questionnaire_id]', :type => 'hidden')
    results << tag.expand
    results << "</form>"
  end

  tag 'questionnaire:results' do |tag|
    tag.expand
  end

  tag 'questionnaire:results:firstname' do |tag|
    content_tag(:input, nil, :id => 'questionnaire_results[firstname]', :name => 'questionnaire_results[firstname]', :type => 'text', :size => 255)
  end

  tag 'questionnaire:results:lastname' do |tag|
    content_tag(:input, nil, :id => 'questionnaire_results[lastname]', :name => 'questionnaire_results[lastname]', :type => 'text', :size => 255)
  end

  tag 'questionnaire:results:email' do |tag|
    content_tag(:input, nil, :id => 'questionnaire_results[email]', :name => 'questionnaire_results[email]', :type => 'text', :size => 255)
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
    content_tag(:label, question.question, :class => 'question')
  end

  tag 'questionnaire:questions:answers' do |tag|
    question = tag.locals.question
    answers = question.questionnaire_answers
    html = ''

    element_name = "questionnaire_results[questionnaire_result_entries_attributes]"
    question_id = content_tag(:input, nil, :value => question.id.to_s, :name => element_name + '[][questionnaire_question_id]', :type => 'hidden')
    if question.is_optional?
      required_class = ''
    else
      required_class = ' required'
    end
    
    case question.questionnaire_question_type.name
      when 'Multiple-answer'
        answers.each do |answer|
          html += question_id
          html += content_tag(:input, content_tag(:label, answer.answer, :class => 'questionnaire-label-multiple-answer', :for => element_name + '[][questionnaire_answer_id]['+answer.id.to_s+']')+'<br/>', :class => 'questionnaire-multiple-answer' + required_class, :value => answer.id.to_s, :id => element_name + '[][questionnaire_answer_id]['+answer.id.to_s+']', :name => element_name + '[][questionnaire_answer_id]', :type => 'checkbox')
        end
      when 'Single-answer'
        answers.each do |answer|
          html += question_id
          html += content_tag(:input, content_tag(:label, answer.answer, :class => 'questionnaire-label-single-answer', :for => element_name + '[][questionnaire_answer_id]['+answer.id.to_s+question.id.to_s+']')+'<br/>', :class => 'questionnaire-single-answer' + required_class, :value => answer.id.to_s, :id => element_name + '[][questionnaire_answer_id]['+answer.id.to_s+question.id.to_s+']', :name => element_name + '[][questionnaire_answer_id__'+question.id.to_s+']', :type => 'radio')
        end
      when 'Freetext'
        html += question_id
        html += content_tag(:textarea, nil, :class => 'questionnaire-freetext' + required_class, :name => element_name + '[][freetext_answer]')
      when 'Rating'
        html += question_id
        (1..4).each do |counter|
          html += content_tag(:input, content_tag(:label, counter, :class => 'questionnaire-label-rating', :for => element_name + '[][rating_answer]['+counter.to_s+question.id.to_s+']'), :value => counter, :class => 'questionnaire-rating' + required_class, :id => element_name + '[][rating_answer]['+counter.to_s+question.id.to_s+']', :name => element_name + '[][rating_answer__'+question.id.to_s+']', :type => 'radio')
        end
    end
    html
  end

  tag 'questionnaire:questions:if_comment_field' do |tag|
    question = tag.locals.question
    tag.expand if question.has_comment?
  end

  tag 'questionnaire:questions:unless_comment_field' do |tag|
    question = tag.locals.question
    tag.expand unless question.has_comment?
  end

  tag 'questionnaire:questions:comment_field' do |tag|
    question = tag.locals.question
    element_name = "questionnaire_results[questionnaire_result_entries_attributes]"
    html = content_tag(:input, nil, :value => question.id.to_s, :name => element_name + '[][questionnaire_question_id]', :type => 'hidden')
    html += content_tag(:textarea, nil, :class => 'questionnaire-comment', :name => element_name + '[][comment]') if question.has_comment?
    html
  end
end
