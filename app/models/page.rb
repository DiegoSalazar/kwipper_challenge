class Page < Model
  column :slug, :to_s
  column :title, :to_s
  column :body, :to_s
  column :created_at, :to_s
  column :position, :to_i
end
