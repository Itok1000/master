class DiagnosesController < ApplicationController
  # 診断機能はログインなしで使用できるようにする
  skip_before_action :require_login, only: %i[new create show]

  def new
    @diagnosis = Diagnosis.new
  end

  def show
    @diagnosis = Diagnosis.find(params[:id])

    # 診断結果に対応する料理名を設定
    recipe_names = {
      "111" => "シュクメルリ",
      "112" => "オジャフリ",
      "121" => "オーストリ",
      "122" => "ソコスチャシュシュリ",
      "211" => "チャホフビリ",
      "212" => "パドリジャーニ",
      "221" => "チヒルトゥマ",
      "222" => "プパリ"
    }
    @recipe_name = recipe_names[@diagnosis.question] || "ジョージア料理"

    # メタタグの設定
    set_meta_tags title: "診断結果",
                  description: "おすすめのジョージア料理は #{@recipe_name} です",
                  og: {
                    title: "診断結果",
                    description: "おすすめのジョージア料理は #{@recipe_name} です",
                    image: ogp_image_url(@diagnosis.question), # 動的に生成されたOGP画像のURL
                    url: request.original_url
                  },
                  twitter: {
                    card: "summary_large_image",
                    image: ogp_image_url(@recipe_name)
                  }
  end

  def create
    @diagnosis = Diagnosis.new(diagnosis_params)

    # 部分的に質問が未選択の場合 にもフラッシュメッセージを表示
    if diagnosis_params[:question1].blank? || diagnosis_params[:question2].blank? || diagnosis_params[:question3].blank?
      flash.now[:danger] = t("users.create.diagnoses_null")
      render :new, status: :unprocessable_entity
    else
      # 各質問の回答を連結して一つの文字列にする
      @diagnosis.question = "#{diagnosis_params[:question1]}#{diagnosis_params[:question2]}#{diagnosis_params[:question3]}"

      if @diagnosis.save
        redirect_to diagnosis_path(@diagnosis), success: t("users.create.diagnoses_success")
      end
    end
  end

  private
  # OGP画像のURLを生成するためのメソッドを追加
  def ogp_image_url(question)
    images_ogp_url(text: question)
  end

  def diagnosis_params
    params.require(:diagnosis).permit(:question1, :question2, :question3)
  end
end
