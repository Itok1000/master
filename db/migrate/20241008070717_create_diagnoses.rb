class CreateDiagnoses < ActiveRecord::Migration[7.2]
  def change
    create_table :diagnoses do |t|
      t.string :question

      t.timestamps
    end
  end
end
