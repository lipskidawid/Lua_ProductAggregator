local ProductAggregator = {
    products = {},
    sum = 0,
}

local function validElements(self, items) 
    for k, v in pairs(items) do
        -- add handling for negative prices
        if type(v.name) == "string" and type(v.price) == "number" and v.price > 0 then
            table.insert(self.products, {name = v.name, price = v.price})
        end
    end
end

local function sortByPrice(self)
    table.sort(self.products, function(a,b) return a.price > b.price end)
end

local function removeDuplicates(self)
    local hash = {}
    local res = {}

    for k, v in ipairs(self.products) do
        if not hash[v.name] then
            res[#res+1] = v
            hash[v.name] = true
            self.sum = self.sum + v.price
        end
    end

    local tmpProducts = {}
    for i = #res, 1, -1 do table.insert(tmpProducts, res[i]) end
    self.products = tmpProducts
end

function ProductAggregator:new(items)
    -- Valid product name and price
    validElements(self, items)
    -- Sort element by price
    sortByPrice(self)
    -- Remove duplicates
    removeDuplicates(self)
end

function ProductAggregator:getProduts()
    return self.products
end

function ProductAggregator:averagePrice()
    return self.sum/#self.products
end

return ProductAggregator
