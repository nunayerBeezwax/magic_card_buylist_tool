class QuestionsController < ApplicationController

  def create
    @question = Question.create(question_params)
    redirect_to :back
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.all.last
    @question.find_the_answer
    redirect_to :back
  end

private
  def question_params
    params.require(:question).permit(:text, :choice1, :choice2, :choice3, :choice4)
  end
end
