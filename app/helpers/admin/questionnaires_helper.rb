module Admin::QuestionnairesHelper

  def write_header(xml, questions)
    xml.Row do
      xml.Cell { xml.Data 'Lastname', 'ss:Type' => 'String' }
      xml.Cell { xml.Data 'Firstname', 'ss:Type' => 'String' }
      xml.Cell { xml.Data 'Email', 'ss:Type' => 'String' }

      questions.each do |question|
        xml.Cell { xml.Data question.question, 'ss:Type' => 'String'} #, 'ss:MergeAcross' => '1' 
      end
    end
    xml.Row do
      #empthy fields for address
      xml.Cell { xml.Data '', 'ss:Type' => 'String'}
      xml.Cell { xml.Data '', 'ss:Type' => 'String'}
      xml.Cell { xml.Data '', 'ss:Type' => 'String'}
      
      questions.each do |question|
        case question.questionnaire_question_type.name
          when 'Freetext'
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          when 'Rating'
            (1..5).each do |counter|
              xml.Cell { xml.Data counter, 'ss:Type' => 'Number' }
            end
          else
            question.questionnaire_answers.each do |answer|
              xml.Cell { xml.Data answer.answer, 'ss:Type' => 'String' }
            end 
        end
      end
    end                                                               
  end

  def write_results(xml, questionaire, questions)
    questionaire.questionnaire_results.each do |result|

      xml.Row do
        xml.Cell { xml.Data result.lastname, 'ss:Type' => 'String' }
        xml.Cell { xml.Data result.firstname, 'ss:Type' => 'String' }
        xml.Cell { xml.Data result.email, 'ss:Type' => 'String' }
        questions.each do |question|
          #get all answers to a question
          entries = question.get_questionnaire_result_entries(result)

          if entries != nil and !entries.blank?

            case question.questionnaire_question_type.name
              when 'Freetext'
                xml.Cell { xml.Data entries.first.freetext_answer, 'ss:Type' => 'String' }
              when 'Rating'
                (1..4).each do |counter|
                  if entries.first.rating_answer == counter
                    xml.Cell { xml.Data 1, 'ss:Type' => 'Number' }
                  else
                    xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                  end
                end
              else
                question.questionnaire_answers.each do |answer|
                  #logger.info('logging 1: ' + entries.length.to_s)
                  has_result = false
                  entries.each do |entry|
                    if entry.questionnaire_answer_id == answer.id
                      xml.Cell { xml.Data 1, 'ss:Type' => 'Number' }
                      has_result = true
                    end
                  end
                  if !has_result
                    xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                  end
              end
            end
          else
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
        end
      end
    end
  end
end