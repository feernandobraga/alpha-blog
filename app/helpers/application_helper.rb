module ApplicationHelper

  def gravatar_for(user, options = {size:80})

    # the method will take two paramenters: user and a HASH variable called options.
    # the hash options has a key called size and the value of 80


    #from gravatar's documentation we found that gravatar's url are based on a
    # md5 hash of the user's email address.
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)


    size = options[:size]
    # now we retireve the value from the hash options and the key size


    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # we then create a variable that has the variable with the ID hashed and the size


    # image_tag is what the gravatar_for method will return
    # so it will basically create the following HTML block:
    # <img alt="fernando" class="rounded-circle" src="https://secure.gravatar.com/avatar/6e277f34403f3e529ae8031a9601a0dc?s=150">
    image_tag(gravatar_url, alt: user.username, class: "rounded-circle")


  end # end gravatar



end
