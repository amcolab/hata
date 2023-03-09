module ApplicationHelper
  def set_ranking_text_color
    { 0 => 'text-pink', 1 => 'text-blue' }
  end

  def set_screen_header_text
    { 'answer' => 'お題', 'assessment' => '採点', 'ranking' => '結果' }
  end
end
