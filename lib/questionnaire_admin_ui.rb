module QuestionnaireAdminUI

 def self.included(base)
   base.class_eval do

      attr_accessor :questionnaires

      protected

        def load_default_questionnaire_regions
          returning OpenStruct.new do |questionnaire|
            questionnaire.index = Radiant::AdminUI::RegionSet.new do |index|
              index.top.concat %w{help_text}
              index.thead.concat %w{title_header language_header modify_header}
              index.tbody.concat %w{title_cell language_cell modify_cell}
              index.bottom.concat %w{new_button}
            end
            questionnaire.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{edit_header edit_form}
              edit.form.concat %w{edit_title edit_content}
              edit.form_bottom.concat %w{edit_buttons}
            end
            questionnaire.new = questionnaire.edit
          end
        end

    end
  end
end
