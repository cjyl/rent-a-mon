class ChangeTypeToElementInPokemons < ActiveRecord::Migration[7.0]
  def change
    rename_column :pokemons, :type, :element
  end
end
