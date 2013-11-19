class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.order(:order_num).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
    gon.orderPostPath = survey_question_answer_options_bulk_update_order_path(params[:survey_id], params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    @survey = Survey.find(params[:survey_id])
    @question.required_field = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @survey = Survey.find(params[:survey_id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])
    @question.survey_id = params[:survey_id]
    respond_to do |format|
      if @question.save
        
        if (@question.question_type.short_text? || @question.question_type.open_ended_text?)
          path = survey_path(params[:survey_id])
        else
          path = survey_question_path(params[:survey_id],@question.id)
        end
        format.html { redirect_to path, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        if (@question.question_type.short_text? || @question.question_type.open_ended_text?)
          path = survey_path(params[:survey_id])
        else
          path = survey_question_path(params[:survey_id],@question.id)
        end
        format.html { redirect_to path, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
  
  def bulk_update_order
    
    question = nil
    failed = false
    
    params[:items].each_with_index do |item,index|      
      question = Question.find(item)
      question.order_num = index
      question.save!
    end

    params[:items].each_with_index do |item,index|
      question = Question.find(item)
      if question.order_num != index + 1
        failed = true
      end
    end

    if failed == false
      render :json => {:result => :success}
    else
      render :json => {:result => :failed}
    end
  end

end
