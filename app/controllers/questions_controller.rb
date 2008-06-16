class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  before_filter :login_required, :only => [:update, :edit, :destroy]
  before_filter :set_body_id
  
  def ask
    @questions = Question.recent
    @question = Question.new
    @questioner = Questioner.new
    @show_header = true
    @body_id = "home"
  end
  
  def index
    @questions = Question.find(:all, :order => "created_at desc")
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @question.to_xml }
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1;edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @questioner = Questioner.new(params[:questioner])
    @question = @questioner.build_question(params[:question])
    
    if @questioner.save
      flash[:notice] = 'Thanks for asking!'
      flash.discard(:notice)
      @questions = Question.recent
    else
      #
      @questions = Question.recent
      
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to question_url(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors.to_xml }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    question = Question.find(params[:id])
    row_id = dom_id(question)
    question.destroy

    if question.destroy
      flash[:notice] = "Question deleted"
      flash.discard(:notice)
      render_flash do |page|
        page.delay(2) { page.visual_effect :fade, row_id, :duration => 2 }
      end
    else
      flash[:error] = "Question was not deleted"
      flash.discard(:error)
      render_flash
    end
  end
  
private

  def set_body_id
    @body_id = "questions"
  end
end
