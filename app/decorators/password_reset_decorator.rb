class PasswordResetDecorator < Draper::Decorator
    delegate_all
  # delegate_allは、デコレータに追加されていない機能が呼び出されたときに、その機能を元のオブジェクトに任せるための指定
  # 例えば、友達に電話で質問があるとき、その質問に答えられない場合は、他の友達に質問をまわすようなイメージ
end
