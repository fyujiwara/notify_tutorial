module Notifiable
  def notify_recipient
    raise NotImplementedError
  end

  def notify_title
    raise NotImplementedError
  end

  def notify_body
    raise NotImplementedError
  end

end
