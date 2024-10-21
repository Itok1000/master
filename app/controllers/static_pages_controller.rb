class StaticPagesController < ApplicationController
    # トップページやジョージアページなどはログイン不要
    skip_before_action :require_login, only: %i[top georgia food]
    def top; end
    # georgiaアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def georgia; end
    # foodアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def food; end

    # 各料理掲示板一覧アクションを追加して、レンダリングするようにする
    def ojakhuri; end
    def badrijani; end
    def food; end
    def food; end
    def food; end
    def food; end
    def food; end
    def food; end
end
