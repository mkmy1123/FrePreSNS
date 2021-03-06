module UsersHelper
  def avatar?(user)
    if user.avatar?
      image_tag user.avatar.to_s
    else
      image_tag asset_path("default.jpg"), :size => '100x100'
    end
  end

  def half_avatar?(user)
    if user.avatar?
      image_tag user.avatar.to_s, :size => '50x50'
    else
      image_tag asset_path("default.jpg"), :size => '50x50'
    end
  end
end
