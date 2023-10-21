class SitesController < ApplicationController
    before_action :authenticate_user!

    before_action :verify_kind, only: [:show, :update, :destroy]

    before_action :set_site, only: [:show, :update, :destroy]

    def index
        if current_user.kind == "user"
            @sites = Site.where(status: 'active')
        else
            case params[:status]
            when 'all'
                @sites = Site.all
            when 'archived'
                @sites = Site.where(status: 'archived')
            when 'active'
                @sites = Site.where(status: 'active')
            when 'hidden'
                @sites = Site.where(status: 'hidden')
            else 
                render json: { error: "Invalid status parameter" }, status: :bad_request
                return
            end
        render 'sites/index'
        end
    end

    def create
        @site = Site.new(site_params)

        if @site.save
            render json: @site, status: :created
        else
            render json: { error: @site.errors }, status: :unprocessable_entity
        end
    end

    def show
        render 'sites/show'
    end

    def update
        if @site.update(site_params)
            render 'sites/show'
        else
            render json: { error: @site.errors }, status: :unprocessable_entity
        end
    end
    
    def destroy
        if @site.status == 'archived'
            render json: { message: "already archived" }
        else
            if @site.update(status: 'archived')
                render json: { status: 'success', message: 'Site has been archived' }
            else
                render json: { status: 'error', errors: @site.errors.full_messages }
            end
        end
    end

    private
    def verify_kind
        user = current_user
        if current_user.kind == "admin"
            return
        else
            render json: { error: "User is unauthorized to access this resource" }, status: :unauthorized
        end
    end
    
    def site_params
        params.require(:site).permit(:name, :status)
    end

    def set_site
        @site = Site.find_by(id: params[:id])
        if @site
            return
        else
            render json: { error: "Site not found" }, status: :not_found
        end
    end
end