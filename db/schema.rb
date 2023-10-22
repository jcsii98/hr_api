# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_22_035220) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.text "provider", default: "email", null: false
    t.text "uid", default: "", null: false
    t.text "encrypted_password", default: "", null: false
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.text "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text "unconfirmed_email"
    t.text "full_name"
    t.text "nickname"
    t.text "profile_picture"
    t.text "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "site_id"
    t.integer "amount"
    t.text "scope"
    t.date "date"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "name"
    t.index ["site_id"], name: "index_expenses_on_site_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "site_id"
    t.datetime "time_in"
    t.datetime "time_out"
    t.text "photo_in"
    t.text "photo_out"
    t.integer "shift_duration"
    t.date "date"
    t.text "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_shifts_on_site_id"
    t.index ["user_id"], name: "index_shifts_on_user_id"
  end

  create_table "site_payslip_expenses", force: :cascade do |t|
    t.bigint "site_payslip_id"
    t.bigint "expense_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_site_payslip_expenses_on_expense_id"
    t.index ["site_payslip_id"], name: "index_site_payslip_expenses_on_site_payslip_id"
  end

  create_table "site_payslips", force: :cascade do |t|
    t.bigint "site_id"
    t.date "week_start"
    t.date "week_end"
    t.date "date"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_site_payslips_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.text "name"
    t.text "status", default: "hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_payslip_shifts", force: :cascade do |t|
    t.bigint "user_payslip_id"
    t.bigint "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_user_payslip_shifts_on_shift_id"
    t.index ["user_payslip_id"], name: "index_user_payslip_shifts_on_user_payslip_id"
  end

  create_table "user_payslips", force: :cascade do |t|
    t.bigint "user_id"
    t.date "week_start"
    t.date "week_end"
    t.date "date"
    t.integer "amount"
    t.integer "cash_advance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_duration"
    t.index ["user_id"], name: "index_user_payslips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "provider", default: "email", null: false
    t.text "uid", default: "", null: false
    t.text "encrypted_password", default: "", null: false
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.text "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text "unconfirmed_email"
    t.text "kind"
    t.text "full_name"
    t.text "profile_picture"
    t.text "email"
    t.integer "personal_rate"
    t.date "birthday"
    t.text "status", default: "pending"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "expenses", "sites"
  add_foreign_key "expenses", "users"
  add_foreign_key "shifts", "sites"
  add_foreign_key "shifts", "users"
  add_foreign_key "site_payslip_expenses", "expenses"
  add_foreign_key "site_payslip_expenses", "site_payslips"
  add_foreign_key "site_payslips", "sites"
  add_foreign_key "user_payslip_shifts", "shifts"
  add_foreign_key "user_payslip_shifts", "user_payslips"
  add_foreign_key "user_payslips", "users"
end
