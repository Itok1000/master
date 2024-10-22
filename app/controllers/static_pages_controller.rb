class StaticPagesController < ApplicationController
    # トップページやジョージアページなどはログイン不要
    skip_before_action :require_login, only: %i[top georgia food]
    def top; end
    # georgiaアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def georgia; end
    # foodアクションを追加して、app/views/static_pages/georgia.html.erbをレンダリングするようにする
    def food; end

    # 各料理掲示板一覧アクションを追加して、レンダリングするようにする
    def details
        @recipe = params[:recipe]

        # 料理に応じた情報をハッシュで定義
        recipes = {
          "ojakhuri" => { name: "オジャフリ", image: "Answer01.png", description: I18n.t("diagnoses.description.ojakhuri2") },
          "badrijani" => { name: "パドリジャーニ", image: "Answer02.png", description: I18n.t("diagnoses.description.badrijani2") },
          "sokos" => { name: "ソコスチャシュシュリ", image: "Answer03.png", description: I18n.t("diagnoses.description.sokos_chashushuli2") },
          "pkhali" => { name: "プパリ", image: "Answer04.png", description: I18n.t("diagnoses.description.pkhali5") },
          "ostri" => { name: "オーストリ", image: "Answer05.png", description: I18n.t("diagnoses.description.ostri2") },
          "chikirtma" => { name: "チヒルトゥマ", image: "Answer06.png", description: I18n.t("diagnoses.description.chikirtma3") },
          "shkmeruli" => { name: "シュクメルリ", image: "Answer07.png", description: I18n.t("diagnoses.description.shkmeruli4") },
          "chakhohbili" => { name: "チャホフビリ", image: "Answer08.png", description: I18n.t("diagnoses.description.chakhohbili2") }
        }

        @recipe_info = recipes[@recipe]
    end
end
