module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) #既に現在のログインユーザが代入されていたら何もせず、
                                                          #代入されていなかったらログインユーザを取得
  end

  def logged_in?
    !!current_user
  end
end