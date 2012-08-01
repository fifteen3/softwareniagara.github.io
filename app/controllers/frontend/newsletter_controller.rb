class Frontend::NewsletterController < Frontend::ApplicationController
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
        format.html { redirect_to root_path, notice: 'Thank you for signing up to our newsletter.' }
        format.json { render json: @email, status: :created }
        format.xml { render xml: @email, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @email.errors, status: :unprocessable_entity }
        format.xml { render xml: @email.errors, status: :unprocessable_entity }
      end
    end
  end
end