class SitePayslip < ApplicationRecord
    belongs_to :user
    belongs_to :site
    has_many :site_payslip_expenses
    has_many :expenses, through: :site_payslip_expenses

    validates :week_start, presence: true
    validates :week_end, presence: true
    before_create :set_date

    after_create :update_expenses_status_to_completed

    def calculate_amount
        total_amount = expenses.sum(&:amount)
        self.amount = total_amount
    end

    def update_expenses_status_to_completed
        expenses.update_all(status: 'completed')
    end

    private
    
    def set_date
       self.date = Date.current 
    end

end
