class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase #params[:session][:email] のように二段階で指定して取得
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user #@user の users#show へとリダイレクト
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new' #sessions/new.html.erb を再表示
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password) #if @user によって、@user が存在するかを確認し、@user.authenticate(password) でパスワード確認
      # ログイン成功
      session[:user_id] = @user.id #ブラウザには Cookie として、サーバには Session として、ログイン状態が維持される
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
