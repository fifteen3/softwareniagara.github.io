class Frontend::ApplicantsController  < Frontend::ApplicationController
  def new
    @applicant = Applicant.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @applicant = Applicant.new(params[:applicant])

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to root_path, notice: 'Thank you for applying to speak at an upcoming event.' }
        format.json { render json: @applicant, status: :created }
        format.xml { render xml: @applicant, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
        format.xml { render xml: @applicant.erros, status: :unprocessable_entity }
      end
    end
  end
end