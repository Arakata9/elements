class ToppagesController < ApplicationController
  def index
    if logged_in?
      @diary = current_user.diaries.build  # form_with 用、あたらしい日記を作成
      @diaries = current_user.feed_diaries.order(id: :desc).page(params[:page]) #一覧表示
    end
  end
end
