class FacebookProfileFactory < ProfileFactory

  def initialize(id, profile_data)
    super(:facebook, id, profile_data)
  end

end
