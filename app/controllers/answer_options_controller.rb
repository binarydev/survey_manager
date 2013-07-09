class AnswerOptionsController < ApplicationController
  # GET /answer_options
  # GET /answer_options.json
  def index
    @answer_options = AnswerOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answer_options }
    end
  end

  # GET /answer_options/1
  # GET /answer_options/1.json
  def show
    @answer_option = AnswerOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer_option }
    end
  end

  # GET /answer_options/new
  # GET /answer_options/new.json
  def new
    @answer_option = AnswerOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer_option }
    end
  end

  # GET /answer_options/1/edit
  def edit
    @answer_option = AnswerOption.find(params[:id])
  end

  # POST /answer_options
  # POST /answer_options.json
  def create
    @answer_option = AnswerOption.new(params[:answer_option])

    respond_to do |format|
      if @answer_option.save
        format.html { redirect_to @answer_option, notice: 'Answer option was successfully created.' }
        format.json { render json: @answer_option, status: :created, location: @answer_option }
      else
        format.html { render action: "new" }
        format.json { render json: @answer_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /answer_options/1
  # PUT /answer_options/1.json
  def update
    @answer_option = AnswerOption.find(params[:id])

    respond_to do |format|
      if @answer_option.update_attributes(params[:answer_option])
        format.html { redirect_to @answer_option, notice: 'Answer option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer_options/1
  # DELETE /answer_options/1.json
  def destroy
    @answer_option = AnswerOption.find(params[:id])
    @answer_option.destroy

    respond_to do |format|
      format.html { redirect_to answer_options_url }
      format.json { head :no_content }
    end
  end
end
