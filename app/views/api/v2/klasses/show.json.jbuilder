json.(@klass, :id, :name, :section_ids)
json.sections do
  json.array! @klass.sections, :id, :name
end
