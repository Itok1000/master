class DiagnosesController < ApplicationController
    def index
      # 必要なら、診断一覧の表示をここで実装
    end

    def new
      @diagnosis = Diagnosis.new
    end

    def show
      @diagnosis = Diagnosis.find(params[:id]) # find_byではなくfindで確実にIDで検索
    end

    def create
      @diagnosis = Diagnosis.new(diagnosis_params)

      # 質問の回答を連結して1つの文字列にする処理
      if params[:diagnosis][:question].present?
        @diagnosis.question = params[:diagnosis][:question].join("")
      end

      if @diagnosis.save
        flash[:notice] = "診断が完了しました"
        redirect_to diagnosis_path(@diagnosis.id)
      else
        flash[:alert] = "診断に失敗しました"
        render :new
      end
    end

  private
    def diagnosis_params
      params.require(:diagnosis).permit(:question1, :question2, :question3, question: [])
    end
end
