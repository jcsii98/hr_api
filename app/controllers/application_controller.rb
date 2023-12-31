class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken

        before_action :configure_permitted_parameters, if: :devise_controller?

        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:kind, :first_name, :middle_name, :last_name, :philhealth, :pagibig, :tin, :personal_rate, :birthday, :status])
        end
end
