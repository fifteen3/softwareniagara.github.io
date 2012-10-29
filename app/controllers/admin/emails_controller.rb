class Admin::EmailsController < Admin::ApplicationController
  before_filter :get_emails, only: [:index]
  before_filter :get_email, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: @emails, status: :ok }
      format.xml { render xml: @emails, status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @email, status: :ok }
      format.xml { render xml: @email, status: :ok }
    end
  end

  def new
    @email = Email.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @email = Email.new(params[:email])

    respond_to do |format|
      if @email.save
        format.html { redirect_to edit_admin_email_path(@email), notice: 'Added email recipient.' }
        format.json { render json: @email, status: :created }
        format.xml { render xml: @email, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @email.errors, status: :unprocessable_entity }
        format.xml { render xml: @email.errors, status: :unprocessable_entity }
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
      if @email.update_attributes(params[:email])
        format.html { redirect_to edit_admin_email_path(@email), notice: 'Updated email recipient.' }
        format.json { render json: @email, status: :ok }
        format.xml { render xml: @email, status: :ok }
      else
        format.html { render 'edit' }
        format.json { render json: @email.errors, status: :unprocessable_entity }
        format.xml { render xml: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email.destroy

    respond_to do |format|
      format.html { redirect_to admin_emails_path, notice: 'Email recipient deleted.' }
      format.json { render json: @email, status: :deleted }
      format.xml { render xml: @email, status: :deleted }
    end
  end

  private

  def get_emails
    @emails = Email.page params[:page]
  end

  def get_email
    @email = Email.find(params[:id]) || nil
  end
end