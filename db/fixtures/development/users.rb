10.times do |i|
  User.seed(:id) do |s|
    s.id    = i + 1
    s.name = "user#{i + 1}"
  end
end
