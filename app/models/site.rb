class Site < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    
    has_many :site_payslips
    has_many :expenses
end
