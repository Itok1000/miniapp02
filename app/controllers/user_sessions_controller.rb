class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

    def new; end
    # ●loginメソッドについて
    # gem 'sorcery'が提供しているメソッドの1つ
    # ユーザーの認証を行い、指定されたメールアドレスとパスワードがデータベース内のユーザー情報と一致するかどうかを確認する
    # 認証が成功した場合、該当するユーザーはセッションに値をセットされてログイン状態になる
    def create
      @user = login(params[:email], params[:password])

      if @user
        redirect_to notes_path, success: t("user_sessions.login.success")
      else
        flash.now[:danger] = t("user_sessions.login.failure")
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
    # ●redirect_toについて
    # 指定されたURLへユーザーをリダイレクトする
    # リダイレクトはサーバーがクライアントに別のURLへの移動を指示するプロセス
    # このメソッドは通常、アクション完了後にユーザーを適切なページへ導くために使用され、
    # セッション情報の更新や重複データ送信の防止に役立つ
    # 例えば、ログインやログアウト後のリダイレクトはユーザーの認証状態を更新し、その結果を新しいリクエストに即座に反映させる
    def destroy
      logout
      redirect_to root_path, danger: t("user_sessions.logout.success"), status: :see_other
    end
  # ●redirect_toについて
  # 指定されたURLへユーザーをリダイレクトする
  # リダイレクトはサーバーがクライアントに別のURLへの移動を指示するプロセス
  # このメソッドは通常、アクション完了後にユーザーを適切なページへ導くために使用され、
  # セッション情報の更新や重複データ送信の防止に役立つ
  # 例えば、ログインやログアウト後のリダイレクトはユーザーの認証状態を更新し、その結果を新しいリクエストに即座に反映させる

  # ●status: :see_otherについて
  # HTTPステータスコード303 "See Other"はリダイレクトを指示するコード
  # このステータスはリソースが一時的に別のURIに移動されたことを示し、クライアントにGETメソッドでそのURIを取得するよう指示する
  # Railsのredirect_toメソッドでstatus: :see_otherを指定すると、POSTリクエスト後の新しいページへのGETリクエスト移動が促され、
  # フォームの再送信を防ぐ
  # status: :see_otherを指定しない場合、リダイレクト後もブラウザがPOSTメソッドを保持し続け、予期せぬ挙動に繋がる恐れがある
end

# ●skip_before_action について
# skip_before_action はRailsのコントローラーにおいて特定のアクションが実行される前に設定されたフィルターをスキップするために使用される
# これにより、特定のアクションでフィルターを適用しないように指定できる
# ログインアクションが実行される前に新規ユーザー登録のページ（new アクション）やユーザー登録処理（create アクション）機能をスキップする
