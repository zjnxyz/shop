module ApplicationHelper
  def format_date(aDatetime)
    if aDatetime
      aDatetime.strftime('%Y-%m-%d')
    else
      ''
    end
  end

  def img_url (img_url)
    #img_url="img/sample1.png"
    if img_url == nil || img_url == ""
      "sample1.png"
    else
      img_url
    end
  end

  def format_data(data)

    if data == nil
      0
    else
      data
    end 
  end

end
