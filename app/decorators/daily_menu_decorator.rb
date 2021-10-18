class DailyMenuDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    object.created_at.strftime("%d %b %Y")
  end
end
