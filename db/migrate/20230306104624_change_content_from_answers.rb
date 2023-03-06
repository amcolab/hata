class ChangeContentFromAnswers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :answers, :content, true
  end
end
