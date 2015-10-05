class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def root
    if Setup.first.present?
      redirect_to index_url
    else
      redirect_to new_setup_url
    end
  end

end
