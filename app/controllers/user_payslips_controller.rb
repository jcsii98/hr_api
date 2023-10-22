class UserPayslipsController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_kind
    before_action :set_user, only: [:index, :create]

    def index
        @userPayslips = @user.user_payslips

        render 'user_payslips/index'
    end

    def create
        @userPayslip = @user.user_payslips.new(user_payslip_params)

        shifts_within_range = Shift.where(date: @userPayslip.week_start..@userPayslip.week_end, user_id: @user.id)

        approved_shifts = shifts_within_range.where(status: 'approved')

        @userPayslip.shifts = approved_shifts

        @userPayslip.calculate_amount

        # debugging

        Rails.logger.debug("User Payslip Computation - Week Start: #{@userPayslip.week_start}, Week End: #{@userPayslip.week_end}")
        Rails.logger.info("User Personal Rate: #{@user.personal_rate}")
        Rails.logger.info("Total Hours: #{@userPayslip.total_duration}")
        Rails.logger.debug("Computed Amount: #{@userPayslip.amount}")


        if @userPayslip.save
            render 'user_payslips/create'
        else
            render json: { error: @userPayslip.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        @userPayslip = UserPayslip.find_by(id: params[:id])
        if @userPayslip
            render 'user_payslips/show'
        else 
            render json: { error: "Cannot find payslip" }
        end
    end

    def destroy

    end

    private

    def verify_kind
        user = current_user
        if user.kind == "admin"
            return
        else
            render json: { error: "You are unauthorized to access this resource" }, status: :unauthorized
        end
    end

    def set_user
        @user = User.find_by(id: params[:id])
        if @user
            return
        else
            render json: { error: "User not found" }, status: :not_found
        end
    end

    def user_payslip_params
        params.require(:user_payslip).permit(:week_start, :week_end, :cash_advance)
    end

end