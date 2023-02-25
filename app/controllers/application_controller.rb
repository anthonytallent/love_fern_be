class ApplicationController < ActionController::API
  before_action :check_api_key

  def check_api_key
    unless request.headers.env["FErn_key"] == ENV["FErn_key"]
      render status :unauthorized
    end
  end
end
