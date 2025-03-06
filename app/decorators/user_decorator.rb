class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    object.user_name
  end
end
# delegate_all
# decoratorクラスが元のオブジェクトのすべてのメソッドを使えるようにするためのもの
# decoratorを通じて、元のオブジェクトのメソッドをそのまま呼び出せるようにしてくれる
# これにより、decoratorに追加した新しいメソッドだけでなく、元のオブジェクトのメソッドもdecorator経由で使うことができる

# full_name メソッドの中に記述してある object について
# decoratorがラップしている元のオブジェクトを指す
# UserDecoratorの場合、object は Userモデルのインスタンス
# full_name メソッド内で object を使うことで、Userオブジェクトのプロパティやメソッドにアクセスし、
# 表示用のロジックを追加することができる
# ※ラップとは...あるオブジェクトや関数を別のオブジェクトや関数で包み込むこと
# これにより、新しい機能を追加したり、元の振る舞いを変更したりすることができる
