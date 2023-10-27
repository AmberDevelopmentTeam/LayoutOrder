local properties = {}
local module = {}

local function isTableEmpty(Table: {})
	return table.maxn(Table) == 0
end

function properties:Order()
	assert(self.layout:IsA("UIListLayout") or self.layout:IsA("UIGridLayout"), "uiListLayout is not valid")
	assert(typeof(self.attributeName) == "string", "attributeName is not valid")
	
	local orders = {}
	for index, order in self do
		if index == "uiListLayout" then continue end
		if index == "attributeName" then continue end
		orders[index] = order
	end
	
	assert(not isTableEmpty(orders))
	for _, child in self.layout.Parent:GetChildren() do
		if child:IsA("GuiBase") == false then continue end
		local attribute = child:GetAttribute(self.attributeName)
		
		child.LayoutOrder = if attribute then orders[attribute] else 0
	end
end

function module.new()
	local self = {}
	setmetatable(self, {__index = properties})
	
	self.layout = nil
	self.attributeName = nil
	
	return self
end

return module
