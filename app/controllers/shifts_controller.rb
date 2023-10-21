class ShiftsController < ApplicationController
    before_action :authenticate_user!

    before_action :set_shift, only: [:show, :update, :destroy]
    
    def index
        if current_user.kind == "user" 
            @shifts = current_user.shifts
        else
            start_date = params[:start_date].to_date
            end_date = params[:end_date].to_date
            
            @shifts_within_range = Shift.where(date: start_date..end_date)

            case params[:status]
            when 'all'
                @shifts = @shifts_within_range
            when 'approved'
                @shifts = @shifts_within_range.where(status: 'approved')
            when 'pending'
                @shifts = @shifts_within_range.where(status: 'pending')
            when 'rejected'
                @shifts = @shifts_within_range.where(status: 'rejected')
            when 'completed' 
                @shifts = @shifts_within_range.where(status: 'completed')
            else
                render json: { error: "Invalid status parameter" }, status: :bad_request
                return
            end
    
            if params[:user_id].present?
                @shifts = @shifts.where(user_id: params[:user_id])
            else
                render json: { error: "user_id not present" }, status: :unprocessable_entity
            end
        end
        render 'shifts/index'
    end

    def create
        @shift = current_user.shifts.build(shift_create_params)

        @site = Site.find_by(id: shift_create_params[:site_id])

        if @site.nil?
            render json: { error: "Site not found" }, status: :not_found
            return
        end

        @shift.site = @site

        if @shift.valid?
            @shift.save
            render json: @shift, status: :created
        else
            render json: { errors: @shift.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        render 'shifts/show'
    end

    def update
        if current_user.kind == "user"
            if @shift.status == "approved"
                render json: { error: "Cannot edit approved shift" }, status: :forbidden
            else
                if params[:shift].key?(:photo_out)
                    if @shift.update(shift_update_params)
                        @shift.set_time_out_and_duration
                        @shift.save!
                        render json: @shift, status: :ok
                    else
                        render json: { error: @shift.errors.full_messages }, status: :unprocessable_entity
                    end
                else
                    render json: { error: "Photo_out parameter is missing" }, status: :bad_request
                end
            end
        else
            if @shift.shift_duration.nil?
                render json: { error: "Cannot approve shift without duration" }, status: :unprocessable_entity
            else
                if @shift.update(admin_shift_params)
                    render json: @shift, status: :ok
                else
                    render json: { error: @shift.errors.full_messages }, status: :unprocessable_entity
                end
            end
        end
    end

    def destroy
        if @shift.destroy
            render json: { status: 'success', message: 'Shift deleted' }
        else
            render json: { status: 'error', errors: @shift.errors.full_messages }
        end
    end

    private

    def set_shift
        @shift = Shift.find_by(id: params[:id])
        
        if @shift
            return
        else
            render json: { error: "Shift not found" }, status: :not_found
        end
    end

    def shift_create_params
        params.require(:shift).permit(:photo_in, :site_id)
    end

    def shift_update_params
        params.require(:shift).permit(:photo_out)
    end

    def admin_shift_params
        params.require(:shift).permit(:status)
    end
end
