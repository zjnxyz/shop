# coding: utf-8
module StaffsHelper
  def staff_type (staff_type)
    if staff_type == 1
      "管理员"
    else
      "业务员"
    end
  end

  def staff_img_url (img_url)
    if img_url == ""
      "sample1.png"
    else
      img_url
    end
  end

  def staff_sex (sex)
    if sex == 1
      "男"
    else
      "女"
    end
  end

  def format_date(aDatetime)
    if aDatetime
      aDatetime.strftime('%Y-%m-%d')
    else
      ''
    end
  end
end
