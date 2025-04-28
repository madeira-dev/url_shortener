class RenameUrlColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :urls, :originalUrl, :original_url
    rename_column :urls, :accessCount, :access_count
  end
end
