class AnswersController < ApplicationController
  before_filter :get_question
  before_filter :login_required, :except => :show
  
  # GET /answers/new
  def new
    @answer = @question.build_answer
  end
  
  def show
    @answer = @question.answer
  end

  # GET /answers/1;edit
  def edit
    @answer = @question.answer
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = @question.build_answer(params[:answer].merge(:user_id => session[:user]))
    if @answer.save
      flash[:notice] = 'Answer recorded'
      redirect_to questions_path
    else
      flash[:error] = 'Answer not saved'
      render :action => "new"
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = @question.answer

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        flash[:notice] = 'Answer was successfully updated.'
        format.html { redirect_to answer_url(@question, @answer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors.to_xml }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = @question.answer
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url(@question) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def get_question
    @question = Question.find(params[:question_id])
  end
end
