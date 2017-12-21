module UsersHelper
    #Returns the Gravatar for the given User
    def gravatar_for(user, options = { size: 100, img_class: '' })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        img_class = options[:img_class]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: img_class)
    end
    
    def user_img(user, options = { size: 100, img_class: '' })
        size = options[:size]
        img_class = options[:img_class]
        user.picture.file? ? image_tag(user.picture.url(:thumb), class: img_class, size: "#{size}") : gravatar_for(user, img_class: img_class, size: size)
    end
end
