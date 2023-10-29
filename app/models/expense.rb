class Expense < ApplicationRecord
    belongs_to :user
    belongs_to :site_payslip, optional: true
    belongs_to :site

    validates :name, presence: true
    validates :scope, presence: true
    validates :amount, presence: true
    validates :date, presence: true
    validate :date_not_in_future

    before_create :set_date

    private
    
    def set_date
        self.date = Date.current
    end

    def date_not_in_future
        if date.present? && date > Date.current
            errors.add(:date, "can't be a future date")
        end
    end
end
