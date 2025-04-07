class QuizzesController < ApplicationController
    skip_before_action :require_login, only: [:index, :new, :create ]
    def index
      @correct_count = session[:correct_count]
      @questions = Question.all
    end

    def new
      if !params[:count]
        session[:correct_count] = 0
      end
      quiz_count = params[:count] || 1
      @quiz = Quiz.new
      @question = Question.find(quiz_count)
    end

    def create
      @question = Question.find(quiz_params[:question_id])
      @select_answers = quiz_params[:selected_answers]
      @is_correct = @question.answers.sort == @select_answers.sort
      @questions_count = Question.all.count
      session[:correct_count] = session[:correct_count].to_i + 1 if @is_correct
    end

    private

    def quiz_params
      params.require(:quiz).permit(:question_id, selected_answers: [])
    end
end
