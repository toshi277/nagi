class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def top
  end
end


