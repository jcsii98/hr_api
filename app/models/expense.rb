class Expense < ApplicationRecord
    belongs_to :user
    belongs_to :site_payslip, optional: true
    belongs_to :site

    validates :name, presence: true
    validates :scope, presence: true
    validates :amount, presence: true
    validates :date, presence: true
    validate :date_not_in_future

    private

    def date_not_in_future
        if date.present? && date > Date.current
            errors.add(:date, "can't be a future date")
        end
    end
end
