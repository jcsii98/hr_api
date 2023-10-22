class Expense < ApplicationRecord
    belongs_to :user
    belongs_to :site_payslip, optional: true
    belongs_to :site

    validates :scope, presence: true
    validates :amount, presence: true
    
    before_create :set_date

    private
    
    def set_date
        self.date = Date.current
    end
end
