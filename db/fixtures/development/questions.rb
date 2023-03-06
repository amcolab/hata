600.times do |i|
  Question.seed(:id) do |s|
    s.id    = i + 1
    s.content = "sample content for question #{i + 1}"
    s.current_round = 1
  end
end
