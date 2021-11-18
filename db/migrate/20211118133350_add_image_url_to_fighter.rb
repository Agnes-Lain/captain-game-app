class AddImageUrlToFighter < ActiveRecord::Migration[6.1]
  def change
    add_column :fighters, :img_url, :string, :default => "https://avatarfiles.alphacoders.com/161/thumb-161319.jpg"
  end
end
