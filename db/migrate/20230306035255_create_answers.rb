class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :content, null: false
      t.integer :total_point
      t.references :user, type: :integer, null: false, foreign_key: { on_delete: :cascade }
      t.references :question, type: :integer, null: false, foreign_key: { on_delete: :cascade }
      t.integer :status, default: 0
      t.integer :round

      t.timestamps
    end
  end
end
