class SurveyResponsesController < ApplicationController
  # GET /survey_responses
  # GET /survey_responses.json
  def index
    @survey = Survey.find(params[:survey_id])
    @survey_responses = SurveyResponse.all
    @random_sample = @survey_responses.nil? ? nil : @survey_responses.sample(random:1)
    convert_responses(@survey_responses)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @survey_responses }
    end
  end
  
  def export_csv
    @survey = Survey.find(params[:survey_id])
    @survey_responses = SurveyResponse.all
    
    convert_responses(@survey_responses)
    @field_values = extract_field_values_from_responses([params[:question_id]])
    
  end

  # GET /survey_responses/1
  # GET /survey_responses/1.json
  def show
    @survey_response = SurveyResponse.find(params[:id])
    
    convert_responses([@survey_response])

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
        format.html { redirect_to survey_survey_responses_path(params[:survey_id]), notice: 'Survey response was successfully created.' }
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
        format.html { redirect_to survey_survey_responses_path(params[:survey_id]), notice: 'Survey response was successfully updated.' }
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
      format.html { redirect_to survey_survey_responses_path(params[:survey_id]) }
      format.json { head :no_content }
    end
  end
  
  def convert_responses(survey_responses)
    @responses = []
    x = 0

    survey_responses.each do |survey_response|

      x += 1
      @responses[x] = []
      
      survey_response.survey_responses.each do |question,response|
        
        if (Question.find(question.to_i).question_type.single_option? && response.to_i > 0)
          @responses[x].push([ Question.find(question.to_i),AnswerOption.find(response.to_i) ])
        else
          if(Question.find(question.to_i).question_type.multi_option?)
            
            options = response[1..response.length-2].split(',')
            translated_options = options.map{ |x| AnswerOption.find(x.gsub(' ','').gsub('"','').to_i) unless x == " \"\"" }.compact
            @responses[x].push([ Question.find(question.to_i), translated_options ])
            
          else
            @responses[x].push([ Question.find(question.to_i), response ])
          end
        end
      end
      
      @responses[x] = @responses[x].sort_by{ |r| r[0].order_num.nil? ? 0 : r[0].order_num}  
    end
    
    @responses.each do |r|
      if r.nil?
        @responses.delete r
      end
    end
  end
  
  def extract_field_values_from_responses(question_ids)
    question_responses = []
    
    question_ids.each do |question_id|
      field_values = []
      question_id = question_id.to_s
      @survey_responses.map do |resp|
        if(resp.survey_responses[question_id] != nil)
          question = Question.find(question_id.to_i)
          val = ""
          if(question.question_type.single_option? && resp.survey_responses[question_id].to_i != 0)
            val = AnswerOption.find(resp.survey_responses[question_id].to_i).option_text
          elsif(question.question_type.multi_option? && resp.survey_responses[question_id].to_i != 0)
            val = AnswerOption.find(resp.survey_responses[question_id].to_i).option_text
          else
            val = resp.survey_responses[question_id]
          end
          
          if(val != nil)
            field_values << val
          end
        end
      end
      
      if(field_values.count > 0)
        question_responses << field_values
      end
    end
    
    return question_responses
  end
end
