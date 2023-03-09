class AddDefaultValueToQuestionsCurrentRound < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :current_round, :integer, default: 0
  end
end
