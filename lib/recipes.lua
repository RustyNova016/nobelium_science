local Public = {}

---Get a specific result from the recipe
---@param recipe data.RecipePrototype
---@param type string
---@param name string
---@return data.ProductPrototype?
function Public.get_result(recipe, type, name)
    for _, result in pairs(recipe.results) do
        if result.type == type and result.name == name then
            return result
        end
    end
end

---Add a result to the recipe
---@param recipe data.RecipePrototype
---@param result data.ProductPrototype
function Public.add_result(recipe, result) 
    table.insert(recipe.results, result)
end

return Public