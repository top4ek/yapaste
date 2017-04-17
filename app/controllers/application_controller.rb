class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def paginate(relation)
    relation.page(params[:page]).per(10)
  end
end
