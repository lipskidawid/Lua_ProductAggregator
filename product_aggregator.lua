local ProductAggregator = {
    products = {},
    sum = 0,
}

local function addWarrning(message) 
    ProductAggregator.warrning = ProductAggregator.warrning..message.."\n"
end

local function validElements(items) 
    for k, v in pairs(items) do
        -- add handling for negative prices
        if type(v.name) == "string" and type(v.price) == "number" and v.price > 0 then
            table.insert(ProductAggregator.products, {name = v.name, price = v.price})
        end
    end
end

local function sortByPrice()
    table.sort(ProductAggregator.products, function(a,b) return a.price > b.price end)
end

local function removeDuplicates()
    local hash = {}
    local res = {}

    for k, v in ipairs(ProductAggregator.products) do
        if not hash[v.name] then
            res[#res+1] = v
            hash[v.name] = true
            ProductAggregator.sum = ProductAggregator.sum + v.price
        end
    end

    local tmpProducts = {}
    for i = #res, 1, -1 do table.insert(tmpProducts, res[i]) end
    ProductAggregator.products = tmpProducts
end

function ProductAggregator:new(items)
    -- Valid product name and price
    validElements(items)
    -- Sort element by price
    sortByPrice()
    -- Remove duplicates
    removeDuplicates()
end

function ProductAggregator:getProduts()
    return self.products
end

function ProductAggregator:averagePrice()
    return self.sum/#self.products
end

return ProductAggregator
