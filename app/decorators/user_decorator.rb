class UserDecorator < Draper::Decorator
  delegate_all
  # decoratorクラスが元のオブジェクトのすべてのメソッドを使えるようにするためのもの
  # decoratorを通じて、元のオブジェクトのメソッドをそのまま呼び出せるようにしてくれる
  # ユーザーのフルネームを表示するメソッド
  def full_name
    object.user_name # ここで user_name を返す
  end
end
