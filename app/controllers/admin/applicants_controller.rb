class Admin::ApplicantsController < Admin::ApplicationController
  before_filter :get_applicants, only: [:index]
  before_filter :get_applicant, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: @applicants, status: :ok }
      format.xml { render xml: @applicants, status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @applicant, status: :ok }
      format.xml { render xml: @applicant, status: :ok }
    end
  end

  def new
    @applicant = Applicant.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @applicant = Applicant.new(params[:applicants])

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to edit_admin_applicant_path(@applicant), notice: 'Added applicants.' }
        format.json { render json: @applicant, status: :created }
        format.xml { render xml: @applicant, status: :created }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @applicant.update_attributes(params[:applicant])
        format.html { redirect_to edit_admin_applicant_path(@applicant), notice: 'Updated applicants.' }
        format.json { render json: @applicant, status: :ok }
        format.xml { render xml: @applicant, status: :ok }
      else
        format.html { render 'edit' }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
        foramt.xml { render xml: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @applicant.destroy

    respond_to do |format|
      format.html { redirect_to admin_applicants_path, notice: 'Applicant deleted.' }
      format.json { render json: @applicant, status: :deleted }
      format.xml { render xml: @applicant, status: :deleted }
    end
  end

  private

  def get_applicants
    @applicants = Applicant.page params[:page]
  end

  def get_applicant
    @applicant = Applicant.find(params[:id]) || nil
  end
end