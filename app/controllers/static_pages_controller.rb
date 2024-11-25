class StaticPagesController < ApplicationController
    # トップページやジョージアページなどはログイン不要
    skip_before_action :require_login, only: %i[top georgia food how_to_use]
    def top; end
    # georgiaアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def georgia; end
    # foodアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def food; end
    # how_to_useアクションを追加して、app/views/static_pages/how_to_use.html.erbをレンダリングするようにする
    def how_to_use; end
end
