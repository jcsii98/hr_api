class Site < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    
    has_many :site_payslips
end
