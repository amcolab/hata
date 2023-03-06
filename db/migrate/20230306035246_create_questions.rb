class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :content, null: false
      t.integer :status, default: 0
      t.datetime :time_start
      t.integer :current_round

      t.timestamps
    end
  end
end
