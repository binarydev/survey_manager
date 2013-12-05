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
    @questions = extract_questions_from_responses(params[:question_id])
    @field_values = extract_field_values_from_responses([params[:question_id]])
    @field_values.each do |respondent|
      respondent.each do |response|
        if(response.is_a? Array)
          response = response.join(",")
        end
      end
    end
    
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
      
      # FINAL FORMAT = @responses[index of survey response submission][index of response to question][index of either question (0) or answer(1)]
      
      @responses[x] = []
      
      survey_response.survey_responses.each do |question,response|
        
        if (Question.find(question.to_i).question_type.single_option? && response.to_i > 0)
          @responses[x].push([ Question.find(question.to_i),AnswerOption.find(response.to_i) ])
        else
          if(Question.find(question.to_i).question_type.multi_option?)
            
            options = response[1..response.length-2].split(',')
            translated_options = options.map{ |x| AnswerOption.find(x.gsub(' ','').gsub('"','').to_i) unless x.gsub(' ','').gsub('"','').to_i == 0 }.compact
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
      
    @responses.each do |respondent|
      field_values = []
      respondent.each do |resp|
        
        val = ""
        
        if(val != nil || resp[1] != nil)
          if(resp[1].is_a? Array)
            resp[1].each do |option|
              if option != resp[1].last
                val = "#{val}#{option.option_text},"
              else
                val = "#{val}#{option.option_text}"
              end
            end
          elsif resp[1].is_a? AnswerOption
            val = resp[1].option_text
          elsif resp[1].is_a? String || resp[1].to_i != 0
            val = resp[1]
          end            
          
          field_values << val

        else
          field_values << ""
        end
      end
      if(field_values.count > 0)
        question_responses << field_values
      end
    end

    
    return question_responses
  end
  
  def extract_questions_from_responses(question_ids)
    questions = []
      
    @responses.last.each do |resp|
      val = ""
      if(resp[0] != nil)
        val = resp[0].question_text
      end        
      questions << val
    end

    
    return questions
  end
end