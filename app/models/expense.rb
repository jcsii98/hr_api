class Expense < ApplicationRecord
    belongs_to :user
    belongs_to :site_payslip, optional: true
    belongs_to :site

    validates :name, presence: true
    validates :scope, presence: true
    validates :amount, presence: true
    validates :date, presence: true
    
    before_validation :set_default_date, on: :create
    private

    def set_default_date
        self.date ||= Date.current
    end
end
