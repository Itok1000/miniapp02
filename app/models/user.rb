class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :user_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
end

# 上記のコードには以下のバリデーションが設けられている 
# マイグレーションファイルに null: false や unique と記載されているにも関わらず、バリデーションにも似た記述を加えるのは、
# エラーハンドリングを改善し、ユーザーにより明確なフィードバックを提供するため 
# モデルバリデーションにより、データベースに到達する前に問題を検出し、処理が可能となる 
# これにより、ビジネスロジックを集中管理することで、コードの再利用性と保守性が向上する 
# また、データベースの制約はデータの整合性とシステムのパフォーマンスを保証する

# ```
# - password；最小で3文字以上必要（新規レコード作成もしくはcrypted_passwordカラムが更新される時のみ適応）
# - password_confirmation：値が空でないこと・passwordの値と一致すること（新規レコード作成もしくはcrypted_passwordカラムが更新される時のみ適応）
# - user_name：値が空でないこと・最大255文字以下であること
# - email：値が空でないこと・ユニークな値であること
# ```
