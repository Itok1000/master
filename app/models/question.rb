class Question < ActiveYaml::Base
    set_root_path "app/models/active_hash"
    set_filename "questions"

    def localized_content
        content[I18n.locale.to_s]
    end

    def localized_choices
        choices[I18n.locale.to_s]
    end

    def localized_answers
        answers[I18n.locale.to_s]
    end

    def localized_explain
        explain[I18n.locale.to_s]
    end
end
