# This migration comes from rails_url_shortener (originally 20250508120951)
class AddRefererToVistis < ActiveRecord::Migration[7.0]
  def change
    add_column :rails_url_shortener_visits, :referer, :string, default: ""
  end
end
