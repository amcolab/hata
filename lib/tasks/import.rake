require 'csv'
desc "Import product from csv file"
task import: :environment do
  csv_text = File.read(Rails.root + 'public/questions.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    puts row
    Question.create!(row.to_hash)
  end
end
