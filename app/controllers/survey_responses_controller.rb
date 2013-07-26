class SurveyResponsesController < ApplicationController
  # GET /survey_responses
  # GET /survey_responses.json
  def index
    @survey_responses = SurveyResponse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @survey_responses }
    end
  end

  # GET /survey_responses/1
  # GET /survey_responses/1.json
  def show
    @survey_response = SurveyResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey_response }
    end
  end

  # GET /survey_responses/new
  # GET /survey_responses/new.json
  def new
    @survey_response = SurveyResponse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey_response }
    end
  end

  # GET /survey_responses/1/edit
  def edit
    @survey_response = SurveyResponse.find(params[:id])
  end

  # POST /survey_responses
  # POST /survey_responses.json
  def create
    @survey_response = SurveyResponse.new(params[:survey_response])

    respond_to do |format|
      if @survey_response.save
        format.html { redirect_to @survey_response, notice: 'Survey response was successfully created.' }
        format.json { render json: @survey_response, status: :created, location: @survey_response }
      else
        format.html { render action: "new" }
        format.json { render json: @survey_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /survey_responses/1
  # PUT /survey_responses/1.json
  def update
    @survey_response = SurveyResponse.find(params[:id])

    respond_to do |format|
      if @survey_response.update_attributes(params[:survey_response])
        format.html { redirect_to @survey_response, notice: 'Survey response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_responses/1
  # DELETE /survey_responses/1.json
  def destroy
    @survey_response = SurveyResponse.find(params[:id])
    @survey_response.destroy

    respond_to do |format|
      format.html { redirect_to survey_responses_url }
      format.json { head :no_content }
    end
  end
end
