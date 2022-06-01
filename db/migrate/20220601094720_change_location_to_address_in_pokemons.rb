class ChangeLocationToAddressInPokemons < ActiveRecord::Migration[7.0]
  def change
    rename_column :pokemons, :location, :address
  end
end
