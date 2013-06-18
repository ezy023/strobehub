module ApplicationHelper
  def get_random_image
   image_exts = %w( .jpg .gif .png )
    all_files = Dir.entries('app/assets/images/backgrounds')
    image_files = all_files.delete_if{|x| !image_exts.include?(x[-4..-1])}
    "/assets/backgrounds/#{image_files.sample}"
  end
end
