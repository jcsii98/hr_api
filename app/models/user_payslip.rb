class UserPayslip < ApplicationRecord
    belongs_to :user

    has_many :user_payslip_shifts
    has_many :shifts, through: :user_payslip_shifts

    validates :week_start, presence: true
    validates :week_end, presence: true
    before_create :set_date

    after_create :update_shifts_status_to_completed
    
    def calculate_amount
        # total duration is in seconds, divide by 3600 for hour format
        self.total_duration = shifts.sum(&:shift_duration) / 3600
        self.amount = total_duration * user.personal_rate

        if self.cash_advance.nil?
            self.amount = total_duration * user.personal_rate
        else
            self.amount = total_duration * user.personal_rate - cash_advance
        end
    end

    def update_shifts_status_to_completed
        shifts.update_all(status: 'completed')
    end

    private

    def set_date
        self.date = Date.current
    end
    
end
