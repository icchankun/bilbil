module ApplicationHelper
  # タイトルを動的に変化させる。
  def full_title(page_title = '')                     
    base_title = "bilbil"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
