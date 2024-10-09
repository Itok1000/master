class AddQuestionsToDiagnoses < ActiveRecord::Migration[7.2]
  def change
    add_column :diagnoses, :question1, :string
    add_column :diagnoses, :question2, :string
    add_column :diagnoses, :question3, :string
  end
end
