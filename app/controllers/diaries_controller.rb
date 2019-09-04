class DiariesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy] #削除前に確認
  
  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @diaries = current_user.diaries.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @diary.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def diary_params
    params.require(:diary).permit(:content)
  end
  
  def correct_user #ログインユーザが所有しているものかを確認
    @diary = current_user.diaries.find_by(id: params[:id])
    unless @diary
      redirect_to root_url
    end
  end
end
