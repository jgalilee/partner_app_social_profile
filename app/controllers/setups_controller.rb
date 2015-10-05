class SetupsController < ApplicationController

  def new
    @setup = Setup.first
    if @setup.present?
      redirect_to edit_setup_url
    end
    @setup = Setup.new
  end

  def create
    @setup = Setup.new(update_setup_params)
    if @setup.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @setup = Setup.first
    if @setup.blank?
      redirect_to new_setup_url
    end
  end

  def update
    @setup = Setup.first
    @setup.update(update_setup_params)
  end

  protected

  def update_setup_params
    params.require(:setup).permit(:app_id, :secret_key, :root_url)
  end

end
