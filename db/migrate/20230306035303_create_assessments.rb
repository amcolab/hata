class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.integer :point
      t.integer :assessment_user_id, null: false
      t.references :answer, type: :integer, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
