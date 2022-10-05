class CreateTalkThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :talk_themes do |t|
      t.string :content, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
