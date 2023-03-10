require 'csv'
desc "Import product from csv file"
task import_questions: :environment do
  csv_text = File.read(Rails.root + 'db/master_data/questions.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Question.create!(row.to_hash)
  end
end
