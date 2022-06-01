class AddImagePathToPokemons < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :image_path, :string
  end
end
