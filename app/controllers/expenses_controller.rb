class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  

  # GET /expenses
  # GET /expenses.json
  def index
     @expenses = Expense.all
    @search = Expense.search do
      fulltext params[:search]
      
      
    end
    @expenses = @search.results
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
         @expenses = Expense.find(params[:id])
        # @expenses = @user.expense.find(params[:id])
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    respond_to do |format|
      format.html
      
    end
  end

  # GET /expenses/1/edit
  def edit  
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    # @expense = Expense.new(expense_params)
    @expense = current_user.expenses.build(expense_params)
     params[:email] = @expense.user[:email]
     binding.pry
    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_path, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        # format.html { render :new }
        # format.json { render json: @expense.errors, status: :unprocessable_entity }
        
        render 'pages/home'
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update

    respond_to do |format|
      if @expense.update(expense_params)
        flash[:notice] = 'Expense was successfully updated.'
        format.html { redirect_to(@expense) }
        format.xml  { head :ok }
        # format.html { redirect_to @expenses, notice: 'Expense was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    Expense.find(params[:id]).destroy
    flash[:success] = "Expense destroyed."
    redirect_to expenses_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:merchant, :date,  :password, :confirm_password, :email_id, :comment, :category, :total, :reimbursable, :billable)
    end

    private
    def authorized_user
      @expense = current_user.expenses.find_by_id(params[:id])
      redirect_to root_path if @expense.nil
    end
end
