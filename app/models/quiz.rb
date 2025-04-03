class Quiz
    include ActiveModel::Model
    include ActiveModel::Attributes
  
    attr_accessor :question_id, :selected_answers
  
    validates :selected_answers, presence: true
end
