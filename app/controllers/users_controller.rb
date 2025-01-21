class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create]
    # ユーザー新規登録画面へ行くメソッド
    def new
        @user = User.new
    end
    # ユーザー登録するメソッド
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path, success: t('users.registration.success')
      else
        flash.now[:danger] = t('users.registration.failure')
        render :new, status: :unprocessable_entity
        # ●renderについて
        # 指定されたビューテンプレートの内容をクライアントに返し、現在のウェブページを更新する
        # この操作は新しいページへの移動を伴わずに行われ、サーバーは直接HTMLをレスポンスとして送信する
        # ユーザーの入力エラーがあった場合に特に有効で、redirect_toが新しいHTTPリクエストを生成しフォームデータを失うのに対し、
        # renderは現在のHTTPリクエスト内でビューを直接表示し、入力データを保持する

        # status: :unprocessable_entity とは
        # HTTPステータスコード422を返すことを示す。このステータスは、リクエストがサーバーに受け付けられたものの、
        # リクエスト内容に含まれるデータが不適切なために処理できないことを示す。
        # バリデーションエラーやフォーマットエラーなどが原因で、リソースを正しく処理できない場合に使用される。
      end
    end

    private
    # ストロングパラメーターの箇所
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
