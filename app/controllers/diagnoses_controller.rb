class DiagnosesController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def new
    @diagnosis = Diagnosis.new
  end

  def show
    @diagnosis = Diagnosis.find(params[:id])

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

    set_meta_tags title: "診断結果",
                  description: "おすすめのジョージア料理は #{@recipe_name} です",
                  og: {
                    title: "診断結果",
                    description: "おすすめのジョージア料理は #{@recipe_name} です",
                    image: ogp_image_url(@diagnosis.question),
                    url: request.original_url
                  },
                  twitter: {
                    card: "summary_large_image",
                    image: ogp_image_url(@recipe_name)
                  }
  end

  def create
    @diagnosis = Diagnosis.new(diagnosis_params)

    if diagnosis_params[:question1].blank? || diagnosis_params[:question2].blank? || diagnosis_params[:question3].blank?
      flash.now[:danger] = t("diagnoses.new.diagnoses_null")
      render :new, status: :unprocessable_entity
    elsif diagnosis_params[:question1].blank? && diagnosis_params[:question2].blank? && diagnosis_params[:question3].blank?
      flash.now[:danger] = t("diagnoses.new.diagnoses_null")
      render :new, status: :unprocessable_entity
    else
      @diagnosis.question = "#{diagnosis_params[:question1]}#{diagnosis_params[:question2]}#{diagnosis_params[:question3]}"

      if @diagnosis.save
        redirect_to diagnosis_path(@diagnosis), success: t("diagnoses.new.diagnoses_success")
      end
    end
  end

  private
  def ogp_image_url(question)
    images_ogp_url(text: question)
  end

  def diagnosis_params
    params.require(:diagnosis).permit(:question1, :question2, :question3)
  end
end
