class DiagnosesController < ApplicationController
  def new
    @diagnosis = Diagnosis.new
  end

  def show
    @diagnosis = Diagnosis.find(params[:id])
  end

  def create
    @diagnosis = Diagnosis.new(diagnosis_params)

    # すべての質問が回答されているかチェック
    if diagnosis_params[:question1].blank? || diagnosis_params[:question2].blank? || diagnosis_params[:question3].blank?
      flash[:alert] = "選択されていない回答があります"
      render :new
    else
      # 各質問の回答を連結して一つの文字列にする
      @diagnosis.question = "#{diagnosis_params[:question1]}#{diagnosis_params[:question2]}#{diagnosis_params[:question3]}"

      if @diagnosis.save
        flash[:notice] = "診断が完了しました"
        redirect_to diagnosis_path(@diagnosis)
      else
        flash[:alert] = "診断に失敗しました"
        render :new
      end
    end
  end

  private

  def diagnosis_params
    params.require(:diagnosis).permit(:question1, :question2, :question3)
  end
end
