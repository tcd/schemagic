class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table(:users) do |t|
      t.string(:email_address, null: false, index: { unique: true })
      t.string(:phone_number)
      t.integer(:age_in_years)
      t.datetime(:date_of_birth)
      t.datetime(:datetime_of_birth)
      t.timestamps()
    end
  end
end
