class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # ●require_login について
  # gem 'sorcery' が提供するメソッドの一つで、ユーザーがログインしているかどうかを判定する
  # ログインしていない場合は、not_authenticated メソッドで指定されたパスにリダイレクトする
  # （デフォルトでは root_path にリダイレクトされます）

  # ●before_action について
  # アクションが実行される前に指定されたメソッドを呼び出す
  # application_controller.rb に記述することで、ApplicationController クラスを継承しているすべてのコントローラで
  # before_action が適用される
  before_action :require_login

  add_flash_types :success, :danger
  # add_flash_types とは、
  # フラッシュメッセージのタイプを追加するメソッド

  private

  def not_authenticated
    redirect_to login_path, danger: t("defaults.flash_message.require_login")
  end
end
# ●not_authenticatedメソッドについて
# gem 'sorcery' が提供するもので、ログインしていない場合に指定されたパスにリダイレクトする
# application_controller.rb でこのメソッドをオーバーライドすることで、デフォルトのリダイレクト先を
# root_path から login_path に変更している
