json.(@klass, :id, :name)
json.sections do
  json.array! @klass.sections, :id, :name
end
