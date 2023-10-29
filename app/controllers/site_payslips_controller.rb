class SitePayslipsController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_kind
    before_action :set_site, only: [:index, :create]
    before_action :find_payslip, only: [:show]

    def index
        if params[:user_id].present? && !params[:user_id].blank?
            @sitePayslips = @site.site_payslips.where(user_id: params[:user_id])
        else
            @sitePayslips = @site.site_payslips
        end
        render 'site_payslips/index'
    end

    def create
        @sitePayslip = current_user.site_payslips.new(site_payslip_params)
        @sitePayslip.site = @site  # Associate the payslip with the site

        expenses_within_range = Expense.where(date: @sitePayslip.week_start..@sitePayslip.week_end, site_id: @site.id)

        if params[:scope].present? && !params[:scope].blank?
            approved_expenses = expenses_within_range.where(status: 'approved', scope: params[:scope])
        else
            approved_expenses = expenses_within_range.where(status: 'approved')
        end

        @sitePayslip.expenses = approved_expenses

        @sitePayslip.calculate_amount

        if @sitePayslip.save
            render 'site_payslips/create'
        else
            render json: { error: @sitePayslip.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        if @sitePayslip
            render 'site_payslips/show'
        else
            render json: { error: "Cannot find payslip" }
        end
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

    def set_site
        @site = Site.find_by(id: params[:site_id])
        unless @site
            render json: { error: "Site not found" }, status: :not_found
        end
    end

    def find_payslip
        @sitePayslip = SitePayslip.find_by(id: params[:id])
    end

    def site_payslip_params
        params.require(:site_payslip).permit(:week_start, :week_end)
    end
end
