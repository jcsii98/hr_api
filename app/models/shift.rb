class Shift < ApplicationRecord
    belongs_to :user
    belongs_to :user_payslip, optional: true
    belongs_to :site
    
    validates :photo_in, presence: true

    has_one_attached :photo_in
    has_one_attached :photo_out

    before_create :set_time_in_and_date

    def set_time_out_and_duration
        self.time_out = Time.now

        self.shift_duration = calculate_shift_duration
    end

    private

    def set_time_in_and_date
        self.time_in = created_at
        self.date = Date.current
    end

    def calculate_shift_duration
        if time_in.present? && time_out.present?
            (time_out - time_in).to_i.seconds
        else
            0.seconds
        end
    end

end
