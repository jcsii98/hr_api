class ExpensesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_expense, only: [:show, :update, :destroy]

    def index
        start_date = params[:start_date].to_date
        end_date = params[:end_date].to_date

        Rails.logger.info("end_date value: #{end_date}")
        Rails.logger.info("Date according to Rails Timezone: #{Time.zone.today}")


        if end_date > Time.zone.today
            render json: { error: "End date is invalid, cannot be a future date." }, status: :unprocessable_entity
            return
        end

        if start_date > end_date
            render json: { error: "Start date cannot be after end date. Please select a valid date."}, status: :unprocessable_entity
            return
        end
        
        if params[:user_id].present? && !params[:user_id].blank?
            @user = User.find_by(id: params[:user_id])
            if params[:site_id].present? && !params[:site_id].blank?
                @site = Site.find_by(id: params[:site_id])
                if params[:scope].present? && !params[:scope].blank?
                    @expenses_within_range = @site.expenses.where(user_id: params[:user_id], date: start_date..end_date, scope: params[:scope])
                else
                    @expenses_within_range = @site.expenses.where(user_id: params[:user_id], date: start_date..end_date)
                end
            else
                @expenses_within_range = @user.expenses.where(date: start_date..end_date)
            end
        else
            if params[:site_id].present? && !params[:site_id].blank?
                @site = Site.find_by(id: params[:site_id])
                if params[:scope].present? && !params[:scope].blank?
                    @expenses_within_range = @site.expenses.where(date: start_date..end_date, scope: params[:scope])
                else
                    @expenses_within_range = @site.expenses.where(date: start_date..end_date)
                end
            else
                render json: { error: "site_id not provided" }, status: :unprocessable_entity
                return
            end
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

    def destroy
        if @expense.status == "approved" || @expense.status == "completed"
            render json: { error: "Cannot update approved expense" }, status: :unprocessable_entity
        else
            if @expense.destroy
                render json: { status: 'success', message: 'Expense has been deleted' }
            else
                render json: { status: 'error', errors: @expense.errors.full_messages }, status: :unprocessable_entity
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
        params.require(:expense).permit(:site_id, :user_id, :amount, :scope, :status, :date, :name)
    end

end
