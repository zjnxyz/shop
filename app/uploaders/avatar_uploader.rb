# coding: utf-8
class AvatarUploader < BaseUploader
  
  version :thumb do
    process :resize_to_fill => [50,50]
    process :strip
  end
  version :thumb_medium do
    process :resize_to_fill => [100,100]
    process :strip
  end
  version :thumb_large do
    process :resize_to_limit => [300,300]
    process :strip
  end
  # version :scaled_full do
  #   process :resize_to_limit => [700,nil]
  #   process :strip
  # end

  def strip
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end

  def filename
    if super.present?
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记，所以它将是唯一的
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension.downcase}"
    end
  end
  
end