class ExpensesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_expense, only: [:show, :update, :destroy]

    def index
        start_date = params[:start_date].to_date
        end_date = params[:end_date].to_date
        
        if params[:user_id].present?
            if params[:site_id].present?
                @expenses_within_range = current_user.expenses.where(date: start_date..end_date, site_id: params[:site_id])
            else
                @expenses_within_range = current_user.expenses.where(date: start_date..end_date)
            end
        else
            if params[:site_id].present?
                @expenses_within_range = Expense.where(date: start_date..end_date, site_id: params[:site_id])
            else
                render json: { error: "site_id not present" }, status: :unprocessable_entity
                return
            end
        end

        case params[:status]
        when 'all'
            @expenses = @expenses_within_range
        when 'approved'
            @expenses = @expenses_within_range.where(status: 'approved')
        when 'pending'
            @expenses = @expenses_within_range.where(status: 'pending')
        when 'rejected' 
            @expenses = @expenses_within_range.where(status: 'rejected')
        when 'completed'
            @expenses = @expenses_within_range.where(status: 'completed')
        else
            render json: { error: "Invalid status parameter" }, status: :bad_request
            return
        end
        render 'expenses/index'
    end

    def create
        @expense = current_user.expenses.build(expense_params)

        @site = Site.find_by(id: expense_params[:site_id])

        if @site.nil?
            render json: { error: "Site not found" }, status: :not_found
            return
        end

        @expense.site = @site

        if @expense.valid? 
            @expense.save
            render 'expenses/show'
        else
            render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        render 'expenses/show'
    end

    def update 
        if @expense.status == "approved" || @expense.status == "completed"
            render json: { error: "Cannot update approved expense" }, status: :unprocessable_entity
        else
            if @expense.update(expense_params)
                render 'expenses/show'
            else
                render json: { error: @expense.errors.full_messages }, status: :unprocessable_entity
            end
        end
    end

    private
    
    def set_expense
        @expense = Expense.find_by(id: params[:id])

        if @expense
            return
        else
            render json: { error: "Expense not found" }, status: :not_found
        end
    end

    def expense_params
        params.require(:expense).permit(:site_id, :user_id, :amount, :scope, :status, :date)
    end

end