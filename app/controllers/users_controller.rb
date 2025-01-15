class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

    def new
        @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path, success: 'ユーザー登録が完了しました'
      else
        flash.now[:danger] = 'ユーザー登録に失敗しました'
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end
end

# ●skip_before_action について
# skip_before_action はRailsのコントローラーにおいて特定のアクションが実行される前に設定されたフィルターをスキップするために使用される
# これにより、特定のアクションでフィルターを適用しないように指定できる
# ログインアクションが実行される前に新規ユーザー登録のページ（new アクション）やユーザー登録処理（create アクション）機能をスキップする

# ●ストロングパラメーターについて
# Railsでデータを一括で更新する際に、安全に更新するための仕組み
# この仕組みは「ホワイトリスト形式」と呼ばれ、許可された属性のみを受け入れて、不正な属性のデータベースへの保存を防ぐ
# 例えば、user_paramsメソッドでは、requireメソッドを使って:userキーを必須とし、permitメソッドで許可される属性
# （名前、メールアドレス、パスワードなど）を指定しする
# これによりホワイトリストに書かれていない値（例えば ageやaddressなど）は弾かれて、不正なパラメータがデータに影響を与えることを防ぐ
