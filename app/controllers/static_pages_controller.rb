class StaticPagesController < ApplicationController
    skip_before_action :require_login, only: %i[top how_to_use]

    def top; end

    def how_to_use; end
end

# ●skip_before_action について
# skip_before_action はRailsのコントローラーにおいて特定のアクションが実行される前に設定されたフィルターをスキップするために使用される
# これにより、特定のアクションでフィルターを適用しないように指定できる
# ログインアクションが実行される前に指定されたメソッドを呼び出す機能をスキップする
